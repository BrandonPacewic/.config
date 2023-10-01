export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel9k/powerlevel9k"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh
export EDITIOR="code"

plugins=(
	git
)

OS_ICON=''
POWERLEVEL9k_MODE='awesome-patched'
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_beginning
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

alias updatesource='source ~/.zshrc'
alias vi='nvim "$@"'
alias cp='cp -v'
alias rm='rm -iv'
alias mv='mv -iv'
alias rmdir='rm -vrf'
alias gitclean='git clean -xdf'
alias gitca='git commit --amend --no-edit'
alias repos='cd ~/Documents/Repos'

alias ll='ls -la'
alias la='ls -A'
alias l='ls -F'
command -v lsd > /dev/null && alias ls='lsd --group-dirs first' && \
	alias tree='lsd --tree'
command -v colorls > /dev/null && alias ls='colorls --sd --gs' && \
	alias tree='colorls --tree'

export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
export PATH="$HOME/Library/Python/3.11/bin:$PATH"
