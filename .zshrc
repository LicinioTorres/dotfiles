# Created by newuser for 5.9.1
#
#
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Sources
source .config/bash/bash-settings
source .config/bash/bash-aliases

alias ls='ls --color=auto'
alias grep='grep --color=auto'
#PS1='[\u@\h \W]\$ '

PS1=' |%T|  [%m@%n: %~ ] => '

function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# 1. zoxide first
eval "$(zoxide init zsh)"

# 2. then your override
hypr_cwd_update() {
    pwd > "${XDG_RUNTIME_DIR}/hypr-cwd"
}

PROMPT_COMMAND=hypr_cwd_update

