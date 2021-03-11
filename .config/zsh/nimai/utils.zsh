# declare a list of expandable aliases to fill up later
typeset -a ealiases
ealiases=()

# write a function for adding an alias to the list mentioned above
function abbr() {
    alias $1
    ealiases+=(${1%%\=*})
}

# expand any aliases in the current line buffer
function expand-ealias() {
    if [[ $LBUFFER =~ "\<(${(j:|:)ealiases})\$" ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle magic-space
}
zle -N expand-ealias

# Bind the space key to the expand-alias function above, so that space will expand any expandable aliases
bindkey ' '        expand-ealias
bindkey '^ '       magic-space     # control-space to bypass completion
bindkey -M isearch " "      magic-space     # normal space during searches

# A function for expanding any aliases before accepting the line as is and executing the entered command
expand-alias-and-accept-line() {
    expand-ealias
    zle .backward-delete-char
    zle .accept-line
}
zle -N accept-line expand-alias-and-accept-line

# change directory without cd command
setopt autocd

# disbable control + s to freeze terminal
stty stop undef

# terminal swallowing with dwmswallow patch
[ -n "$DISPLAY" ]  && command -v xdo >/dev/null 2>&1 && xdo id > /tmp/term-wid-"$$"
trap "( rm -f /tmp/term-wid-"$$" )" EXIT HUP

# vim mode
bindkey -v

# Change cursor shape for different vim modes
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins 
    echo -ne "\e[6 q"
}
zle -N zle-line-init

echo -ne '\e[6 q' 
preexec() { echo -ne '\e[6 q' ;} 

# make backspace work like in vim, unlike traditional vi
bindkey "^?" backward-delete-char

# delete previous words like in regular shell
bindkey "^W" backward-kill-word

# delete previous character like in regular shell
bindkey "^H" backward-delete-char

# delete previous line like in regular shell
bindkey "^U" backward-kill-line

# jj for exiting normal mode
bindkey jj vi-cmd-mode

# edit shell command in a vim buffer
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
    local selected num
    selected=($(history -1 0 | fzf --height=40%))
    local ret=$?
    if [ -n "$selected" ]; then
        num=$selected[1]
        if [ -n "$num" ]; then
            zle vi-fetch-history -n $num
        fi
    fi
    zle reset-prompt
    return $ret
}
zle     -N   fzf-history-widget
bindkey '^R' fzf-history-widget
