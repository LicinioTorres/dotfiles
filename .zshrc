# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#------ Source Aliases ------
source $HOME/.config/shell/aliases

#------ Text Prompt -------
PS1=' |%D{%H:%M}|  [%m@%n: %~ ] => '

#---- Yazi cd on exit function -----
function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

#---- Zoxide --------
eval "$(zoxide init zsh)"


