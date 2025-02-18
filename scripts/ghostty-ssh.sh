#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

#/ Usage: ./execute_tic.sh [--interactive | --all | --host <host>] [--exclude <host1> <host2> ...]
#/ Description: Executes infocmp -x | ssh YOUR-SERVER -- tic -x - for specified SSH hosts.
#/ Examples:
#/   ./execute_tic.sh --interactive
#/   ./execute_tic.sh --all
#/   ./execute_tic.sh --host YOUR-SERVER
#/   ./execute_tic.sh --all --exclude host1 host2
#/ Options:
#/   --help: Display this help message
#/   --interactive: Prompt user for each host
#/   --all: Execute command for all hosts
#/   --host: Execute command for a single host
#/   --exclude: Exclude specified hosts

# Display usage information extracted from the comments above.
usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }

# Check if any argument is --help and display usage if so.
for arg in "$@"; do
  if [[ "$arg" == "--help" ]]; then
    usage
  fi
done

readonly LOG_FILE="/tmp/$(basename "$0").log"
info()    { echo "[INFO]    $*" | tee -a "$LOG_FILE" >&2 ; }
warning() { echo "[WARNING] $*" | tee -a "$LOG_FILE" >&2 ; }
error()   { echo "[ERROR]   $*" | tee -a "$LOG_FILE" >&2 ; }
fatal()   { echo "[FATAL]   $*" | tee -a "$LOG_FILE" >&2 ; exit 1 ; }

# Check for required dependencies.
for cmd in infocmp tic ssh awk; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        fatal "Required command '$cmd' not found."
    fi
done

# Cleanup function; register trap immediately so it runs on any exit.
cleanup() {
    # Perform any necessary cleanup here
    info "Cleanup completed."
}
trap cleanup EXIT

# Parse command-line arguments.
interactive_mode=false
force_all=false
exclude_hosts=()
single_host=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --interactive)
      interactive_mode=true
      ;;
    --all)
      force_all=true
      ;;
    --host)
      shift
      if [[ $# -eq 0 ]]; then
          fatal "Missing argument for --host"
      fi
      single_host="$1"
      ;;
    --exclude)
      shift
      while [[ $# -gt 0 && "$1" != --* ]]; do
        exclude_hosts+=("$1")
        shift
      done
      # Continue to the next iteration without shifting here.
      continue
      ;;
    *)
      usage
      ;;
  esac
  shift
done

# Validate conflicting options.
if [[ "$interactive_mode" == true && "$force_all" == true ]]; then
    fatal "Conflicting options: --interactive and --all cannot be used together."
fi

# Function to check if a given host should be excluded.
is_excluded() {
    local host_to_check="$1"
    for ex in "${exclude_hosts[@]}"; do
        if [[ "$host_to_check" == "$ex" ]]; then
            return 0  # true: host is excluded
        fi
    done
    return 1  # false: host is not excluded
}

# Function to execute the command for a given host.
execute_command() {
    local target_host="$1"
    info "Executing command for $target_host"
    infocmp -x | ssh "$target_host" -- tic -x -
}

# If a single host is specified, run in single-host mode.
if [[ -n "$single_host" ]]; then
  if is_excluded "$single_host"; then
    warning "Excluding $single_host"
  else
    info "Executing command for $single_host (single-host mode)"
    execute_command "$single_host"
  fi
  exit 0
fi

# Read the SSH config file.
config_file="$HOME/.ssh/config"
if [[ ! -f "$config_file" ]]; then
  fatal "SSH config file not found at $config_file"
fi

# Extract hosts from the config file.
# This handles multiple hosts per 'Host' line and excludes wildcard entries.
mapfile -t hosts < <(awk '/^Host / {
    for (i = 2; i <= NF; i++) {
      if ($i != "*") {
        print $i
      }
    }
}' "$config_file")

if [[ ${#hosts[@]} -eq 0 ]]; then
    warning "No hosts found in SSH config."
    exit 0
fi

# Loop through each host and execute the command based on the selected mode.
for host in "${hosts[@]}"; do
  if is_excluded "$host"; then
      warning "Excluding $host"
      continue
  fi

  if [[ "$force_all" == true ]]; then
      info "Executing command for $host (force all mode)"
      execute_command "$host"
  elif [[ "$interactive_mode" == true ]]; then
      read -r -p "Execute command for $host? (y/n): " response
      case "$response" in
          [Yy]* )
              execute_command "$host"
              ;;
          [Nn]* )
              info "Skipping $host"
              ;;
          * )
              warning "Invalid response, skipping $host"
              ;;
      esac
  else
      info "Executing command for $host (default mode)"
      execute_command "$host"
  fi
done

exit 0

