#!/usr/bin/fish

function fish_mode_prompt; end
set __fish_git_prompt_color cyan
set __fish_git_prompt_color_suffix yellow
set __fish_git_prompt_color_prefix yellow
function fish_prompt
    if not set -q VIRTUAL_ENV_DISABLE_PROMPT
        set -g VIRTUAL_ENV_DISABLE_PROMPT true
    end
    set_color -o green
    printf '%s' $USER
    set_color -o yellow
    printf '@'
    set_color -o blue
    echo -n (prompt_hostname)
    set_color -o magenta
    printf ' %s' (prompt_pwd)
    printf '%s' (fish_git_prompt)
    if test -n "$VIRTUAL_ENV"
        printf "(%s) " (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
    end
    set_color -o yellow
    printf "\n><> "
    set_color normal
end

alias mv "mv -iv"
alias cp "cp -iv"
alias ls "lsd"
alias diff "diff --color"
alias grep "grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}"

function gnvim --description "open neovim instance in new terminal"
    alacritty --class neovim -e nvim $argv & disown
end
abbr -a vi "gnvim"
abbr -a vim "gnvim"
abbr -a nvim "gnvim"

abbr -a tp "trash-put"
abbr -a p "paru"

abbr -a ga "git add"
abbr -a gb "git branch"
abbr -a gcm "git commit"
abbr -a gg "git commit"
abbr -a gch "git checkout"
abbr -a gd "git diff"
abbr -a gull "git pull origin"
abbr -a gush "git push origin"
abbr -a gst "git status"
abbr -a groot "cd \$(git rev-parse --show-toplevel)"
abbr -a gl "git log"
abbr -a glo "git log --pretty='oneline'"
abbr -a glol "git log --graph --oneline --decorate"

abbr -a l "lsd -A"
abbr -a ll "lsd -Al"

abbr -a genpas "gpg --armor --gen-random 1 5"

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

set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

function fish_hybrid_key_bindings --description \
"Vi-style bindings that inherit emacs-style bindings in all modes"
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase
end
set -g fish_key_bindings fish_hybrid_key_bindings

set -x LESS_TERMCAP_mb (printf "\033[01;31m")
set -x LESS_TERMCAP_md (printf "\033[01;31m")
set -x LESS_TERMCAP_me (printf "\033[0m")
set -x LESS_TERMCAP_se (printf "\033[0m")
set -x LESS_TERMCAP_so (printf "\033[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\033[0m")
set -x LESS_TERMCAP_us (printf "\033[01;32m")
