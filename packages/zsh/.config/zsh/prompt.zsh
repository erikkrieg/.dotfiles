setopt PROMPT_SUBST

function prompt_git() {
  info="$(git branch --show-current 2>/dev/null)"
  if [ ! -z "${info}" ]; then
    # Appended empty space
    echo "${info} "
  fi
}

P_VIM_MODE='%F{84}${ZVM_MODE}%f '
P_DIR='%F{39}%1~%f '
P_GIT='%F{240}$(prompt_git)%f'
P_CARET='%F{201}❯%f '

PROMPT="${P_VIM_MODE}${P_DIR}${P_GIT}${P_CARET}"

