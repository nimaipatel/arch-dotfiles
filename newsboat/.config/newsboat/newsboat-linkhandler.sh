#!/bin/sh

if [ -z "$1" ]; then
	url="$(xclip -o)"
else
	url="$1"
fi

case "$url" in
	*mkv|*webm|*mp4|*youtube.com/watch*|*youtube.com/playlist*|*youtube.com/shorts*|*youtu.be*|*hooktube.com*|*bitchute.com*|*odysee.com*)
		notify-send "opening link \"$url\" using mpv"
		setsid -f mpv -quiet "$url" >/dev/null 2>&1 ;;
	*png|*jpg|*jpe|*jpeg|*gif)
		notify-send "opening link \"$url\" using nsxiv"
		curl -sL "$url" > "/tmp/$(echo "$url" | sed "s/.*\///;s/%20/ /g")" && nsxiv -a "/tmp/$(echo "$url" | sed "s/.*\///;s/%20/ /g")"  >/dev/null 2>&1 & ;;
	*pdf|*cbz|*cbr)
		notify-send "opening link \"$url\" using zathura"
		curl -sL "$url" > "/tmp/$(echo "$url" | sed "s/.*\///;s/%20/ /g")" && zathura "/tmp/$(echo "$url" | sed "s/.*\///;s/%20/ /g")"  >/dev/null 2>&1 & ;;
	*)
		notify-send "opening link \"$url\" using \"$BROWSER\""
		setsid -f "$BROWSER" "$url" >/dev/null 2>&1
esac
