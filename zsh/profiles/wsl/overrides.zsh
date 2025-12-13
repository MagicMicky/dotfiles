#!/usr/bin/env zsh
# WSL profile - Overrides and additions
# Only WSL-SPECIFIC aliases and settings go here
# Common aliases are in core/30-aliases.zsh

# Windows integration
alias winhome='cd /mnt/c/Users/$USER'
alias windocs='cd /mnt/c/Users/$USER/Documents'
alias windown='cd /mnt/c/Users/$USER/Downloads'
alias explorer='explorer.exe'
alias cmd='cmd.exe'
alias powershell='powershell.exe'

# Open current directory in Windows Explorer
alias open='explorer.exe .'

# WSL utilities
alias wsl='wsl.exe'
alias clip='clip.exe'  # Copy to Windows clipboard

# Network (Windows tools)
alias ipconfig='ipconfig.exe'
alias netstat='netstat.exe'

# WSL management
alias wslu='wsl -u root'
alias wslr='wsl.exe --shutdown'  # Restart WSL

# System update (Debian/Ubuntu specific)
alias update='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'

# NOTE: Git, Docker, common navigation already in core/30-aliases.zsh
