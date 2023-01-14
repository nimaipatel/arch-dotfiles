#!/usr/bin/fish

alias mv "mv -iv"
alias cp "cp -iv"
alias diff "diff --color"
alias grep "grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}"

abbr -a l "ls -Ah"
abbr -a ll "ls -lAh"

abbr -a tp "trash-put"
abbr -a p "paru"

abbr -a ga "git add"
abbr -a gb "git branch"
abbr -a gcm "git commit"
abbr -a gg "git commit"
abbr -a gch "git checkout"
abbr -a gd "git diff"
abbr -a gull "git pull github"
abbr -a gush "git push github"
abbr -a gst "git status"
abbr -a groot "cd \$(git rev-parse --show-toplevel)"
abbr -a gl "git log"
abbr -a glo "git log --pretty='oneline'"
abbr -a glol "git log --graph --oneline --decorate"

abbr -a nn "nmcli device wifi connect"
abbr -a nls "nmcli device wifi list --rescan yes"

abbr -a bls "bluetoothctl devices"
abbr -a bb "bluetoothctl connect"

abbr -a ytm "youtube-dl --extract-audio --audio-format mp3 --embed-thumbnail --add-metadata --audio-quality 0"

abbr -a ytl "youtube-dl -f bestvideo+bestaudio --merge-output-format mkv"

abbr -a rr "rsync --archive --verbose --dry-run"

abbr -a cpu "ps axch -o cmd,%cpu --sort=-%cpu | head"
abbr -a mem "ps axch -o cmd,%mem --sort=-%mem | head"

abbr -a encr "gpg -c --no-symkey-cache --cipher-algo AES256"

abbr -a -g x '| xargs'

abbr -a -g g '| grep'

abbr -a get_idf "bass source $HOME/esp/esp-idf/export.sh"

set fish_greeting