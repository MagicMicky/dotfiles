#!/usr/bin/env zsh
# Environment variables

# Editor
export EDITOR='vim'
export VISUAL='vim'

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Terminal settings - Force fast terminal mode
# In Docker/WSL, zsh may misdetect terminal speed causing rendering issues
# This forces zsh to assume a fast modern terminal
export BAUD=38400

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

# Prompt options
setopt PROMPT_SP                 # Preserve partial lines (may help with Starship rendering)
setopt PROMPT_SUBST              # Enable parameter expansion in prompts
setopt PROMPT_CR                 # Print carriage return before prompt (critical for width calculation)
setopt PROMPT_PERCENT            # Enable percent escapes in prompt

# Correction
setopt CORRECT                   # Spelling correction for commands
setopt CORRECT_ALL               # Spelling correction for arguments

# Completion options
unsetopt ALWAYS_TO_END           # Disable cursor movement (fixes prompt rendering with menu)
setopt AUTO_MENU                 # Show completion menu on successive tab press
setopt AUTO_LIST                 # Automatically list choices on ambiguous completion
setopt AUTO_PARAM_SLASH          # If completed parameter is a directory, add a trailing slash
unsetopt COMPLETE_IN_WORD        # Prevent mid-word completion (fixes menu duplication bug)
unsetopt MENU_COMPLETE           # Do not autoselect the first completion entry
unsetopt LIST_PACKED             # Don't pack completion list (may cause rendering issues)
setopt LIST_ROWS_FIRST           # Sort completions horizontally (may help with rendering)

# Enhanced completion styles (minimal to avoid Starship conflicts)
# TEMPORARILY DISABLED: menu select may cause rendering issues with Starship
# zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' # Case-insensitive matching
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}       # Colorize completions using LS_COLORS
# TEMPORARILY DISABLED: May interfere with prompt width calculation
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'

# CRITICAL FIX: Completely disable all prompts (Starship compatibility)
# This prevents zsh from trying to rewrite the prompt when showing completions
zstyle ':completion:*' list-prompt ''
zstyle ':completion:*' select-prompt ''

# CRITICAL: Tell zsh to ignore prompt escapes when calculating width
# This is THE fix for character duplication
# When zsh lists completions, it tries to move the cursor - but miscalculates position
# These settings tell the completion system "don't try to be clever with cursor positioning"
zstyle ':completion:*' format ''
zstyle ':completion:*' auto-description ''
zstyle ':completion:*' completer _complete
zstyle ':completion:*' insert-tab false

# Disable beep
unsetopt BEEP
unsetopt HIST_BEEP
unsetopt LIST_BEEP
