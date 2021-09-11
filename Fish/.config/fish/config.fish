#!/usr/bin/fish

if status --is-login
    set -x EDITOR nvim
    set -x VISUAL nvim

    set -x TERMINAL st
    set -x BROWSER brave
    set -x READER zathura
    set -x TERMINAL_FILE_BROWSER ranger
    set -x GUI_FILE_BROWSER pcmanfm

    # fix window-frames in vieb browser
    set -x VIEB_WINDOW_FRAME true

    # fix white screen of death in java awt programs
    set -x _JAVA_AWT_WM_NONREPARENTING 1

    # my scripts
    set -x MY_SCRIPTS $HOME/.local/bin/my_scripts
    set -x MY_SCRIPT_ASSETS $HOME/.local/share/my_script_assets

    # en_IN doesn't work as expected
     set -x LC_ALL en_US.UTF-8
     set -x LANG en_US.UTF-8

    # ~/ clean up (I don't actually care):
     set -x XDG_CONFIG_HOME $HOME/.config
     set -x XDG_DATA_HOME $HOME/.local/share
     set -x XDG_CACHE_HOME $HOME/.cache
     set -x ANDROID_SDK_ROOT /opt/android-sdk
     set -x ANDROID_HOME /opt/android-sdk
     set -x JAVA_HOME /usr/lib/jvm/java-8-openjdk/

    # PATH variable
    fish_add_path $MY_SCRIPTS
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/.local/share/bin
    fish_add_path $ANDROID_HOME/emulator
    fish_add_path $JAVA_HOME/bin
    fish_add_path $HOME/.ghcup/bin
    fish_add_path $HOME/.cabal/bin
    fish_add_path $HOME/.emacs.d/bin

    # [ "$(tty)" = "/dev/tty1" ] && ! (pidof dwm) && startx
end

alias mv "mv -iv"
alias cp "cp -iv"
alias rm "echo Are you sure\? 👉👈; false"
alias ls "ls --color=tty"
alias diff "diff --color"
alias grep "grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}"
alias vi "nvim"
alias vim "nvim"

alias sw "dwmswallow \$WINDOWID && "

abbr -a sz "sw zathura"
abbr -a sv "sw nsxiv"
abbr -a sm "sw mpv"

abbr -a fz "mew zathura"
abbr -a fv "mew nsxiv"
abbr -a fm "mew mpv"

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

abbr -a cst "cfg status"
abbr -a ca "cfg add"
abbr -a cdf "cfg diff"
abbr -a ccm "cfg commit -m"
abbr -a cm "cfg commit"
abbr -a cpom "cfg push origin master"
abbr -a clol "cfg log --graph --oneline --decorate"

abbr -a l "exa -a"
abbr -a ll "exa -al"

abbr -a ta "tmux attach -t"
abbr -a tkss "tmux kill-session -t"
abbr -a tksv "tmux kill-server"
abbr -a tl "tmux list-sessions"
abbr -a ts "tmux new-session -s"

abbr -a genpas "gpg --armor --gen-random 1 5"

abbr -a nn "nmcli device wifi connect"
abbr -a nls "nmcli device wifi list --rescan yes"

abbr -a ytm "youtube-dl --extract-audio --audio-format mp3 --embed-thumbnail --add-metadata --audio-quality 0"

abbr -a ytl "youtube-dl -f bestvideo+bestaudio --merge-output-format mkv"

abbr -a rr "rsync --archive --verbose --dry-run"

abbr -a cpu "ps axch -o cmd,%cpu --sort=-%cpu | head"
abbr -a mem "ps axch -o cmd,%mem --sort=-%mem | head"

abbr -a encr "gpg -c --no-symkey-cache --cipher-algo AES256"

abbr -a -g x '| xargs'

abbr -a -g g '| grep'

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

# disable greeting
set -U fish_greeting

# disable vi-mode in prompt
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
    set_color normal

    set_color -o yellow
    printf ' at '
    set_color normal

    set_color -o blue
    echo -n (prompt_hostname)
    set_color normal

    set_color -o yellow
    printf ' in '
    set_color normal

    set_color -o magenta
    printf '%s' (prompt_pwd)
    set_color normal

    printf '%s' (fish_git_prompt)

    echo
    if test -n "$VIRTUAL_ENV"
        printf "(%s) " (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
    end

    set_color -o yellow
    printf '>=> '
    set_color normal
end

set -x LESS_TERMCAP_mb (printf "\033[01;31m")
set -x LESS_TERMCAP_md (printf "\033[01;31m")
set -x LESS_TERMCAP_me (printf "\033[0m")
set -x LESS_TERMCAP_se (printf "\033[0m")
set -x LESS_TERMCAP_so (printf "\033[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\033[0m")
set -x LESS_TERMCAP_us (printf "\033[01;32m")
