#!/bin/bash
input=$(cat)

USER=$(whoami)
HOST=$(hostname -s)
DIR=$(echo "$input" | jq -r '.workspace.current_dir // "~"' | sed "s|$HOME|~|")
PERCENT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

# Catppuccin cyan: #74c7ec = rgb(116,199,236)
printf '\033[1;38;2;116;199;236m[λ] %s@%s %s\033[0m | Context: %s%%' "$USER" "$HOST" "$DIR" "$PERCENT"
