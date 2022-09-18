ZINIT_HOME="${HOME}/.local/share/zinit"
source "${ZINIT_HOME}/zinit.zsh"

alias c="clear"
alias gs="git status"
alias p="pbcopy"
alias v="nvim"

# exa (replacement for ls and tree)
alias ls="exa --group-directories-first"
alias la="ls -a"
alias l="ls -la --git"
alias tree="ls --tree"

# bat aliases
alias cat="bat -pp"
alias less="bat -p"

export BAT_THEME="Dracula"

zinit ice wait'!0'
zinit snippet OMZ::lib/git.zsh
zinit ice wait'!0'
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit ice wait'!0'
zinit light zsh-users/zsh-completions
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions
