#!/usr/bin/env zsh
# Pro/Work profile - Extends laptop with work-specific plugins
# Non-sensitive work tools and plugins

# AWS plugin
zinit snippet OMZ::plugins/aws/aws.plugin.zsh

# Terraform plugin
zinit snippet OMZ::plugins/terraform/terraform.plugin.zsh

# Helm plugin
zinit snippet OMZ::plugins/helm/helm.plugin.zsh

# Kubectl plugin
zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh

# Vault plugin (if using Hashicorp Vault)
zinit snippet OMZ::plugins/vault/vault.plugin.zsh
