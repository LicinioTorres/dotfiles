#!/usr/bin/env bash

APP_NAME=$(hyprctl activewindow -j | jq -r '.class')
IGNORE=("kitty")

check_app_list() {
  local match=0
  for item in "${IGNORE[@]}"; do
    if [[ "$item" == "$APP_NAME" ]]; then
      match=1
      break
    fi
  done

  if [[ $match -eq 1 ]]; then
    cliphist list | rofi -dmenu -p "📋 Clipboard" -display-columns 2 -theme copy-paste | cliphist decode | tee >(wl-copy) && hyprctl notify 1 2500 "rgb(00ff66)" "Copied to Clipboard"
  else
    cliphist list | rofi -dmenu -p "📋 Insert from Clipboard" -display-columns 2 -theme copy-paste | cliphist decode | tee >(wl-copy) | tr -d '\n' | wtype -d 1 -
  fi
}

check_app_list
