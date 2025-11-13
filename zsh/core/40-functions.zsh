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
if ! command -v fd &> /dev/null; then
  function f() {
    find . -iname "*$1*" ${@:2}
  }
fi

# Legacy grep function (fallback if ripgrep not installed)
if ! command -v rg &> /dev/null; then
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
