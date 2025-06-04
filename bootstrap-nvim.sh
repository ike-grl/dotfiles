#!/bin/bash
set -euo pipefail

# Define paths
CONFIG_DIR="$HOME/.config/nvim"
DOTFILES_DIR="$HOME/.dotfiles/nvim"

echo "Bootstrapping nvim config"

# Create the config directory if it doesn't exist
mkdir -p "$HOME/.config"

# Remove any existing nvim config (file or symlink)
if [ -e "$CONFIG_DIR" ] || [ -L "$CONFIG_DIR" ]; then
    echo "Removing existing $CONFIG_DIR"
    rm -rf "$CONFIG_DIR"
fi

# Create the symlink
ln -s "$DOTFILES_DIR" "$CONFIG_DIR"

echo "Symlink created: $CONFIG_DIR -> $DOTFILES_DIR"
echo "Please run `nvim` to get started!"
