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

# swallow aliases
alias zz="sw zathura"
alias ss="sw sxiv"
alias mm="sw mpv"

# shorten names
alias tp="trash-put"

# git aliases
alias ga="git add"
alias gb="git branch"
alias gcm="git commit -m"
alias gc="git commit"
alias gch="git checkout"
alias gd="git diff"
alias gull="git pull origin"
alias gush="git push origin"
alias gst="git status"
alias groot="cd \$(git rev-parse --show-toplevel)"
alias gl="git log"
alias glo="git log --pretty='oneline'"
alias glol="git log --graph --oneline --decorate"

# for managing dotfiles
alias cfg='git --git-dir="${XDG_CONFIG_HOME}/cfg/.git/" --work-tree="$HOME"'
alias cst="cfg status"
alias ca="cfg add"
alias cdf="cfg diff"
alias ccm="cfg commit -m"
alias cm="cfg commit"
alias cpom="cfg push origin master"

# ls aliases
alias l="ls -Av"
alias ll="ls -lAhv"

# tmux aliases
alias ta="tmux attach -t"
alias tkss="tmux kill-session -t"
alias tksv="tmux kill-server"
alias tl="tmux list-sessions"
alias ts="tmux new-session -s"

# create and extract zip and tar archives
alias tar="bsdtar -cf"
alias zip="bsdtar -a -cf"
alias untar="bsdtar -xf"
alias unzip="bsdtar -xf"

# generate random password
alias genpas="gpg --armor --gen-random 1 5"

# connect to remembered networks quickly
alias nn="nmcli device wifi connect"
alias nls="nmcli device wifi list --rescan yes"

# I forget these flags every time for downloading albums/playlists with cover art
alias ytm="youtube-dl --extract-audio --audio-format mp3 --embed-thumbnail --add-metadata --audio-quality 0"

# flags for download videos in best quality
alias ytl="youtube-dl -f bestvideo+bestaudio --merge-output-format mkv"

# always forget rsync flags to sync media/backups across devices (don't forget trailing slashes!)
alias rr="rsync --archive --verbose --dry-run"

# create offline archive of websites with wget
alias archive="wget --mirror --convert-links --html-extension --show-progress -o wget.log"

# get memory and CPU hogs
alias cpu="ps axch -o cmd,%cpu --sort=-%cpu | head"
alias mem="ps axch -o cmd,%mem --sort=-%mem | head"

# asymmetrically encrypt a single file (for folders, zip them)
alias encr="gpg -c --no-symkey-cache --cipher-algo AES256"
