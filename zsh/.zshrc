#!/usr/bin/env zsh
# Main zshrc - Modern shell configuration
# This file sources all configuration in the correct order

# Determine dotfiles location dynamically
# Resolve .zshrc symlink to find actual dotfiles directory
if [[ -L "${HOME}/.zshrc" ]]; then
  # .zshrc is symlinked - resolve to find dotfiles repo
  # readlink -f follows all symlinks to get the real path
  ZSHRC_REAL_PATH=$(readlink -f "${HOME}/.zshrc")
  # Go up two directories: /path/to/dotfiles/zsh/.zshrc -> /path/to/dotfiles
  DOTFILES_DIR=$(dirname $(dirname "$ZSHRC_REAL_PATH"))
else
  # Fallback to default location if .zshrc is not a symlink
  DOTFILES_DIR="${HOME}/Development/dotfiles"
fi

# Verify DOTFILES_DIR exists before proceeding
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "ERROR: Dotfiles directory not found: $DOTFILES_DIR" >&2
  echo "Cannot load shell configuration" >&2
  if [[ -L "${HOME}/.zshrc" ]]; then
    echo "Note: .zshrc is symlinked from: $(readlink -f "${HOME}/.zshrc")" >&2
  else
    echo "Note: .zshrc is not symlinked. Expected symlink from dotfiles repo" >&2
  fi
  return 1
fi

# Source core configuration (in order)
for config_file in ${DOTFILES_DIR}/zsh/core/*.zsh; do
  [[ -f "$config_file" ]] && source "$config_file"
done

# Source profile-specific configuration based on detected machine type
case "$MACHINE_TYPE" in
  laptop-personal|laptop-pro)
    # Load laptop profile
    for config_file in ${DOTFILES_DIR}/zsh/profiles/laptop/*.zsh; do
      [[ -f "$config_file" ]] && source "$config_file"
    done
    ;;
  wsl)
    # Load WSL profile
    for config_file in ${DOTFILES_DIR}/zsh/profiles/wsl/*.zsh; do
      [[ -f "$config_file" ]] && source "$config_file"
    done
    ;;
  prod|dev-server|gaming-server|dedicated-server|homelab)
    # Load server profile
    for config_file in ${DOTFILES_DIR}/zsh/profiles/server/*.zsh; do
      [[ -f "$config_file" ]] && source "$config_file"
    done
    ;;
esac

# Source pro profile if enabled (work-specific, non-sensitive)
if [[ -f ~/.config/shell/laptop-pro ]]; then
  for config_file in ${DOTFILES_DIR}/zsh/profiles/pro/*.zsh; do
    [[ -f "$config_file" ]] && source "$config_file"
  done
fi

# Source work-specific config if present (from mac-playbook-work)
# This contains sensitive work configurations
if [[ -f ~/.zsh.d/zworkenv ]]; then
  source ~/.zsh.d/zworkenv
fi

# Initialize Starship prompt
if command -v starship &> /dev/null; then
  # Use starship config from dotfiles
  if [[ -f "${DOTFILES_DIR}/starship/starship.toml" ]]; then
    export STARSHIP_CONFIG="${DOTFILES_DIR}/starship/starship.toml"
  fi
  eval "$(starship init zsh)"
fi

# Initialize modern tools
# fzf - Fuzzy finder
if command -v fzf &> /dev/null; then
  # Load fzf key bindings and completion
  if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
  elif [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
  fi

  if [[ -f /usr/share/doc/fzf/examples/completion.zsh ]]; then
    source /usr/share/doc/fzf/examples/completion.zsh
  fi

  # fzf configuration
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

  # Use fd if available for fzf
  if command -v fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  fi
fi

# zoxide - Smart directory jumper
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Print welcome message (optional, can be removed if annoying)
if [[ -o interactive ]]; then
  echo "🚀 Modern shell loaded | Machine: $MACHINE_TYPE"
fi
