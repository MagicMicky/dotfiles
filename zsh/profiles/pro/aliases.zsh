#!/usr/bin/env zsh
# Pro/work-specific aliases (non-sensitive)
# Sensitive configs should remain in mac-playbook-work

# Kubernetes shortcuts
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kgn='kubectl get nodes'
alias kga='kubectl get all'
alias kdp='kubectl describe pod'
alias kds='kubectl describe service'
alias kdd='kubectl describe deployment'
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias kex='kubectl exec -it'
alias kctx='kubectl config use-context'
alias kns='kubectl config set-context --current --namespace'

# Terraform shortcuts
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tfv='terraform validate'
alias tfo='terraform output'
alias tfw='terraform workspace'
alias tfws='terraform workspace select'
alias tfwl='terraform workspace list'

# AWS shortcuts
alias awsp='export AWS_PROFILE='
alias awsl='aws configure list-profiles'

# Helm shortcuts
alias h='helm'
alias hi='helm install'
alias hu='helm upgrade'
alias hls='helm list'
alias hs='helm search'

# Docker shortcuts for dev
alias dkill='docker kill $(docker ps -q)'
alias dclean='docker system prune -af'

# Navigation
alias work='cd ~/Development/work'
