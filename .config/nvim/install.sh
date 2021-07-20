#!/bin/sh

mkdir -p ~/.local/share/nvim/site/pack/plugs/start
cd ~/.local/share/nvim/site/pack/plugs/start
while read line ; do
	git clone "$line" &
done < ~/.config/nvim/plugs
