#!/bin/bash

# change directory without typing cd
shopt -s autocd

# fix spellings while changing directories
shopt -s cdspell

# include file names starting with . in glob matching
shopt -s dotglob

# empty string when no files match glob
shopt -s nullglob

# update $COLUMNS and $LINES after each command
shopt -s checkwinsize

# key timeout to make vim work properly
export KEYTIMEOUT=1

# managing shell history
export HISTSIZE=10000000
export SAVEHIST=10000000

RED="\[$(tput bold)\]\[$(tput setaf 1)\]"
GREEN="\[$(tput bold)\]\[$(tput setaf 2)\]"
YELLOW="\[$(tput bold)\]\[$(tput setaf 3)\]"
BLUE="\[$(tput bold)\]\[$(tput setaf 4)\]"
MAGENTA="\[$(tput bold)\]\[$(tput setaf 5)\]"
CYAN="\[$(tput bold)\]\[$(tput setaf 6)\]"
RESET="\[$(tput bold)\]\[$(tput sgr0)\]"

PROMPT_DIRTRIM=3
PS1=''
PS1+="${CYAN}\u${RESET}"
PS1+="${RED}@${RESET}${BLUE}\H${RESET}"
PS1+=" ${MAGENTA}\w${RESET}"
PS1+="${YELLOW}"
if [ -f /usr/share/git/completion/git-prompt.sh ]; then
  . /usr/share/git/completion/git-prompt.sh
  PS1+='$(__git_ps1 " '
  PS1+="${RESET}"
  PS1+="${GREEN}"
  PS1+='[%s]")'
fi
PS1+="${RESET}"
PS1+=" ${YELLOW}\$${RESET} "


# disable c-s and c-q for freezing and unfreezing terminal
stty -ixon

if [ -f /usr/share/fzf/key-bindings.bash ]; then
  . /usr/share/fzf/key-bindings.bash
fi

alias cpu="ps axch -o cmd,%cpu --sort=-%cpu | head"
alias mem="ps axch -o cmd,%mem --sort=-%mem | head"

alias mv="mv -iv"
alias cp="cp -iv"
alias pcp="rsync -Pa"
alias rm="echo Are you sure\? 👉👈; false"
alias ls="ls --color=tty"
alias diff="diff --color"
alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}"

alias mew="setsid -f"

alias sw="dwmswallow \$WINDOWID && "

alias ytm="youtube-dl --extract-audio --audio-format mp3 --embed-thumbnail --add-metadata --audio-quality 0"

alias ytl="youtube-dl -f bestvideo+bestaudio --merge-output-format mkv"

alias sz="sw zathura"
alias sv="sw nsxiv"
alias sm="sw mpv"

alias fz="mew zathura"
alias fv="mew nsxiv"
alias fm="mew mpv"

alias tp="trash-put"
alias p="paru"

alias ga="git add"
alias gb="git branch"
alias gcm="git commit"
alias gg="git commit"
alias gch="git checkout"
alias gd="git diff"
alias gull="git pull origin"
alias gush="git push origin"
alias gst="git status"
alias groot="cd \$(git rev-parse --show-toplevel)"
alias gl="git log"
alias glo="git log --pretty='oneline'"
alias glol="git log --graph --oneline --decorate"

alias cst="cfg status"
alias ca="cfg add"
alias cdf="cfg diff"
alias ccm="cfg commit -m"
alias cm="cfg commit"
alias cpom="cfg push origin master"
alias clol="cfg log --graph --oneline --decorate"

alias l="ls -Ahv"
alias ll="ls -lAhv"

alias genpas="gpg --armor --gen-random 1 20"

alias nn="nmcli device wifi connect"
alias nls="nmcli device wifi list --rescan yes"

alias rr="rsync --archive --verbose --dry-run"

alias encr="gpg -c --no-symkey-cache --cipher-algo AES256"

get_idf () {
  . "$HOME/esp/esp-idf/export.sh"
  alias b='idf.py build'
  alias f='idf.py flash'
  alias r='idf.py monitor'
  alias rr='idf.py build && idf.py flash && idf.py monitor'
}

alias doctopdf='libreoffice --headless --invisible --convert-to pdf'

fd () {
  find . -iname "*$1*"
}

rg () {
  grep "$1" -r .
}

# shellcheck disable=SC2034
ffmpeg_blackbars="-vf scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2,setsar=1"

# man pages
export MANWIDTH=80
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_so=$'\e[45;93m'
export LESS_TERMCAP_se=$'\e[0m'
