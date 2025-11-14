#!/usr/bin/env zsh
# Pro/Work-specific configuration (non-sensitive)
# NOTE: Theme and modern tools configured in core/25-tools.zsh

# ============================================================================
# Professional/Work tool completions
# ============================================================================

# Kubernetes completion
if command -v kubectl &> /dev/null; then
  source <(kubectl completion zsh)
  # Faster kubectl alias
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
