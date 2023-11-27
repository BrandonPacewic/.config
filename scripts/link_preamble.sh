#!/bin/bash

if ! [[ -f ~/.config/latex/preamble.tex ]]; then
    echo "preamble.tex not found in ~/.config"
    exit 1
fi

if [ -f ./preamble.tex ]; then
    rm ./preamble.tex
    echo "Removed old preamble.tex."
fi

ln ~/.config/latex/preamble.tex ./preamble.tex
echo "Linked preamble.tex to current directory."
