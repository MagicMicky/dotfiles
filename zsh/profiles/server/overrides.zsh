#!/usr/bin/env zsh
# Server profile - Overrides and additions
# Only SERVER-SPECIFIC aliases and settings go here
# Common aliases are in core/30-aliases.zsh

# System monitoring
alias ports='netstat -tulanp'
alias listening='ss -lntu'
alias psmem='ps auxf | sort -nr -k 4 | head -10'
alias pscpu='ps auxf | sort -nr -k 3 | head -10'

# Disk usage
alias duf='du -sh * | sort -hr'
alias diskspace='df -h'

# Logs
alias logs='journalctl -xe'
alias syslog='tail -f /var/log/syslog'

# Service management (systemd)
alias status='systemctl status'
alias start='sudo systemctl start'
alias stop='sudo systemctl stop'
alias restart='sudo systemctl restart'
alias enable='sudo systemctl enable'
alias disable='sudo systemctl disable'

# Quick navigation (server-specific paths)
alias logdir='cd /var/log'
alias apps='cd /opt'
alias web='cd /var/www'

# NOTE: Git, Docker already in core/30-aliases.zsh
