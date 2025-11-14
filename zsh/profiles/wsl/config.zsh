#!/usr/bin/env zsh
# WSL-specific configuration
# NOTE: No cross-profile sourcing - each profile is independent

# Load Catppuccin theme (LS_COLORS, BAT_THEME, FZF colors, etc.)
if [[ -f "$HOME/.config/shell/theme.zsh" ]]; then
  source "$HOME/.config/shell/theme.zsh"
fi

# Windows interop
export BROWSER="wslview"

# Display configuration for GUI apps (X11)
if [[ -z "$DISPLAY" ]]; then
  export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
fi

# WSL2-specific: Use Windows SSH agent if available
if [[ -n "$WSL_DISTRO_NAME" ]]; then
  # Windows SSH agent integration (if using wsl-ssh-agent or similar)
  if command -v npiperelay.exe &> /dev/null; then
    export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
  fi
fi

# Fix interop path issues
if [[ -n "$WSL_DISTRO_NAME" ]]; then
  # Remove Windows paths from PATH that might cause issues
  # (Optional - comment out if you need Windows executables)
  # PATH=$(echo "$PATH" | tr ':' '\n' | grep -v "/mnt/c" | tr '\n' ':')
fi
