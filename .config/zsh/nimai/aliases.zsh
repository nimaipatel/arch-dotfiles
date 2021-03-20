# manage dotfiles with this
cfg() { git --git-dir=$HOME/.cfg/ --work-tree=$HOME $*}

# swallow aliases
alias zz="dwmswallow $WINDOWID && zathura"
alias ss="dwmswallow $WINDOWID && sxiv"
alias mm="dwmswallow $WINDOWID && mpv"
alias yt="dwmswallow $WINDOWID && ytfzf"

# default flags
alias mv='mv -iv'
alias cp='cp -iv'
alias rm='echo Are you sure\? 🥺 👉👈; false'
alias ls='ls --color=tty'
alias diff='diff --color'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'

# start neovim as server to use nvr
alias vi="NVIM_LISTEN_ADDRESS="/tmp/nvimsocket-"$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)"" nvim" \

