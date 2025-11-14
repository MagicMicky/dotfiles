#!/usr/bin/env zsh
# WSL profile - Workstation enhancements
# Core plugins (autosuggestions, syntax-highlighting) loaded from core/01-zinit.zsh
# This file contains only workstation-specific enhancements

# ============================================================================
# Workstation-specific plugins
# ============================================================================
# Set GIT_TERMINAL_PROMPT=0 only for plugin loading to avoid credential prompts
# This only affects this block, not global git behavior
() {
  local GIT_TERMINAL_PROMPT=0

  # fzf-tab: Fuzzy finder interface for tab completions
  # Replaces default completion menu with fzf for better searchability
  zinit light Aloxaf/fzf-tab
}
