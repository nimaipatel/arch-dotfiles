# include hidden files in tab autocomplete
setopt GLOB_DOTS

# History in cache directory:
export HISTSIZE=10000000
export SAVEHIST=10000000

# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY

# Share history between all sessions.
setopt SHARE_HISTORY

# Do not record an event that was just recorded again.
setopt HIST_IGNORE_DUPS

# Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_ALL_DUPS

# Do not display a previously found event.
setopt HIST_FIND_NO_DUPS

# Do not record an event starting with a space.
setopt HIST_IGNORE_SPACE

# Do not write a duplicate event to the history file.
setopt HIST_SAVE_NO_DUPS

# append to history file
setopt APPEND_HISTORY

# highlight selected option in tab completion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select

# case-insensitive, partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

function man() {
	env \
		LESS_TERMCAP_md="$(tput bold; tput setaf 2)" \
		LESS_TERMCAP_me="$(tput sgr0)" \
		LESS_TERMCAP_mb="$(tput blink)" \
		LESS_TERMCAP_us="$(tput setaf 4)" \
		LESS_TERMCAP_ue="$(tput sgr0)" \
		LESS_TERMCAP_so="$(tput smso)" \
		LESS_TERMCAP_se="$(tput rmso)" \
		PAGER="${commands[less]:-$PAGER}" \
		man "$@"
}
