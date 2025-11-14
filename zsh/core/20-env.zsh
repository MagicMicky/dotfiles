#!/usr/bin/env zsh
# Environment variables

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

# Prompt options
setopt PROMPT_SP                 # Preserve partial lines (may help with Starship rendering)
setopt PROMPT_SUBST              # Enable parameter expansion in prompts

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

# Enhanced completion styles (vanilla + visual improvements)
zstyle ':completion:*' menu select                          # Enable arrow key navigation in menu
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' # Case-insensitive matching
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}       # Colorize completions using LS_COLORS
zstyle ':completion:*' group-name ''                        # Group completions by type
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f' # Yellow headers for groups

# Fix for completion list prompt rendering (Starship compatibility)
zstyle ':completion:*' list-prompt ''                       # Disable list continuation prompt
zstyle ':completion:*' select-prompt ''                     # Disable selection prompt

# Disable beep
unsetopt BEEP
unsetopt HIST_BEEP
unsetopt LIST_BEEP
