#!/usr/bin/env zsh
# Machine type detection and environment setup
# This file is sourced first to set up machine-specific variables

# Priority 1: Check for manual override
if [[ -f ~/.config/shell/machine-type ]]; then
  MACHINE_TYPE=$(cat ~/.config/shell/machine-type)
else
  # Priority 2: Hostname-based detection
  if [[ "$HOSTNAME" =~ ^(prod|production) ]]; then
    MACHINE_TYPE="prod"
  elif [[ "$HOSTNAME" =~ ^(pve-dev|dev-|staging) ]]; then
    MACHINE_TYPE="dev-server"
  elif [[ "$HOSTNAME" =~ ^(gaming|game-) ]]; then
    MACHINE_TYPE="gaming-server"
  elif [[ "$HOSTNAME" =~ ^(dedicated|dedi-) ]]; then
    MACHINE_TYPE="dedicated-server"
  elif [[ "$HOSTNAME" =~ ^(homelab|home-|nas) ]]; then
    MACHINE_TYPE="homelab"
  # Priority 3: WSL detection
  elif [[ "$OSTYPE" == "linux-gnu"* ]] && [[ -n "$WSL_DISTRO_NAME" ]]; then
    MACHINE_TYPE="wsl"
  # Priority 4: Check for "pro" laptop indicator
  elif [[ -f ~/.config/shell/laptop-pro ]]; then
    MACHINE_TYPE="laptop-pro"
  # Priority 5: Default to personal laptop
  else
    MACHINE_TYPE="laptop-personal"
  fi
fi

# Export for use in other scripts
export MACHINE_TYPE

# Map to Starship environment variables
case "$MACHINE_TYPE" in
  prod|production)
    export STARSHIP_ENV_CHAR="!"
    export STARSHIP_ENV_COLOR="#FF5370"
    export STARSHIP_SHOW_HOSTNAME="true"
    export STARSHIP_SHOW_LANGS="false"
    ;;
  dev-server)
    export STARSHIP_ENV_CHAR="·"
    export STARSHIP_ENV_COLOR="#FFB86C"
    export STARSHIP_SHOW_HOSTNAME="true"
    export STARSHIP_SHOW_LANGS="true"
    ;;
  gaming-server)
    export STARSHIP_ENV_CHAR="·"
    export STARSHIP_ENV_COLOR="#C792EA"
    export STARSHIP_SHOW_HOSTNAME="true"
    export STARSHIP_SHOW_LANGS="false"
    ;;
  dedicated-server)
    export STARSHIP_ENV_CHAR="·"
    export STARSHIP_ENV_COLOR="#F78C6C"
    export STARSHIP_SHOW_HOSTNAME="true"
    export STARSHIP_SHOW_LANGS="true"
    ;;
  homelab)
    export STARSHIP_ENV_CHAR="·"
    export STARSHIP_ENV_COLOR="#89DDFF"
    export STARSHIP_SHOW_HOSTNAME="true"
    export STARSHIP_SHOW_LANGS="true"
    ;;
  wsl)
    export STARSHIP_ENV_CHAR="λ"
    export STARSHIP_ENV_COLOR="#82AAFF"
    export STARSHIP_SHOW_HOSTNAME="true"
    export STARSHIP_SHOW_LANGS="true"
    ;;
  laptop-pro)
    export STARSHIP_ENV_CHAR="λ"
    export STARSHIP_ENV_COLOR="#7FDBCA"
    export STARSHIP_SHOW_HOSTNAME="false"
    export STARSHIP_SHOW_LANGS="true"
    ;;
  laptop-personal|*)
    export STARSHIP_ENV_CHAR="λ"
    export STARSHIP_ENV_COLOR="#82AAFF"
    export STARSHIP_SHOW_HOSTNAME="false"
    export STARSHIP_SHOW_LANGS="true"
    ;;
esac

# Root user detection
if [[ $UID -eq 0 ]] || [[ $(whoami) = "root" ]]; then
  export STARSHIP_IS_ROOT="true"
  export STARSHIP_SHOW_HOSTNAME="true"  # Always show hostname for root
else
  export STARSHIP_IS_ROOT="false"
fi
