#!/bin/sh

mkdir -p ~/.local/share/nvim/site/pack/plugs/start &&
cd ~/.local/share/nvim/site/pack/plugs/start &&
while read -r line ; do
	git clone "$line" &
done < "$HOME/.config/nvim/plugs"
