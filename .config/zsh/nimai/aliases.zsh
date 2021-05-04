# manage dotfiles with this
cfg() { git --git-dir="${HOME}/.cfg/" --work-tree="$HOME" "$@" ; }

# swallow aliases
alias zz="dwmswallow \$WINDOWID && zathura"
alias ss="dwmswallow \$WINDOWID && sxiv"
alias mm="dwmswallow \$WINDOWID && mpv"
alias yt="dwmswallow \$WINDOWID && ytfzf"

# default flags
alias mv="mv -iv"
alias cp="cp -iv"
alias rm="echo Are you sure\? 🥺 👉👈; false"
alias ls="ls --color=tty"
alias diff="diff --color"
alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}"
alias vi="nvim"
