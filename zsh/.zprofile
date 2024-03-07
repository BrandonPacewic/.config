eval "$(/opt/homebrew/bin/brew shellenv)"

export ZSH="$HOME/.oh-my-zsh"
export MANPATH="/opt/local/share/man:$MANPATH"
export PATH="$PATH:/opt/local/bin:/opt/local/sbin"
export PATH="$PATH:$HOME/Library/Python/3.11/bin"
export PATH="$PATH:$HOME/.cargo/env"
export PATH="$PATH:/opt/homebrew/opt/llvm/bin"

export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
