#!/usr/bin/env zsh
# Pro/Work-specific configuration (non-sensitive)
# NOTE: Theme and modern tools configured in core/25-tools.zsh

# ============================================================================
# Professional/Work tool completions
# ============================================================================
# NOTE: These run early in .zshrc load, before compinit
# Completions that need compinit should use hooks or lazy loading

# Defer completions until after compinit runs (via precmd hook)
_setup_pro_completions() {
  # Remove this hook after first run
  precmd_functions=(${precmd_functions:#_setup_pro_completions})

  # Enable bash-style completions
  autoload -U +X bashcompinit && bashcompinit

  # Kubernetes completion
  if command -v kubectl &> /dev/null; then
    source <(kubectl completion zsh)
    alias k='kubectl'
    complete -F __start_kubectl k
  fi

  # AWS CLI completion
  if command -v aws_completer &> /dev/null; then
    complete -C aws_completer aws
  fi

  # Terraform completion
  if command -v terraform &> /dev/null; then
    complete -o nospace -C /usr/bin/terraform terraform
  fi

  # Helm completion
  if command -v helm &> /dev/null; then
    source <(helm completion zsh)
  fi
}

# Register hook to run after first prompt (when compinit is ready)
precmd_functions+=(_setup_pro_completions)
