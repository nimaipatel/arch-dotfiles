# include hidden files in tab autocomplete
setopt GLOB_DOTS

# highlight selected option in tab completion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select

# case-insensitive, partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
