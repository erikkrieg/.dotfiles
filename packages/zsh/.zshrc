ZINIT_HOME="${HOME}/.local/share/zinit"
source "${ZINIT_HOME}/zinit.zsh"

source ~/.config/zsh/prompt.zsh
source ~/.config/zsh/nvim-mode.zsh

alias c="clear"
alias gs="git status"
alias p="pbcopy"
alias v="nvim"
alias vf='nvim "$(fzf)"'

# exa (replacement for ls and tree)
alias ls="exa --group-directories-first"
alias la="ls -a"
alias l="ls -la --git"
alias tree="ls --tree -a -I='.git'"
alias tree2="tree --level=2"
alias tree3="tree --level=3"
alias tree4="tree --level=4"

# bat aliases
alias cat="bat -pp"
alias less="bat -p"

export BAT_THEME="Dracula"
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_DEFAULT_OPTS="--height=60% --layout=reverse --border --margin=1 --padding=1"
export PATH=/opt/homebrew/bin:$PATH
# Rancher Desktop
export PATH=$HOME/.rd/bin:$PATH

zinit ice wait'!0'; zinit snippet OMZ::lib/history.zsh
zinit ice wait'!0'; zinit snippet OMZ::lib/git.zsh
zinit ice wait'!0'; zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit ice wait'!0'; zinit light zsh-users/zsh-completions
zinit ice wait lucid atload'_zsh_autosuggest_start'; zinit light zsh-users/zsh-autosuggestions

# Should be sourced last:
# https://github.com/zsh-users/zsh-syntax-highlighting#faq
zinit ice wait'!0'; zinit light zsh-users/zsh-syntax-highlighting

source "${HOME}/.config/zsh/functions.zsh"

# Case insensitive completions
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 
autoload -Uz compinit && compinit -i

eval "$(direnv hook zsh)"

eval "$(zellij setup --generate-auto-start zsh)"
