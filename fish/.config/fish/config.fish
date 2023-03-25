#!/usr/bin/fish

alias mv "mv -iv"
alias cp "cp -iv"
alias diff "diff --color"
alias grep "grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}"

abbr -a l "exa -ah"
abbr -a ll "exa -lah"

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

abbr -a get_idf "bass source $HOME/esp/esp-idf/export.sh"

function fish_hybrid_key_bindings --description \
"Vi-style bindings that inherit emacs-style bindings in all modes"
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase
end
set -g fish_key_bindings fish_hybrid_key_bindings

set fish_cursor_default block blink
set fish_cursor_insert line blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual block blink

set fish_greeting

function fish_mode_prompt; end
set __fish_git_prompt_color cyan
set __fish_git_prompt_color_suffix yellow
set __fish_git_prompt_color_prefix yellow
function fish_prompt
    if not set -q VIRTUAL_ENV_DISABLE_PROMPT
        set -g VIRTUAL_ENV_DISABLE_PROMPT true
    end
    set_color --bold green
    printf '%s' $USER
    set_color --bold yellow
    printf '@'
    set_color --bold magenta
    printf '%s' (prompt_hostname)
    set_color --bold yellow
    printf ' ['
    set_color --bold blue
    printf '%s' (prompt_pwd)
    set_color --bold yellow
    printf ']'
    printf '%s' (fish_git_prompt)
    if test -n "$VIRTUAL_ENV"
        printf '(%s) ' (set_color --bold blue)(basename $VIRTUAL_ENV)(set_color --bold normal)
    end
    set_color --bold yellow
    printf '\nॐ  '
    set_color --bold normal
end