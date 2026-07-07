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

# Active window must be kitty
kitty_pid=$(hyprctl activewindow -j | jq -r '.pid')

# Find the interactive shell inside kitty
shell_pid=$(ps --ppid "$kitty_pid" -o pid=,comm= |
    awk '$2 == "bash" { print $1; exit }')

# Determine working directory
if [[ -n "$shell_pid" ]]; then
    cwd=$(readlink -f "/proc/$shell_pid/cwd" 2>/dev/null || true)
fi

# Fallbacks
if [[ -z "${cwd:-}" || ! -d "$cwd" || "$cwd" == "$HOME" || "$cwd" == "/" ]]; then
    cwd="$HOME/Documents"
fi

title="Create-a-New-File"
rofi -theme new-file -p -title "$title" -show $title -modi "$title:$SCRIPTS_PATH/new-file/new-file-menu-options.sh" 

