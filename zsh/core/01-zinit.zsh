#!/usr/bin/env zsh
# Zinit initialization - Auto-install if not present

# Set zinit home directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

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
# Turbo mode: plugins load after prompt appears for faster startup
# ============================================================================

# Ghost text suggestions from command history
zinit ice wait'0' lucid
zinit light zsh-users/zsh-autosuggestions

# Real-time syntax highlighting and command validation
# NOTE: MUST load LAST - do not add plugins after this line
zinit ice wait'0' lucid
zinit light zdharma-continuum/fast-syntax-highlighting
