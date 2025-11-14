#!/usr/bin/env zsh
# WSL profile - Stage 3: Visual Enhancements
# Adding plugins incrementally to test for bugs
# See: _doc/vanilla-roadmap.md for progression plan

# Stage 3 Increment 1: zsh-autosuggestions
# Ghost text from history - least likely to interfere with completion
zinit light zsh-users/zsh-autosuggestions

# Stage 3 Increment 2: zsh-syntax-highlighting
# Command validation - must load LAST (after all other plugins)
zinit light zsh-users/zsh-syntax-highlighting

# Stage 3 TODO: Add more plugins if needed:
# - zsh-history-substring-search (better Ctrl-R) - optional
