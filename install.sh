#!/bin/bash

# Run this install script to setup global commands and move other files to their required directories.

if [[ "$EUID" -ne 0 ]]; then 
    echo "Please run as root."
    exit
fi

git submodule update --init --recursive

sudo ./ProblemManager/install.sh

files=(
    ".zshrc"
    ".tmux.conf"
    "git/.gitconfig"
    ".zprofile"
)

for file in "${files[@]}"; do
    if ! [[ -f "~/$file" ]]; then
        ln $file ~/$file
    fi
done

for file in "scripts"/*; do
    if [[ -f "$file" ]]; then
        filename=$(basename "$file")
        sudo scripts/bin_link.sh $file $filename
    fi
done

echo "Done!"
