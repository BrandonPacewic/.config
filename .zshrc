export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel9k/powerlevel9k"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"

plugins=(
	git
)

source $ZSH/oh-my-zsh.sh

OS_ICON=''
POWERLEVEL9k_MODE='awesome-patched'
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_beginning
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

unsetopt autocd

cdpath=(
	$cdpath
	$HOME
	$HOME/Documents
	$HOME/Documents/Repos
	$HOME/Documents/MainForks
)

if (( $+commands[nvim] )); then
	alias vi='nvim "$@"'
	export EDITOR='nvim'
else
	export EDITOR='vi'
fi

alias cp='cp -v'
alias rm='rm -iv'
alias mv='mv -iv'
alias rmdir='rm -vrf'

alias ll='ls -la'
alias la='ls -A'
alias l='ls -F'

command -v lsd > /dev/null && alias ls='lsd --group-dirs first' && \
	alias tree='lsd --tree'
command -v colorls > /dev/null && alias ls='colorls --sd --gs' && \
	alias tree='colorls --tree'

alias tmr='tmux respawn-pane -k'

if command -v tmux &> /dev/null && [[ -z "$TMUX" ]]; then
	tmux attach -t default || tmux new -s default
fi

export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
export PATH="$HOME/Library/Python/3.11/bin:$PATH"
