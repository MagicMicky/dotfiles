#!/usr/bin/env zsh
# Universal aliases - Common across all machine types
# Profile-specific aliases go in profiles/*/overrides.zsh

# =============================================================================
# Docker & Docker Compose (universal - used on all machines)
# =============================================================================

# Docker Compose
alias dcup='docker-compose up'
alias dcu='docker-compose up -d'
alias dcb='docker-compose build'
alias dcps='docker-compose ps'
alias dcdwn='docker-compose down'
alias dcd='docker-compose down'
alias dcrun='docker-compose run'
alias dcpull='docker-compose pull'
alias dclogs='docker-compose logs'
alias dcl='docker-compose logs -f'
alias dcrestart='docker-compose restart'

# Docker
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

# =============================================================================
# Git (universal - git is everywhere)
# =============================================================================

alias g='git'
alias gs='git status'
alias gst='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gcb='git checkout -b'
alias glog='git log --oneline --graph --decorate'

# =============================================================================
# Navigation & Directory (universal)
# =============================================================================

alias ll='ls -lh'
alias la='ls -lAh'
alias l='ls -lah'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Development navigation (universal pattern, may be overridden per profile)
alias dev='cd ~/Development'
alias dots='cd ~/Development/dotfiles'

# =============================================================================
# Shell utilities (universal)
# =============================================================================

alias h='history'
alias c='clear'
alias reload='source ~/.zshrc'
alias zshconfig='${EDITOR} ~/.zshrc'

# =============================================================================
# Safety aliases (universal - good practice everywhere)
# =============================================================================

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# =============================================================================
# Modern tool replacements (universal - if installed)
# =============================================================================

if (( $+commands[eza] )); then
  alias ls='eza'
  alias ll='eza -l'
  alias la='eza -la'
  alias tree='eza --tree'
else
  # Fallback: enable colors for standard ls
  alias ls='ls --color=auto'
  alias ll='ls -lh --color=auto'
  alias la='ls -lAh --color=auto'
fi

if (( $+commands[bat] )); then
  alias cat='bat'
  alias bathelp='bat --help'
fi

if (( $+commands[fd] )); then
  alias find='fd'
fi

if (( $+commands[rg] )); then
  alias grep='rg'
else
  # Fallback: enable colors for standard grep
  alias grep='grep --color=auto'
  alias egrep='egrep --color=auto'
  alias fgrep='fgrep --color=auto'
fi
