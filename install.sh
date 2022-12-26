#!/bin/sh

set -x

# $HOME configs
stow --target="$HOME" Bash Vim Tmux Git Readline
                     \Brave Mpv Nsxiv
                     \Haskell
                     \keyd
                     \Fontconfig-ubuntu-font-family
                     \Gnupg
                     \Mimeapps
                     \Miscscripts

# root configs
sudo stow keyd-root --target=/

# this shit needs to be compiled
cd ./dwm-minimal   && sudo make clean install ; make clean && cd ..
cd ./st-minimal    && sudo make clean install ; make clean && cd ..
cd ./dmenu-minimal && sudo make clean install ; make clean && cd ..
