#!/usr/bin/env bash


NOW=$(date +%H:%M:%S)

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

exec kitty --detach --directory="$cwd" nvim "$NOW.typ"
