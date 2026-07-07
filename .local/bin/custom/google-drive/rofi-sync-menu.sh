#!/usr/bin/env bash

#---- Source Local Variables

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_SH="$SCRIPT_DIR/local.sh"

if [[ ! -f "$LOCAL_SH" ]]; then
    echo "Error: $LOCAL_SH not found." >&2
    echo "Copy local.sh.example to local.sh and configure it." >&2
    exit 1
fi

source "$LOCAL_SH"

# ----- Launch Rofi ------

rofi-menu() {
  local title=$1
  local th="$2"
  shift
  shift
  printf "%s\n" "$@"  | rofi -dmenu -kb-select-4 "h" -theme "$th" -i -p "$title"
}

#----- Functions ------
drive-sync() {
  kitty -e "$SCRIPTS_PATH/google-drive/sync.sh"
}

md() {
  kitty -e "$SCRIPTS_PATH/google-drive/sync-md.sh"
}

re() {
  kitty -e "$SCRIPTS_PATH/google-drive/sync-re.sh"
}

dep() {
  kitty -e "$SCRIPTS_PATH/google-drive/sync-debug.sh"
}

ret() {
  menu
}

debug() {
  choice=$(rofi-menu "SUDO Menu" "google-drive" "Set Max Delete %" "Resync" "DEBUG MODE" "Back") 

  case "$choice" in
    "Set Max Delete %") md;;
    "Resync") re;;
    "DEBUG MODE") dep;;
    "Back") ret;;
  esac
}

#----- Main Menu ------ 
menu() {
    choice=$(rofi-menu " Google Drive" "google-drive" "Sync" "SUDO MENU")

    case "$choice" in
      "Sync") drive-sync ;;
      "SUDO MENU") debug ;;
    esac
}

menu
