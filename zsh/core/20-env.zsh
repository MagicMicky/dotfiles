#!/usr/bin/env zsh
# Environment variables - Stage 1: Basic completion options

# Editor
export EDITOR='vim'
export VISUAL='vim'

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# History configuration
export HISTSIZE=50000
export SAVEHIST=50000
export HISTFILE=~/.zsh_history

# History options
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file
setopt HIST_VERIFY               # Do not execute immediately upon history expansion
setopt SHARE_HISTORY             # Share history between all sessions

# Other zsh options
setopt AUTO_CD                   # Auto cd to a directory without typing cd
setopt AUTO_PUSHD                # Push the old directory onto the stack on cd
setopt PUSHD_IGNORE_DUPS         # Do not store duplicates in the stack
setopt PUSHD_SILENT              # Do not print the directory stack after pushd or popd

# Disable beep
unsetopt BEEP
unsetopt HIST_BEEP
unsetopt LIST_BEEP

# Stage 1: Basic completion options (testing incrementally)
# Adding only essential completion setopts, no zstyles yet
setopt AUTO_MENU                 # Show completion menu on successive tab press
setopt AUTO_LIST                 # List choices on ambiguous completion

# NOTE: No other completion options yet - testing these first
# NOTE: No prompt options - using zsh defaults
# See: _doc/vanilla-roadmap.md Stage 1
