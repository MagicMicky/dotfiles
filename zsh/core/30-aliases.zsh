#!/usr/bin/env zsh
# Universal aliases - Common across all machine types

# Docker Compose aliases
alias dcup='docker-compose up'
alias dcb='docker-compose build'
alias dcps='docker-compose ps'
alias dcdwn='docker-compose down'
alias dcrun='docker-compose run'
alias dcpull='docker-compose pull'
alias dclogs='docker-compose logs'
alias dcrestart='docker-compose restart'

# Docker aliases
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drmi='docker rmi'
alias drm='docker rm'
alias dstop='docker stop'
alias dstart='docker start'
alias dlogs='docker logs'
alias dexec='docker exec -it'

# Docker typo fixes
alias dokcer='docker'
alias docekr='docker'

# General shortcuts
alias ll='ls -lh'
alias la='ls -lAh'
alias l='ls -lah'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git aliases (basic - more provided by OMZ git plugin)
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'

# Safety aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Navigation
alias dev='cd ~/Development'
alias dots='cd ~/Development/dotfiles'

# Modern tool replacements (if installed)
if command -v eza &> /dev/null; then
  alias ls='eza'
  alias ll='eza -l'
  alias la='eza -la'
  alias tree='eza --tree'
fi

if command -v bat &> /dev/null; then
  alias cat='bat'
  alias bathelp='bat --help'
fi

if command -v fd &> /dev/null; then
  alias find='fd'
fi
