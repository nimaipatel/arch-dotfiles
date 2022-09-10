#!/usr/bin/zsh

# make c-s and c-q useable
stty -ixon
# use beam shape cursor on startup and for every new prompt
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;}
# instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# don't souce abbrevs automatically
export ABBR_AUTOLOAD=0

source ~/.zplug/init.zsh
zplug jeffreytse/zsh-vi-mode
zplug romkatv/powerlevel10k, as:theme, depth:1
zplug romkatv/zsh-defer, depth:1
zplug plugins/colored-man-pages, from:oh-my-zsh
zplug zsh-users/zsh-autosuggestions, depth:1
zplug hlissner/zsh-autopair, depth:1
zplug zdharma-continuum/fast-syntax-highlighting, depth:1
zplug zsh-users/zsh-history-substring-search, depth:1
zplug olets/zsh-abbr, depth:1
source '/usr/share/fzf/key-bindings.zsh'
zplug load

autoload -Uz compinit && compinit
# highlight selected option in tab completion
zstyle ':completion:*' menu select
# case-insensitive, partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# vim like autocomplete
zmodload zsh/complist

WORDCHARS='*?_~&;!#$%^'

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

# man pages
export MANWIDTH=80
 
alias mv="mv -iv"
alias cp="cp -iv"
alias ls="ls --color=tty"
alias diff="diff --color"
alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}"

alias mew="setsid -f"

alias sw="dwmswallow \$WINDOWID && "

alias ytm="youtube-dl --extract-audio --audio-format mp3 --embed-thumbnail --add-metadata --audio-quality 0"

alias ytl="youtube-dl -f bestvideo+bestaudio --merge-output-format mkv"

alias cpu="ps axch -o cmd,%cpu --sort=-%cpu | head"
alias mem="ps axch -o cmd,%mem --sort=-%mem | head"

alias abbr='abbr -S --quiet'

alias get_idf='. $HOME/esp/esp-idf/export.sh'

abbr vi="nvim"
abbr vim="nvim"

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

abbr i="unset HISTFILE"

unalias abbr

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
