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

# Load completions - but cache the dump file
# Only regenerate once per day or when dump is missing/stale
autoload -Uz compinit

# Check if dump file needs regeneration (older than 24 hours)
setopt EXTENDEDGLOB
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  # Dump is old or missing, regenerate with security check
  compinit
else
  # Use cached dump, skip security check for speed
  compinit -C
fi

# Enable completion cache for faster lookups
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ${ZDOTDIR:-$HOME}/.zsh/cache
