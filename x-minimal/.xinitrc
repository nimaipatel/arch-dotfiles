#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

(setxkbmap -option ctrl:nocaps ; xcape -e 'Control_L=Escape') &
xsettingsd &
xset r rate 300 50 &
xgamma -rgamma 1.0 -ggamma 0.9 -bgamma 0.4 &
while :; do
	ssh-agent dwm
done
