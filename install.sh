#!/bin/bash

set -e

if [[ "$EUID" -ne 0 ]]; then 
    echo "Please run as root."
    exit 1
fi

git submodule update --init

for file in "zsh" "tmux" "git" "brew"; do
    stow --verbose --target="$HOME" --restow "$file"
done

brew bundle install --file=Brewfile
python -m pip install branp-cli/

echo "Done!"
