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

# Initialize vanilla zsh completion with caching (rebuild once per day)
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Stage 2: Starship prompt initialization (minimal)
# Using starship-vanilla.toml (character only, no modules)
# FIX: Tab completion duplication bug requires UTF-8 locale (see core/20-env.zsh)
# GitHub issue: https://github.com/starship/starship/issues/2176
if (( $+commands[starship] )); then
  export STARSHIP_CONFIG=~/.config/starship.toml
  eval "$(starship init zsh)"
fi

# Stage 4: fzf key bindings
# Ctrl-R: fuzzy history search, Ctrl-T: fuzzy file finder, Alt-C: fuzzy cd
if (( $+commands[fzf] )); then
  # Try common fzf keybinding locations
  if [[ -f ~/.fzf/shell/key-bindings.zsh ]]; then
    # fzf installed from git in ~/.fzf
    source ~/.fzf/shell/key-bindings.zsh
    source ~/.fzf/shell/completion.zsh
  elif [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
  elif [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
    source /usr/share/fzf/key-bindings.zsh
  elif [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
  fi
fi

# NOTE: zoxide is initialized in 25-tools.zsh (removed duplicate here)

# Print welcome message (helps identify which config is loaded)
if [[ -o interactive ]]; then
  MACHINE_TYPE=$(cat ~/.zsh.d/.machine-type 2>/dev/null || echo "unknown")
  echo "🔧 Vanilla baseline loaded | Profile: $MACHINE_TYPE | Stage: Complete (full baseline)"
fi

# bun completions
[ -s "/home/magicmicky/.bun/_bun" ] && source "/home/magicmicky/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
