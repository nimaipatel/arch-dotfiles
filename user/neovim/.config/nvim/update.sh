#!/bin/sh

mkdir -p ~/.local/share/nvim/site/pack/plugs/start
cd ~/.local/share/nvim/site/pack/plugs/start &&
for i in */ ; do
	echo "$i"
	cd "$i" &&
	git pull
	cd .. || continue
done
