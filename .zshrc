export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel9k/powerlevel9k"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

POWERLEVEL9K_MODE=awesome-patched

POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
POWERLEVEL9K_PROMPT_ON_NEWLINE=false
POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_beginning

OS_ICON=''
POWERLEVEL9K_OS_ICON_BACKGROUND=000
POWERLEVEL9K_OS_ICON_FOREGROUND=007

POWERLEVEL9K_DIR_BACKGROUND=196
POWERLEVEL9K_DIR_HOME_BACKGROUND=196
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=196
POWERLEVEL9K_DIR_ETC_BACKGROUND=196
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=196
POWERLEVEL9K_DIR_FOREGROUND=000
POWERLEVEL9K_DIR_HOME_FOREGROUND=000
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND=000
POWERLEVEL9K_DIR_ETC_FOREGROUND=000
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND=000
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND=000

POWERLEVEL9K_VCS_CLEAN_BACKGROUND=000
POWERLEVEL9K_VCS_CLEAN_FOREGROUND=007
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=000
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=007
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=000
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=007
POWERLEVEL9K_VCS_UNSTAGED_BACKGROUND=000
POWERLEVEL9K_VCS_UNSTAGED_FOREGROUND=007
POWERLEVEL9K_VCS_INCOMING_CHANGES_BACKGROUND=196
POWERLEVEL9K_VCS_INCOMING_CHANGES_FOREGROUND=007
POWERLEVEL9K_VCS_OUTGOING_CHANGES_BACKGROUND=000
POWERLEVEL9K_VCS_OUTGOING_CHANGES_FOREGROUND=007

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
alias tmka='tmux kill-server'
alias tmo='tmux detach'

if command -v tmux &> /dev/null && [[ -z "$TMUX" ]]; then
	tmux attach -t default || tmux new -s default
fi

tmn() {
	if [[ $# = 0 ]]; then
		tmux attach -t default || tmux new -s default
	else
		tmux new -s "$@"
	fi
}

find() {
	if [[ $# = 1 ]]; then
		command find . -name "$1"
	else
		command find "$@"
	fi
}

btt() {
	if ! (( $+commands[blueutil] )); then
		echo "blueutil not found"
		return 1
	fi

	power_status=$(blueutil | awk '/Power:/ {print $2}')

	if [[ $power_status -eq 0 ]]; then
		blueutil -p 1
		echo "Bluetooth turned on"
	else
		blueutil -p 0
		echo "Bluetooth turned off"
	fi
}

clear() {
	command clear
	command neofetch
}

neofetch

export PATH="$PATH:$HOME/Library/Python/3.11/bin"
