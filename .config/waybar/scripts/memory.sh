#!/bin/bash

# ------------------
# RAM
# ------------------

RAM_USED=$(free -g | awk '/Mem:/ {print $3}')
RAM_TOTAL=$(free -g | awk '/Mem:/ {print $2}')
RAM_PERCENT=$(free | awk '/Mem:/ {printf "%.0f", $3/$2*100}')

# ------------------
# Drives
# ------------------

ROOT=$(df -h / | awk 'NR==2 {print " / " $3 "/" $2}')

DRIVES=$(
{
    echo "$ROOT"

    lsblk -rno MOUNTPOINT,FSUSED,FSSIZE |
    awk '
        NF &&
        $1 != "/" &&
        $1 != "/boot" &&
        $1 != "/home" &&
        $1 != "/var/log" &&
        $1 != "/var/cache/pacman/pkg" &&
        $1 != "[SWAP]" {

            printf "󰋊 %s %s/%s\n", $1, $2, $3
        }
    '
}
)

# ------------------
# Tooltip
# ------------------

TOOLTIP="󰍛 RAM ${RAM_USED}/${RAM_TOTAL}GB ${RAM_PERCENT}%"

while IFS= read -r line; do
    TOOLTIP="${TOOLTIP}\n${line}"
done <<< "$DRIVES"

# ------------------
# Waybar JSON
# ------------------

echo "{\"text\":\"|  ${RAM_PERCENT}%\",\"tooltip\":\"${TOOLTIP}\"}"
