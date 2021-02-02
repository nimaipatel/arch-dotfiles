# My dotfiles and setup instructions for \*NIX systems

I've tried to put everything I can into `~/.config`

## On new computer:

```
git init --bare $HOME/.cfg
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config remote add origin https://github.com/nimainimaii/arch-dotfiles.git
config pull origin master
```

While pulling in the last step there might be conflicts with existing files on the computer (usually with the .zshrc). In this case, just delete the original file.

## Script to automate adding, committing and pushing to GitHub:

The `update-config` script reads the filenames in
`~/.config/backup_list` and stages and commits them with the current date.
Pass `-s` flag to push changes to remote after making the commit.
