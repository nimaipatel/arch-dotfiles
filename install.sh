#!/bin/sh

set -x

# $home configs
stow --target="$HOME" fish/ git/ fontconfig-ubuntu-font-family/
