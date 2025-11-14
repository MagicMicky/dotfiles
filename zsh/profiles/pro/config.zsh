#!/usr/bin/env zsh
# Pro/Work-specific configuration (non-sensitive)

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

# zoxide - Smart directory jumping
if command -v zoxide &> /dev/null; then
  export _ZO_DATA_DIR="$HOME/.local/share/zoxide"
  export _ZO_ECHO=1
  eval "$(zoxide init zsh)"
fi

# ============================================================================
# Professional/Work tool completions
# ============================================================================

# Kubernetes completion
if command -v kubectl &> /dev/null; then
  source <(kubectl completion zsh)
  # Faster kubectl alias
  alias k='kubectl'
  complete -F __start_kubectl k
fi

# AWS CLI completion
if command -v aws_completer &> /dev/null; then
  complete -C aws_completer aws
fi

# Terraform completion
if command -v terraform &> /dev/null; then
  complete -o nospace -C /usr/bin/terraform terraform
fi

# Helm completion
if command -v helm &> /dev/null; then
  source <(helm completion zsh)
fi
