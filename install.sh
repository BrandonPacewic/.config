#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then 
    echo "Please run as root."
    exit
fi

git submodule update --init

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

python -m pip install branp-cli/

for file in "scripts"/*; do
    if [[ -f "$file" ]]; then
        filename=$(basename "$file")
        sudo scripts/bin_link.sh $file $filename
    fi
done

echo "Done!"
