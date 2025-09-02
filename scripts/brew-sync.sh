#!/bin/bash
set -e

echo "Checking Brewfile dependencies..."

# Check if all dependencies are installed
if ! brew bundle check --quiet; then
    echo "Missing dependencies found. Installing..."
    brew bundle install
    echo "All dependencies installed"
else
    echo "All dependencies up to date"
fi

# Update Brewfile with any new packages
echo "Updating Brewfile..."
brew bundle dump --force --describe
echo "Brewfile updated"