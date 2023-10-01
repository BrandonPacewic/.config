chmod u+x $1

if ! [[ -f $1 ]]; then
    sudo ln $1 /usr/local/bin/$2
    echo "Linked $2 to bin."
else
    echo "$2 already exists in bin."
fi
