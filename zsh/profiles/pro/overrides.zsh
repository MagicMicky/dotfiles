#!/usr/bin/env zsh
# Pro/work profile - Overrides and additions
# Only WORK-SPECIFIC aliases and settings go here
# Common aliases are in core/30-aliases.zsh
# SENSITIVE work configs remain in mac-playbook-work repository

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

# Docker cleanup (dev environments)
alias dkill='docker kill $(docker ps -q)'
alias dclean='docker system prune -af'

# Navigation
alias work='cd ~/Development/work'

# NOTE: Git, Docker, common navigation already in core/30-aliases.zsh
