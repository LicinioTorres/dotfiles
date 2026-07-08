#!/usr/bin/env bash

cliphist list | rofi -dmenu -p "📋 Clipboard" -display-columns 2 -theme copy-paste | cliphist decode | tee >(wl-copy) 

read -rsn1 key

if [[ $key == $'\e' ]]; then
  exit 1
fi

hyprctl notify 1 10000 "rgb(ff1ea3)" "Copied to Clipboard"
