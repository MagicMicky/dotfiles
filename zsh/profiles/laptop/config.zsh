#!/usr/bin/env zsh
# Laptop-specific configuration

# Load Catppuccin theme (LS_COLORS, BAT_THEME, FZF colors, etc.)
if [[ -f "$HOME/.config/shell/theme.zsh" ]]; then
  source "$HOME/.config/shell/theme.zsh"
fi

# Plugin configurations - DISABLED (plugins removed)
# zsh-autosuggestions configuration
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
# ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# zsh-syntax-highlighting configuration
# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# History substring search keybindings - DISABLED (plugin removed)
# Bind up and down arrow keys
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

# Also bind k and j in vi mode
# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down

# Modern tools configuration
# bat - theme set by theme.zsh, just set style preferences
if command -v bat &> /dev/null; then
  export BAT_STYLE="numbers,changes,header"
fi

# eza - colors set by theme.zsh (respects LS_COLORS)

# zoxide
if command -v zoxide &> /dev/null; then
  export _ZO_DATA_DIR="$HOME/.local/share/zoxide"
  export _ZO_ECHO=1
fi
