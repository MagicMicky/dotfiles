#!/usr/bin/env zsh
# WSL-specific configuration
# NOTE: Theme and modern tools configured in core/25-tools.zsh

# ============================================================================
# WSL-specific configuration
# ============================================================================

# Windows interop
export BROWSER="wslview"

# Display configuration for GUI apps (X11)
if [[ -z "$DISPLAY" ]]; then
  export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
fi

# WSL2-specific: Use Windows SSH agent if available
if [[ -n "$WSL_DISTRO_NAME" ]]; then
  # Windows SSH agent integration (if using wsl-ssh-agent or similar)
  if (( $+commands[npiperelay.exe] )); then
    export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
  fi
fi

# Fix interop path issues
if [[ -n "$WSL_DISTRO_NAME" ]]; then
  # Remove Windows paths from PATH that might cause issues
  # (Optional - comment out if you need Windows executables)
  # PATH=$(echo "$PATH" | tr ':' '\n' | grep -v "/mnt/c" | tr '\n' ':')
fi
