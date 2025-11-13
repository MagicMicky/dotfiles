#!/usr/bin/env zsh
# Server-specific configuration
# Optimized for minimal resource usage

# Reduced history size for servers
export HISTSIZE=10000
export SAVEHIST=10000

# Simpler completion (faster)
setopt NO_MENU_COMPLETE
setopt NO_AUTO_MENU

# Disable correction on servers (can be annoying)
unsetopt CORRECT
unsetopt CORRECT_ALL

# Faster prompt rendering
setopt PROMPT_SUBST
