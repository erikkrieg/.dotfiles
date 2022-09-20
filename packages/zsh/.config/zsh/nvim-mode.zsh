# Sets nvim as the default editor.
export EDITOR='nvim'
export VISUAL='nvim'

# Enables vi-mode for editing command line (uses default editor set above).
bindkey -v
export KEYTIMEOUT=1

autoload edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line

# There is also a home manager way to source this that I should investigate.
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode

