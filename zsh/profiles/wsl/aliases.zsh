#!/usr/bin/env zsh
# WSL-specific aliases

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

# Network
alias ipconfig='ipconfig.exe'
alias netstat='netstat.exe'

# Useful WSL shortcuts
alias wslu='wsl -u root'
alias wslr='wsl.exe --shutdown'  # Restart WSL

# Update both WSL and system
alias update='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'
