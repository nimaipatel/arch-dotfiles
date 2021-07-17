#!/bin/sh

user_progs="
	dunst
	git
	mpd
	mpv
	my_scripts
	ncmpcpp
	neovim
	newsboat
	python
	ranger
	readline
	surfingkeys
	sxiv
	tmux
	X11
	xsettingsd
	zathura
	zsh
"

root_progs="
	pacman
"

# install program configs in user home folder
# shellcheck disable=SC2086
stow $user_progs -t ~

# shellcheck disable=SC2086
# install system-wide configs in root
sudo stow $root_progs -t /
