# change directory without typing cd
shopt -s autocd

# fix spellings while changing directories
shopt -s cdspell

# include file names starting with . in glob matching
shopt -s dotglob

# empty string when no files match glob
shopt -s nullglob

# update $COLUMNS and $LINES after each command
shopt -s checkwinsize

# key timeout to make vim work properly
export KEYTIMEOUT=1

# managing shell history
export HISTSIZE=10000000
export SAVEHIST=10000000

# fzf scripts
source /usr/share/fzf/key-bindings.bash
