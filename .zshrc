# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git direnv rust pip thefuck git-commit)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Atuin
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# Jupyter 
export PATH="$PATH:~/.local/bin"

# Deno 
export PATH="$HOME/.local/bin:$PATH"
export DENO_INSTALL="$HOME/.deno"

# Node
export PATH="/opt/homebrew/opt/node@20/bin:$PATH"

# Nice syntax highlighting, QOL
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Not totally sure?
export PATH="$HOME/.cargo/bin:$PATH"

# Kitty-specific 
# For gnuplot support
function iplot {
    cat <<EOF | gnuplot
    set terminal pngcairo enhanced font 'Fira Sans,10'
    set autoscale
    set samples 1000
    set output '|kitten icat --stdin yes'
    set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb"#fdf6e3" behind
    plot $@
    set output '/dev/null'
EOF
}

# Search history via grep e.g. `hgrep 'ssh'`
alias hgrep='history | grep'

# Source the `.zshrc` e.g. `reload`
alias reload='source ~/.zshrc'

# Alias that cd's to dotfiles
alias dot='cd ~/.dotfiles'

# Alias that cd's to ~/Coding
alias dev='cd ~/Developer'

# uv shell completions
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# Get last short hash
alias shorthash='git rev-parse --short HEAD | tr -d '\n' | tee >(pbcopy)'
export PATH="/opt/homebrew/Cellar/zigup/2025.01.02/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/isaacchasse/.lmstudio/bin"

# Enable ZSH-Autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Set default editor to neovim
export EDITOR="nvim"

# fzf settings
export FZF_DEFAULT_OPTS='
  --color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
  --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54
'

# AWS profile switcher with SSO login by default
function profile() {
    # check that there is a config file
    local aws_config_file="$HOME/.aws/config"
    
    # ensure AWS config exists
    if [[ ! -f "$aws_config_file" ]]; then 
        echo "AWS config file not found at $aws_config_file"
        return 1
    fi

    # pick a profile via fzf
    local choice 
    choice=$(aws configure list-profiles | fzf --prompt "Choose active AWS profile:") || return
    export AWS_PROFILE="${choice:-default}"

    # propogate any custom env_name
    local env_name
    env_name=$(aws configure get env_name --profile "$AWS_PROFILE")
    export ENV_NAME="$env_name"

    # if a user asked to skip a login
    if [[ "$1" == "--no-login" || "$1" == "-n" ]]; then
        echo "Skipping SSO login for profile: $AWS_PROFILE"
        return
    fi

    # check whether credentials are still valid
    if aws sts get-caller-identity --profile "$AWS_PROFILE" >/dev/null 2>&1; then
        echo "AWS credentials valid for profile: $AWS_PROFILE"
    else 
        echo "Logging in to AWS SSO for profile: $AWS_PROFILE"
        aws sso login --profile "$AWS_PROFILE"
    fi
}

# usage: 
#   profile             -> switch profile and login via SSO
#   profile --no-login  -> switch profile only
#           -n 

# prompt (optional): show current AWS env and profile at the right
#   uses oh-my-zsh btw
function aws_prof {
  # don’t show for default or unset
  [[ -z "$AWS_PROFILE" || "$AWS_PROFILE" == default ]] && return

  local env="${ENV_NAME:-none}"
  echo "%{$fg_bold[blue]%}aws:(%{$fg[yellow]%}${AWS_PROFILE}@${env}%{$fg_bold[blue]%})"
}

RPROMPT='$(aws_prof)'

# Alias to activate a venv
alias activate="source .venv/bin/activate"

# opencode
export PATH=/Users/ike/.opencode/bin:$PATH

# zoxide
eval "$(zoxide init zsh)"
