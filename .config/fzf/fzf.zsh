# Setup fzf
# ---------
#if [[ ! "$PATH" == */home/nimai/.fzf/bin* ]]; then
  #export PATH="${PATH:+${PATH}:}/home/nimai/.fzf/bin"
#fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/nimai/.config/fzf/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/nimai/.config/fzf/key-bindings.zsh"
