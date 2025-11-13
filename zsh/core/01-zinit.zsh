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

# Load completions
autoload -Uz compinit
compinit

# Enable cache for faster startup
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
