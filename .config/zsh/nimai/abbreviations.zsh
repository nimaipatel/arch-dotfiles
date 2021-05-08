# shorted names
abbr tp="trash-put"

# git abbrevations
abbr ga="git add"
abbr gb="git branch"
abbr gc="git commit -m"
abbr gch="git checkout"
abbr gd="git diff"
abbr gull="git pull origin"
abbr gush="git push origin"
abbr gst="git status"
abbr groot="cd \$(git rev-parse --show-toplevel)"
abbr gl="git log"
abbr glo="git log --pretty='oneline'"
abbr glol="git log --graph --oneline --decorate"

# ls abbrevations
abbr l="ls -A"
abbr ll="ls -lAh"

# tmux abbrevations
abbr ta="tmux attach -t"
abbr tkss="tmux kill-session -t"
abbr tksv="tmux kill-server"
abbr tl="tmux list-sessions"
abbr ts="tmux new-session -s"

# cfg abbrevations
abbr ca="cfg add"
abbr cm="cfg commit -m"
abbr cdf="cfg diff"
abbr cpom="cfg push origin master"
abbr cst="cfg status"

# untar command
abbr untar="tar -xvf"

# source nvm script installed via pacman
abbr snvm="source /usr/share/nvm/init-nvm.sh"

# generate random password
abbr genpas="gpg --armor --gen-random 1 5"

# connect to remembered networks quickly
abbr nn="nmcli connection up"

# I forget these flags every time for downloading albums/playlists with cover art
abbr ytm="youtube-dl--extract-audio --audio-format mp3 --embed-thumbnail"

# always forget rsync flags to sync media/backups across devices (don't forget trailing slashes!)
abbr rr="rsync --archive --verbose --dry-run"
