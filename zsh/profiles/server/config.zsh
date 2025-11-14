#!/usr/bin/env zsh
# Server-specific configuration
# Optimized for minimal resource usage

# Load Catppuccin theme (LS_COLORS, BAT_THEME, FZF colors, etc.)
if [[ -f "$HOME/.config/shell/theme.zsh" ]]; then
  source "$HOME/.config/shell/theme.zsh"
fi

# Reduced history size for servers
export HISTSIZE=10000
export SAVEHIST=10000

# Disable correction on servers (can be annoying)
unsetopt CORRECT
unsetopt CORRECT_ALL

# Faster prompt rendering
setopt PROMPT_SUBST
