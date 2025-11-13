#!/usr/bin/env zsh
# Laptop-specific aliases

# Development shortcuts
alias dev='cd ~/Development'
alias dots='cd ~/Development/dotfiles'
alias infra='cd ~/Development/infra'

# Git shortcuts (additional to OMZ git plugin)
alias gst='git status'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gaa='git add --all'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'
alias glog='git log --oneline --graph --decorate'

# Docker shortcuts
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias dcl='docker-compose logs -f'

# System maintenance (macOS specific)
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias update='brew update && brew upgrade && brew cleanup'
  alias cleanup='brew cleanup && rm -rf ~/Library/Caches/Homebrew/*'
fi

# Useful shortcuts
alias h='history'
alias c='clear'
alias reload='source ~/.zshrc'
alias zshconfig='${EDITOR} ~/.zshrc'
