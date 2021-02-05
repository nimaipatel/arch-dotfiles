# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats ' on branch %b'
 
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%F{1}[%f%F{2}%n$f %F{4}at %m%f %F{5}in ${PWD/#$HOME/~}%f%F{6}${vcs_info_msg_0_}%f%F{1}]%f%F{3}$%f '
