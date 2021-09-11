# Dotfiles managed by GNU Stow

Programs and configs that I use on a daily basis:
- Zsh
- Neovim
- Dwm
- Dwmblocks
- St
- Fzfmenu (dmenu alternative that wraps fzf)
- Slock
- Tmux
- Git
- Vieb
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
cd ~/dotfiles && stow Bash Vim Git Chromium Fzfmenu Flavours Fontconfig Gnupg Haskell Mimeapps Miscscripts Mpd Mpv Ncmpcpp Newsboat Nsxiv Paru Readline Tmux X Xsettingsd --adopt
```

Install dwm, st, dwmblocks and slock:
```sh
cd ~/dotfiles/Dwm && sudo make clean install
```
