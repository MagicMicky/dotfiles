#!/usr/bin/env zsh
# Laptop-specific configuration

# zsh-autosuggestions configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# zsh-syntax-highlighting configuration
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# History substring search keybindings
# Bind up and down arrow keys
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Also bind k and j in vi mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Modern tools configuration
# bat
if command -v bat &> /dev/null; then
  export BAT_THEME="TwoDark"
  export BAT_STYLE="numbers,changes,header"
fi

# eza
if command -v eza &> /dev/null; then
  export EZA_COLORS="da=36"
fi

# zoxide
if command -v zoxide &> /dev/null; then
  export _ZO_DATA_DIR="$HOME/.local/share/zoxide"
  export _ZO_ECHO=1
fi
