function instant-zsh-pre() {
  zmodload zsh/terminfo

  (( ${+terminfo[cuu]} && ${+terminfo[ed]} && ${+terminfo[sc]} && ${+terminfo[rc]} )) || return 0

  unsetopt localoptions prompt_cr prompt_sp

  () {
    emulate -L zsh

    local eol_mark=${PROMPT_EOL_MARK-"%B%S%#%s%b"}
    local -i fill=COLUMNS

    () {
      local COLUMNS=1024
      local -i x y=$#1 m
      if (( y )); then
        while (( ${${(%):-$1%$y(l.1.0)}[-1]} )); do
          echo $y
          x=y
          (( y *= 2 ));
        done
        local xy
        while (( y > x + 1 )); do
          m=$(( x + (y - x) / 2 ))
          typeset ${${(%):-$1%$m(l.x.y)}[-1]}=$m
        done
      fi
      (( fill -= x ))
    } $eol_mark

    print -r ${(%):-$eol_mark${(pl.$fill.. .)}$'\r'%b%k%f%E}$'\n\n\n\n\n\n\n\n\n'
    echoti cuu 10
    print -rn -- ${terminfo[sc]}${(%)1}

    _clear-loading-prompt() {
      unsetopt localoptions
      setopt prompt_cr prompt_sp
      () {
        emulate -L zsh
        print -rn -- $terminfo[rc]$terminfo[sgr0]$terminfo[ed]
        unfunction _clear-loading-prompt
        precmd_functions=(${(@)precmd_functions:#_clear-loading-prompt})
      }
    }
    precmd_functions=($precmd_functions _clear-loading-prompt)
  } "$@"
}

function instant-zsh-post() {
  emulate -L zsh
  if (( ${+precmd_functions} && ${+precmd_functions[(I)_clear-loading-prompt]} )); then
    precmd_functions=(${(@)precmd_functions:#_clear-loading-prompt} _clear-loading-prompt)
  fi
}


# `instant-zsh-pre` and `instant-zsh-post` functions are taken from instant-zsh.zsh
# (link: https://gist.github.com/romkatv/8b318a610dc302bdbe1487bb1847ad99/)
# NOTE: if you change/update the prompt then replace argument of
# instant-zsh-pre with output of `echo $PROMPT`
instant-zsh-pre "%B%F{green}%f%F{black}%K{green}%n%k%f%F{green}%f%F{yellow} at %f%F{blue}%f%F{black}%K{blue}%m%k%f%F{blue}%f%F{yellow} in %f%F{magenta}%f%K{magenta}%F{black}%(5~|%-1~/.../%3~|%4~)%f%k%F{magenta}%f${vcs_info_msg_0_}
%F{yellow}ૐ %f %b"


# source plugins
source '/usr/share/fzf/key-bindings.zsh'
source '/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh'
source '/usr/share/zsh/plugins/zsh-autopair/autopair.zsh'
source '/usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh'
source '/usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh'
ABBR_AUTOLOAD=0 source '/usr/share/zsh/plugins/zsh-abbr/zsh-abbr.plugin.zsh'

# vi mode
bindkey -v

# change cursor shape quickly
export KEYTIMEOUT=1

# change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# start in insert mode
zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# use beam shape cursor on startup and for every new prompt
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;}

# vim-surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

# visually select quoted and bracketed text
autoload -U select-quoted
zle -N select-quoted
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

# make backspace work like in vim, unlike traditional vi
bindkey "^?" backward-delete-char

# make forward-word behave like in bash
autoload -U select-word-style
select-word-style bash

# emacs bindings in insert mode for rsi
bindkey "^H" backward-delete-char
bindkey "^W" backward-kill-word
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^B" backward-char
bindkey "^F" forward-char
bindkey 'b' backward-word
bindkey 'f' forward-word
bindkey "^K" kill-line
bindkey "^L" clear-screen
bindkey "^U" kill-whole-line
bindkey "^Y" yank

# edit shell command in $EDITOR buffer
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd '^e' edit-command-line

# substring search in normal mode using j and k
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

autoload -Uz compinit && compinit
# highlight selected option in tab completion
zstyle ':completion:*' menu select
# case-insensitive, partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# vim like autocomplete
zmodload zsh/complist
bindkey '^n' expand-or-complete
bindkey '^p' reverse-menu-complete
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history

# change directory without cd command
setopt autocd

# include hidden files in tab autocomplete
setopt GLOB_DOTS

# write to the history file immediately, not when the shell exits
setopt INC_APPEND_HISTORY

# share history between all sessions
setopt SHARE_HISTORY

# do not record an event that was just recorded again
setopt HIST_IGNORE_DUPS

# delete an old recorded event if a new event is a duplicate
setopt HIST_IGNORE_ALL_DUPS

# do not display a previously found event
setopt HIST_FIND_NO_DUPS

# do not record a command starting with a space
setopt HIST_IGNORE_SPACE

# do not write a duplicate event to the history file
setopt HIST_SAVE_NO_DUPS

# append to history file
setopt APPEND_HISTORY

# history in cache directory:
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000000
export SAVEHIST=10000000

# disable c-s and c-q for freezing and unfreezing terminal
stty -ixon

# man pages
export MANPAGER='nvim +Man!'
export MANWIDTH=80
 
setopt PROMPT_SUBST

PROMPT=''
PROMPT+='%B'

PROMPT+='%F{green}%f'
PROMPT+='%F{black}%K{green}%n%k%f'
PROMPT+='%F{green}%f'

PROMPT+='%F{yellow} at %f'
PROMPT+='%F{blue}%f'
PROMPT+='%F{black}%K{blue}%m%k%f'
PROMPT+='%F{blue}%f'

PROMPT+='%F{yellow} in %f'
PROMPT+='%F{magenta}%f'
PROMPT+='%K{magenta}%F{black}' PROMPT+='%(5~|%-1~/.../%3~|%4~)' PROMPT+='%f%k'
PROMPT+='%F{magenta}%f'

autoload -Uz vcs_info
precmd() { vcs_info }
git_prompt=''
git_prompt+='%F{yellow} on %f'
git_prompt+='%F{cyan}%f'
git_prompt+='%K{cyan}%F{black}%b%f%k'
git_prompt+='%F{cyan}%f'
zstyle ':vcs_info:git:*' formats "$git_prompt"
PROMPT+='${vcs_info_msg_0_}'

eyes=".\n^\n*"
nose="_\n-\n~"
seleyes=$(echo $eyes               | shuf | head -n1)
selnose=$(echo $nose               | shuf | head -n1)
selcol=$(echo {1..6} | tr ' ' '\n' | shuf | head -n1)
PROMPT+=" %F{$selcol}($seleyes$selnose$seleyes)%f"

PROMPT+=$'\n'
PROMPT+='%F{yellow}ૐ %f'
PROMPT+=' '
PROMPT+='%b'

alias mv="mv -iv"
alias cp="cp -iv"
alias ls="ls --color=tty"
alias diff="diff --color"
alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}"
alias vi="nvim"
alias vim="nvim"

alias mew="setsid -f"

alias sw="dwmswallow \$WINDOWID && "

alias ytm="youtube-dl --extract-audio --audio-format mp3 --embed-thumbnail --add-metadata --audio-quality 0"

alias ytl="youtube-dl -f bestvideo+bestaudio --merge-output-format mkv"

alias cpu="ps axch -o cmd,%cpu --sort=-%cpu | head"
alias mem="ps axch -o cmd,%mem --sort=-%mem | head"

alias abbr='abbr -S --quiet'

alias get_idf='. $HOME/esp/esp-idf/export.sh'

abbr sz="sw zathura"
abbr sv="sw nsxiv"
abbr sm="sw mpv"

abbr fz="mew zathura"
abbr fv="mew nsxiv"
abbr fm="mew mpv"

abbr tp="trash-put"
abbr p="paru"

abbr ga="git add"
abbr gb="git branch"
abbr gcm="git commit"
abbr gg="git commit"
abbr gch="git checkout"
abbr gd="git diff"
abbr gull="git pull origin"
abbr gush="git push origin"
abbr gst="git status"
abbr groot="cd \$(git rev-parse --show-toplevel)"
abbr gl="git log"
abbr glo="git log --pretty='oneline'"
abbr glol="git log --graph --oneline --decorate"

abbr cst="cfg status"
abbr ca="cfg add"
abbr cdf="cfg diff"
abbr ccm="cfg commit -m"
abbr cm="cfg commit"
abbr cpom="cfg push origin master"
abbr clol="cfg log --graph --oneline --decorate"

abbr l="exa -a"
abbr ll="exa -al"

abbr genpas="gpg --armor --gen-random 1 5"

abbr nn="nmcli device wifi connect"
abbr nls="nmcli device wifi list --rescan yes"

abbr rr="rsync --archive --verbose --dry-run"

abbr encr="gpg -c --no-symkey-cache --cipher-algo AES256"

abbr doctopdf='libreoffice --headless --invisible --convert-to pdf'

abbr -g x '| xargs'

abbr -g g '| grep'

unalias abbr

instant-zsh-post
