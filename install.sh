#!/bin/sh

install_user_dots () {
	cd user || return
	stow * -t ~
	cd .. || return

}

install_root_dots () {
	cd root || return
	sudo stow * -t /
	cd .. || return
}

install_user_dots

install_root_dots
