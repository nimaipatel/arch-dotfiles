# My dotfiles for \*NIX systems managed by GNU Stow

I've tried to put everything I can into `~/.config`

## On new computer:

Clone the repo
```
git clone https://github.com/nimaipatel/dotfiles ~/.dotfiles
```

To install all configs:
```
./install_dots.sh
```

To install Arch Linux packages:
```
./install_progs.sh
```

To install any specific configuration -- say, for example, zsh and neovim:
```
cd user
stow zoomer-shell -t ~
stow neovim -t ~
```
