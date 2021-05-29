# manage dotfiles with this
cfg() { git --git-dir="${XDG_CONFIG_HOME}/cfg/.git/" --work-tree="$HOME" "$@" ; }

# default flags
alias mv="mv -iv"
alias cp="cp -iv"
alias rm="echo Are you sure\? 🥺 👉👈; false"
alias ls="ls --color=tty"
alias diff="diff --color"
alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}"
alias wget="wget --hsts-file=\${XDG_CONFIG_HOME}/wget/wget-hsts"
alias vi="nvim"

# swallow windows with `sw cmd`
alias sw="dwmswallow \$WINDOWID && "
