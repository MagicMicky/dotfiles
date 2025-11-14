#!/usr/bin/env zsh
# Server-specific configuration
# Optimized for minimal resource usage
# NOTE: Theme configured in core/25-tools.zsh

# ============================================================================
# Server-specific optimizations
# ============================================================================

# Reduced history size for servers
export HISTSIZE=10000
export SAVEHIST=10000

# Disable correction on servers (can be annoying)
unsetopt CORRECT
unsetopt CORRECT_ALL

# Faster prompt rendering
setopt PROMPT_SUBST
