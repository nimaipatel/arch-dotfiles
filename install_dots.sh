#!/bin/sh

install_user_dots () {
	# shellcheck disable=SC2035
	cd user || return
	stow * -t ~
	cd .. || return

}

install_root_dots () {
	# shellcheck disable=SC2035
	cd root || return
	sudo stow * -t /
	cd .. || return
}

install_user_dots

install_root_dots
