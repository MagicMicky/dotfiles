#!/usr/bin/env zsh
# Laptop-specific configuration

# Load Catppuccin theme (LS_COLORS, BAT_THEME, FZF colors, etc.)
if [[ -f "$HOME/.config/shell/theme.zsh" ]]; then
  source "$HOME/.config/shell/theme.zsh"
fi

# ============================================================================
# Workstation-specific tool configuration
# ============================================================================

# fzf - Enhanced fuzzy finder configuration with previews
if command -v fzf &> /dev/null; then
  # Use fd for file finding (faster, respects .gitignore)
  if command -v fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi

  # Ctrl+T: File finder with bat preview
  if command -v bat &> /dev/null; then
    export FZF_CTRL_T_OPTS="
      --preview 'bat -n --color=always {}'
      --bind 'ctrl-/:change-preview-window(down|hidden|)'
    "
  fi

  # Alt+C: Directory navigator with eza tree preview
  if command -v eza &> /dev/null; then
    export FZF_ALT_C_OPTS="
      --preview 'eza --tree --color=always {} | head -200'
    "
  fi
fi

# Modern tools configuration
# bat - theme set by theme.zsh, just set style preferences
if command -v bat &> /dev/null; then
  export BAT_STYLE="numbers,changes,header"
fi

# eza - colors set by theme.zsh (respects LS_COLORS)

# zoxide - Smart directory jumping
if command -v zoxide &> /dev/null; then
  export _ZO_DATA_DIR="$HOME/.local/share/zoxide"
  export _ZO_ECHO=1
  eval "$(zoxide init zsh)"
fi
