# include hidden files in tab autocomplete
setopt GLOB_DOTS

# highlight selected option in tab completion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select

# case-insensitive, partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000

function man() {
	env \
		LESS_TERMCAP_md=$(tput bold; tput setaf 2) \
		LESS_TERMCAP_me=$(tput sgr0) \
		LESS_TERMCAP_mb=$(tput blink) \
		LESS_TERMCAP_us=$(tput setaf 4) \
		LESS_TERMCAP_ue=$(tput sgr0) \
		LESS_TERMCAP_so=$(tput smso) \
		LESS_TERMCAP_se=$(tput rmso) \
		PAGER="${commands[less]:-$PAGER}" \
		man "$@"
}
