# Dotfiles managed by GNU Stow

Programs and configs that I use on a daily basis:
- Awesome
- Neovim
- Kitty
- Fish
- Starship
- Slock
- Git
- Brave
- Flavours
- Fontconfig
- Gnupg
- Haskell
- Mimeapps
- Miscscripts
- Mpd
- Mpv
- Ncmpcpp
- Newsboat
- Nsxiv
- Paru
- Readline
- X
- Xsettingsd

All other programs in this repository are only for archival purposes.

Ideally I would just use a bare git repository in `$HOME`. However, I
wanted to keep track of configs that I no longer use just in case I (or someone
else) might want to refer to them in the future.

## Installation

On new computer, as non-root user, run:
```
cd ~ && git clone https://www.github.com/nimaipatel/dotfiles --recurse-submodules
```

Install configs for programs that I use regularly:
```sh
cd ~/dotfiles && stow Awesome Neovim Kitty Fish Starship Slock Git Brave Flavours Fontconfig Gnupg Haskell Mimeapps Miscscripts Mpd Mpv Ncmpcpp Newsboat Nsxiv Paru Readline X Xsettingsd --adopt
```

Install dwm, st, dwmblocks and slock:
```sh
cd ~/dotfiles/Dwm && sudo make clean install
```

## Fonts

Install configurations for any of the fonts using `stow Fontconfig-fontname`.
