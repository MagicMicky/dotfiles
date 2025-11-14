#!/usr/bin/env zsh
# Laptop profile - Full featured plugins
# Loads via zinit with turbo mode for fast startup

# OMZ library components (needed for some plugins)
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::lib/clipboard.zsh
zinit snippet OMZ::lib/history.zsh
# NOTE: OMZ::lib/completion.zsh is NOT loaded here
# We'll initialize completion AFTER Starship to avoid display issues

# OMZ plugins - Essential utilities
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/docker/docker.plugin.zsh
zinit snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh
zinit snippet OMZ::plugins/extract/extract.plugin.zsh

# GitHub plugins - DISABLED (stripped down to vanilla completion)
# See PLUGINS.md for descriptions and when to re-enable

# zsh-autosuggestions - Ghost text from history
# zinit light zsh-users/zsh-autosuggestions

# zsh-syntax-highlighting - Command validation as you type
# zinit ice wait lucid
# zinit light zsh-users/zsh-syntax-highlighting

# zsh-history-substring-search - Better history search
# zinit ice wait lucid
# zinit light zsh-users/zsh-history-substring-search
