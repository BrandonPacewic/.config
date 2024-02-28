ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

emulate -L zsh -o extended_glob
unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

if [[ $ZSH_ZERSION != (5.<1->*|<6->.*) ]]; then
	POWERLEVEL9K_MODE=ascii
	POWERLEVEL9K_ICON_PADDING=none

	POWERLEVEL9K_BACKGROUND=0
	typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=
	typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '
	typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=

	POWERLEVEL9K_ICON_BEFORE_CONTENT=true
	POWERLEVEL9K_PROMPT_ADD_NEWLINE=false

	POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
	POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=

	POWERLEVEL9K_SHOW_RULER=false

    POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=' '
    POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL=' '
    POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_FIRST_SEGMENT_END_SYMBOL='%{%}'
    POWERLEVEL9K_EMPTY_LINE_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='%{%}'

	POWERLEVEL9K_SHORTEN_STRATEGY=truncate_beginning
	POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER=false
	POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
	POWERLEVEL9K_DIR_MAX_LENGTH=80
	POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40
	POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=50
	POWERLEVEL9K_DIR_HYPERLINK=false
	POWERLEVEL9K_DIR_SHOW_WRITABLE=v3

	POWERLEVEL9K_DIR_CLASSES=()

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

	POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true
	POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
	POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=

	POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir prompt_char)
	POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

	POWERLEVEL9K_TRANSIENT_PROMPT=off
	POWERLEVEL9K_INSTANT_PROMPT=off

	POWERLEVEL9K_DISABLE_HOT_RELOAD=true

	(( !$+functions[p10k] )) || p10k reload
fi

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'

unsetopt autocd
cdpath=($cdpath $HOME $HOME/Documents $HOME/Documents/Repos $HOME/Documents/MainForks)

if (( $+commands[nvim] )); then
	export EDITOR='nvim'
	alias vi='nvim "$@"'
	alias vim='nvim "$@"'
else
	export EDITOR='vi'
fi

export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR

alias cp='cp -v'
alias rm='rm -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias rmdir='rm -ivrf'

alias ll='ls -la'
alias la='ls -A'
alias l='ls -F'

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
