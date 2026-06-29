#!/usr/bin/env zsh
# Universal functions - Common across all machine types

# mkdir and cd into it
function mkcd() {
  mkdir -p "$@" && cd "$_"
}

# Extract various archive formats
function extract() {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Legacy find function (fallback if fd not installed)
if (( ! $+commands[fd] )); then
  function f() {
    find . -iname "*$1*" ${@:2}
  }
fi

# Legacy grep function (fallback if ripgrep not installed)
if (( ! $+commands[rg] )); then
  function r() {
    grep "$1" ${@:2} -R .
  }
fi

# Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@"
}

# Get current public IP
function myip() {
  curl -s https://api.ipify.org
  echo
}

# Weather function (using wttr.in)
function weather() {
  local location="$1"
  if [ -z "$location" ]; then
    curl -s "https://wttr.in/?format=3"
  else
    curl -s "https://wttr.in/$location?format=3"
  fi
}

# Create a backup copy of a file
function backup() {
  if [ -f "$1" ]; then
    cp "$1" "$1.backup-$(date +%Y%m%d-%H%M%S)"
    echo "Backed up: $1"
  else
    echo "File not found: $1"
  fi
}

# Git helpers
function gi() {
  # Get .gitignore from gitignore.io
  curl -sL "https://www.gitignore.io/api/$1"
}

# ============================================================================
# Arrow key history navigation - Universal feature for all profiles
# ============================================================================

# Smart history search: searches for commands that start with what you've typed
# Example: type "git" and press UP to see only commands starting with "git"
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Bind to arrow keys using terminfo (portable across terminals)
# Only bind if terminfo keys are available
[[ -n "${terminfo[kcuu1]}" ]] && bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search    # Up arrow
[[ -n "${terminfo[kcud1]}" ]] && bindkey "${terminfo[kcud1]}" down-line-or-beginning-search  # Down arrow

# Fallback bindings for terminals without proper terminfo
bindkey "^[[A" up-line-or-beginning-search  # Up arrow fallback
bindkey "^[[B" down-line-or-beginning-search  # Down arrow fallback

# ============================================================================
# Word-wise navigation - Alt+Left/Right (and Ctrl+Left/Right where emitted)
# ============================================================================

# WORDCHARS controls what counts as part of a "word" for forward/backward-word.
# This matches the old Prezto behavior: drop / and = from the zsh default so
# path separators are word boundaries, while keeping . - _ inside words
# (e.g. "foo/bar" = two words, but "my-file_name.txt" = one word).
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# No terminfo entries exist for Alt/Ctrl + arrow, so bind the common escape
# sequences emitted by different terminals to the same widget:
#   ^[[1;3x = Alt    ^[[1;9x = iTerm2 natural editing
#   ^[b/^[f = Option-as-Meta    ^[[1;5x = Ctrl
for seq in '^[[1;3D' '^[[1;9D' '^[^[[D' '^[b' '^[[1;5D'; do
  bindkey "$seq" backward-word   # Alt/Ctrl + Left
done
for seq in '^[[1;3C' '^[[1;9C' '^[^[[C' '^[f' '^[[1;5C'; do
  bindkey "$seq" forward-word    # Alt/Ctrl + Right
done

# Alt+Backspace: delete the previous word (WORDCHARS-aware, so it stops at /)
bindkey '^[^?' backward-kill-word
