#!/usr/bin/env zsh
# PATH configuration

# Base PATH
export PATH="/usr/local/share/python:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Homebrew (macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
  if [[ -d "/opt/homebrew/bin" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
  fi
  if [[ -d "/opt/homebrew/sbin" ]]; then
    export PATH="/opt/homebrew/sbin:$PATH"
  fi
fi

# User bin directories
if [[ -d "$HOME/.bin" ]]; then
  export PATH="$HOME/.bin:$PATH"
fi

if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# NOTE: User-installed tools (fzf, zoxide, etc.) are symlinked to ~/.local/bin
# by Ansible, so no tool-specific PATH entries needed here

# NOTE: Using directory check instead of $+commands[go] - the latter is slow (~80ms)
# because zsh scans PATH to build command hash on first access
if [[ -d "/usr/local/go" ]]; then
  export GOPATH=$HOME/Development/golang
  export GOROOT="${GOROOT:-/usr/local/go}"
  export PATH=$PATH:$GOPATH/bin:$GOROOT/bin
fi
