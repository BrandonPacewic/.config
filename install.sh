# Run this install script to setup global commands and move other files to their required directories.

read -r -p "This script requires root permissions, please acknowledge that it is being run as root. [y|n]: "
if ! [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborting"
    exit 1
fi

if ! [[ -f "../.zshrc" ]]; then
    ln .zshrc ../.zshrc
fi

for file in "scripts"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        sudo scripts/bin_link.sh $file $filename
    fi
done

echo "Done!"
