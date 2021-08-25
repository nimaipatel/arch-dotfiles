#!/bin/sh

mkdir "$HOME/.config/cfg"
git init --bare "$HOME/.config/cfg/.git"
cfg() { git --git-dir="$HOME/.config/cfg/.git/" --work-tree="$HOME" "$@" ; }
cfg config --local status.showUntrackedFiles no
cfg remote add origin https://github.com/nimaipatel/dotfiles.git
cfg pull origin master
cfg config core.sparseCheckout true
cfg sparse-checkout set '/*' '!/UNLICENSE.md' '!/README.md' '!/install.sh'
cfg checkout
