#!/usr/bin/env zsh
# Environment variables - Stage 1: Basic completion options

# Editor
export EDITOR='vim'
export VISUAL='vim'

# Locale
# Use C.UTF-8 as fallback if en_US.UTF-8 is not available (e.g., minimal containers)
# This fixes Starship tab completion duplication bug (GitHub issue #2176)
if locale -a 2>/dev/null | grep -qi "en_US.utf8\|en_US.UTF-8"; then
  export LANG=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
else
  export LANG=C.UTF-8
  export LC_ALL=C.UTF-8
fi

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
setopt INC_APPEND_HISTORY        # Write to history file immediately, not on shell exit
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
# Adding only essential completion setopts and case-insensitive matching
setopt AUTO_MENU                 # Show completion menu on successive tab press
setopt AUTO_LIST                 # List choices on ambiguous completion

# Stage 1 Increment 2: Case-insensitive completion
# Empty string = exact match, second pattern = case-insensitive fallback
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# Stage 1 Increment 3: Colored completions
# Use LS_COLORS for file/directory coloring in completions
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Enable arrow key navigation in completion menu
zstyle ':completion:*' menu select
# Load the complist module for enhanced menu navigation
zmodload zsh/complist

# Stage 2: Testing prompt-related setopts
# Starship sets PROMPT_SUBST which may cause completion issues
# Testing workaround: disable PROMPT_SUBST after Starship init
# NOTE: This must be set BEFORE Starship init in .zshrc

# NOTE: Stage 1 complete - basic completion working with colors
# See: _doc/vanilla-roadmap.md Stage 2

# ============================================================================
# Plugin Configuration - Universal settings for core plugins
# ============================================================================

# zsh-autosuggestions configuration
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
