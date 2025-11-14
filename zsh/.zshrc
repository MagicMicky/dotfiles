#!/usr/bin/env zsh
# Ultra-simple zshrc - all config symlinked in ~/.zsh.d/
#
# Structure:
#   ~/.zsh.d/
#   ├── 01-zinit.zsh -> ~/dotfiles/zsh/core/01-zinit.zsh
#   ├── 10-path.zsh -> ~/dotfiles/zsh/core/10-path.zsh
#   ├── 20-env.zsh -> ~/dotfiles/zsh/core/20-env.zsh
#   ├── 30-aliases.zsh -> ~/dotfiles/zsh/core/30-aliases.zsh
#   ├── 40-functions.zsh -> ~/dotfiles/zsh/core/40-functions.zsh
#   ├── plugins.zsh -> ~/dotfiles/zsh/profiles/{machine_profile}/plugins.zsh
#   ├── config.zsh -> ~/dotfiles/zsh/profiles/{machine_profile}/config.zsh
#   ├── overrides.zsh -> ~/dotfiles/zsh/profiles/{machine_profile}/overrides.zsh
#   └── .machine-type (file containing: "wsl", "laptop", "server", or "pro")
#
# Ansible creates these symlinks at deployment time based on machine_profile.
# No runtime logic needed - everything is pre-configured.

# Check if .zsh.d exists
if [[ ! -d ~/.zsh.d ]]; then
  echo "ERROR: ~/.zsh.d directory not found!" >&2
  echo "Run Ansible playbook to set up shell configuration." >&2
  return 1
fi

# Source all config files (numbered files load first due to glob ordering)
for config_file in ~/.zsh.d/*.zsh(N); do
  source "$config_file"
done

# Source work-specific config if present (from mac-playbook-work)
# This contains sensitive work configurations
if [[ -f ~/.zsh.d/work.zsh ]]; then
  source ~/.zsh.d/work.zsh
fi

# Initialize vanilla zsh completion (NO customization in vanilla baseline)
autoload -Uz compinit
compinit

# Stage 2: Starship prompt initialization (minimal)
# Using starship-vanilla.toml (character only, no modules)
# FIX: Tab completion duplication bug requires UTF-8 locale (see core/20-env.zsh)
# GitHub issue: https://github.com/starship/starship/issues/2176
if command -v starship &> /dev/null; then
  export STARSHIP_CONFIG=~/.config/starship.toml
  eval "$(starship init zsh)"
fi

# NO fzf integration - disabled for vanilla testing
# See: _doc/vanilla-roadmap.md Stage 4 for fzf re-enablement

# NO zoxide integration - disabled for vanilla testing
# See: _doc/vanilla-roadmap.md Stage 4 for modern tools

# Print welcome message (helps identify which config is loaded)
if [[ -o interactive ]]; then
  MACHINE_TYPE=$(cat ~/.zsh.d/.machine-type 2>/dev/null || echo "unknown")
  echo "🔧 Vanilla baseline loaded | Profile: $MACHINE_TYPE | Stage: 2 (prompt + directory)"
fi
