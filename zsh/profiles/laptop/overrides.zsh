#!/usr/bin/env zsh
# Laptop profile - Overrides and additions
# Only LAPTOP-SPECIFIC aliases and settings go here
# Common aliases are in core/30-aliases.zsh

# macOS-specific shortcuts
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias update='brew update && brew upgrade && brew cleanup'
  alias cleanup='brew cleanup && rm -rf ~/Library/Caches/Homebrew/*'
fi

# Additional navigation (laptop-specific projects)
alias infra='cd ~/Development/infra'

# NOTE: Git, Docker, common navigation already in core/30-aliases.zsh
