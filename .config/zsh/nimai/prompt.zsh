# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info ; }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%F{1}[%f%F{6}%b%f%F{1}]%f'
 
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%B%F{1}[%f%F{2}%n%f%F{8}@%f%F{4}%m%f %F{5}%(5~|%-1~/.../%3~|%4~)%f%F{1}]%f%F{3}$%f %b'
RPROMPT='%B${vcs_info_msg_0_}%b'
