#!/bin/sh

mkdir -p ~/.local/share/nvim/site/pack/plugs/start
cd ~/.local/share/nvim/site/pack/plugs/start &&
for i in */ ; do
	printf "$i: "
	cd "$i" &&
	git pull
	cd .. || continue
done
