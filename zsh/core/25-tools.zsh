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
if [[ "$IS_WORKSTATION" == "true" ]] && (( $+commands[fzf] )); then
  # Use fd for file finding (faster, respects .gitignore)
  if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi

  # Ctrl+T: File finder with bat preview
  if (( $+commands[bat] )); then
    export FZF_CTRL_T_OPTS="
      --preview 'bat -n --color=always {}'
      --bind 'ctrl-/:change-preview-window(down|hidden|)'
    "
  fi

  # Alt+C: Directory navigator with eza tree preview
  if (( $+commands[eza] )); then
    export FZF_ALT_C_OPTS="
      --preview 'eza --tree --color=always {} | head -200'
    "
  fi
fi

# ----------------------------------------------------------------------------
# bat - Better cat (all profiles if installed)
# ----------------------------------------------------------------------------
if (( $+commands[bat] )); then
  export BAT_STYLE="numbers,changes,header"
fi

# ----------------------------------------------------------------------------
# zoxide - Smart directory jumping (workstations only)
# NOTE: Kept eager-load since zoxide init is only ~3ms and lazy-loading
# conflicts with zinit's `zi` alias
# ----------------------------------------------------------------------------
if [[ "$IS_WORKSTATION" == "true" ]] && (( $+commands[zoxide] )); then
  export _ZO_DATA_DIR="$HOME/.local/share/zoxide"
  export _ZO_ECHO=1
  eval "$(zoxide init zsh)"
fi

# ----------------------------------------------------------------------------
# nvm - Node Version Manager (lazy-loaded for faster shell startup)
# Only loads when you actually use nvm, node, npm, or npx
# ----------------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"

if [[ -d "$NVM_DIR" ]]; then
  # Lazy-load nvm: define placeholder functions that load nvm on first use
  __load_nvm() {
    unset -f nvm node npm npx 2>/dev/null
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  }

  nvm() { __load_nvm && nvm "$@"; }
  node() { __load_nvm && node "$@"; }
  npm() { __load_nvm && npm "$@"; }
  npx() { __load_nvm && npx "$@"; }
fi
