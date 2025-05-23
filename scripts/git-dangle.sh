#!/usr/bin/env bash
# Run this from the parent folder that holds all your projects

echo "Scanning $(pwd)..."
echo

for dir in */; do
    # case: folder isn't a git repo
    if [ ! -d "dir/.git" ]; then
        echo "🚫 $dir - not a Git repo (code here isn't tracked on GitHub)"
        continue
    fi
done
