#!/bin/bash

echo "Setting up your Mac "

# Check for Oh My Zsh and install it if we don't have it
if test ! "$(which omz)"; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install it if we don't have it
if test ! "$(which brew)"; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo "eval '$(/opt/homebrew/bin/brew shellenv)'" >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Symlinks the .zshrc to the .dotfiles
ln -sw "$HOME/.zshrc" "$HOME/.dotfiles/.zshrc"

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file ./Brewfile

# Create a projects directories
mkdir "$HOME/Coding"

# Create Code subdirectories
mkdir "$HOME/Coding/Andi"
mkdir "$HOME/Coding/Valkyrie"
mkdir "$HOME/Coding/Quantike"

# Install some of the manual things here
#
# Atuin
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

# uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Run this last to source ZSH changes and reload the shell
source ./.zshrc
