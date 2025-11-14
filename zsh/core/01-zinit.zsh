#!/usr/bin/env zsh
# Zinit initialization - Auto-install if not present

# Set zinit home directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Force git to use HTTPS for cloning (no SSH, no authentication prompts)
# This is critical for Docker/CI environments without git credentials
export GIT_TERMINAL_PROMPT=0  # Disable credential prompts
export GIT_SSL_NO_VERIFY=0    # Enable SSL verification

# Auto-install zinit if not present
if [[ ! -d "$ZINIT_HOME" ]]; then
   echo "Installing zinit..."
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source zinit
source "${ZINIT_HOME}/zinit.zsh"

# NOTE: compinit is NOT called here
# It's initialized in .zshrc AFTER Starship to prevent display issues
# See: https://github.com/starship/starship/issues/3402

# Enable completion cache for faster lookups (when compinit is called later)
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ${ZDOTDIR:-$HOME}/.zsh/cache

# ============================================================================
# Universal plugins - Loaded on ALL machine types (workstation/homelab/server)
# ============================================================================

# Ghost text suggestions from command history
zinit light zsh-users/zsh-autosuggestions

# Real-time syntax highlighting and command validation
# NOTE: MUST load LAST - do not add plugins after this line
zinit light zdharma-continuum/zsh-fast-syntax-highlighting
