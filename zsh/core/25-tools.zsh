#!/usr/bin/env zsh
# Modern tool configuration
# Shared across all profiles with detection for workstation vs server

# ============================================================================
# Theme Configuration (all profiles)
# ============================================================================

# Load Catppuccin theme (LS_COLORS, BAT_THEME, FZF colors, etc.)
if [[ -f "$HOME/.config/shell/theme.zsh" ]]; then
  source "$HOME/.config/shell/theme.zsh"
fi

# ============================================================================
# Workstation Tool Configuration
# Only load heavy tools on workstation profiles (laptop, wsl, pro)
# Servers get minimal config for performance
# ============================================================================

# Detect if this is a workstation profile
IS_WORKSTATION=false
case "${MACHINE_TYPE:-unknown}" in
  wsl|laptop|pro)
    IS_WORKSTATION=true
    ;;
  server|*-server|homelab)
    IS_WORKSTATION=false
    ;;
esac

# ----------------------------------------------------------------------------
# fzf - Enhanced fuzzy finder (workstations only)
# ----------------------------------------------------------------------------
if [[ "$IS_WORKSTATION" == "true" ]] && command -v fzf &> /dev/null; then
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

# ----------------------------------------------------------------------------
# bat - Better cat (all profiles if installed)
# ----------------------------------------------------------------------------
if command -v bat &> /dev/null; then
  export BAT_STYLE="numbers,changes,header"
fi

# ----------------------------------------------------------------------------
# zoxide - Smart directory jumping (workstations only)
# ----------------------------------------------------------------------------
if [[ "$IS_WORKSTATION" == "true" ]] && command -v zoxide &> /dev/null; then
  export _ZO_DATA_DIR="$HOME/.local/share/zoxide"
  export _ZO_ECHO=1
  eval "$(zoxide init zsh)"
fi
