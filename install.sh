#!/bin/sh

set -x

# $home configs
stow --target="$HOME" bash vim tmux git readline\
                      brave mpv nsxiv\
                      haskell\
                      keyd\
                      fontconfig-ubuntu-font-family\
                      gnupg\
                      mimeapps\
                      miscscripts\

# root configs
# sudo stow keyd-root --target=/

# this shit needs to be compiled
#cd ./dwm-minimal   && sudo make clean install ; make clean && cd ..
#cd ./st-minimal    && sudo make clean install ; make clean && cd ..
#cd ./dmenu-minimal && sudo make clean install ; make clean && cd ..
