#!/usr/bin/env zsh
# Server profile - Minimal plugins for performance
# Only essential tools to keep shell startup fast

# Essential OMZ library
zinit snippet OMZ::lib/git.zsh

# Essential plugins (loaded with turbo for minimal impact)
zinit ice wait lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh

# No heavy plugins for servers
# No autosuggestions, no syntax highlighting (performance)
# Starship handles the prompt
