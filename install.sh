#!/bin/sh

set -x

# $home configs
stow --target="$HOME" fish/ neovim/ git/
