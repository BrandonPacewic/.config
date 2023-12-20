ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

if [[ -f ~/.p10k.zsh ]]; then
	source ~/.p10k.zsh
fi

POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_beginning

POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION="$(whoami | grep -v '^root\$'):"
POWERLEVEL9K_OS_ICON_FOREGROUND=255
POWERLEVEL9K_OS_ICON_BACKGROUND=

POWERLEVEL9K_DIR_FOREGROUND=46
POWERLEVEL9K_DIR_BACKGROUND=
typeset -g POWERLEVEL9K_DIR_{HOME,HOME_SUBFOLDER,ETC,DEFAULT}_FOREGROUND=46
typeset -g POWERLEVEL9K_DIR_{HOME,HOME_SUBFOLDER,ETC,DEFAULT}_BACKGROUND=

typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=255
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_BACKGROUND=
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=255
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_BACKGROUND=

typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_{VIINS,VICMD,VIVIS,VIOWR}_CONTENT_EXPANSION='$'
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=''

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir prompt_char)
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
	export EDITOR='nvim'
	alias vi='nvim "$@"'
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
alias tmks='tmux kill-session'
alias tmka='tmux kill-server'
alias tmo='tmux detach'

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

clr() {
	command clear
}

clear() {
	command clear
	command neofetch
}

rst() {
	cd
	clr
}

if command -v tmux &> /dev/null && [[ -z "$TMUX" ]]; then
	tmux attach -t default || tmux new -s default
fi

neofetch
