# My dotfiles and setup instructions for \*NIX systems

I've tried to put everything I can into `~/.config`

## On new computer:

```
git init --bare "${XDG_CONFIG_HOME}/cfg/.git/"
cfg() { git --git-dir="${XDG_CONFIG_HOME}/cfg/.git/" --work-tree="$HOME" "$@" ; }
cfg config --local status.showUntrackedFiles no
cfg remote add origin https://github.com/nimaipatel/dotfiles.git
cfg pull origin master
```

While pulling in the last step there might be conflicts with existing files on the computer (usually with the .zshrc). In this case, just delete the original file.
