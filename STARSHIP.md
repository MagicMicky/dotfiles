# Starship Configuration

## Location

Starship configuration is **NOT** stored in this dotfiles repository.

Instead, it is managed by **Ansible templates** in the `ansible-playbooks` repository:

```
ansible-playbooks/roles/common-shell/templates/starship.toml.j2
```

## Why Ansible Templates?

- **Build-time configuration**: Machine type, colors, and features are determined during deployment
- **Single source of truth**: No need to maintain multiple configs (vanilla, minimal, full, etc.)
- **Environment-specific**: Different machines get different prompts automatically
- **DRY principle**: Configuration logic lives in Ansible, not duplicated across config files

## Deployment

When you run an Ansible playbook (e.g., `playbooks/mac/personal.yml` or `playbooks/wsl/setup.yml`), it:

1. Detects machine type (laptop, server, pro, wsl)
2. Generates `~/.config/starship.toml` from template
3. Sets appropriate colors and symbols based on machine profile

## Current Configuration (Stage 2 - Vanilla Testing)

During vanilla baseline testing, the Starship config is minimal:
- Format: `$directory$character`
- Directory: Full path in cyan
- Character: Green `❯` (success) / Red `❯` (error)
- No git modules, no other features (testing incrementally)

**Testing status**: See `_doc/vanilla-roadmap.md` for progress

## Future: Machine-Specific Theming

After vanilla testing completes (Stages 3-5), we'll implement:
- 3-color scheme (blue/yellow/red for safe/caution/danger)
- Symbol differentiation (λ, !, ·)
- Git integration for development machines
- Build-time profile detection in Ansible template

## Manual Override

If you need to test different machine types:

```bash
# Override machine type
mkdir -p ~/.config/shell
echo "prod" > ~/.config/shell/machine-type

# Then redeploy with Ansible to regenerate config
```

Options: `wsl`, `laptop`, `server`, `pro`

## Resources

- [Starship Documentation](https://starship.rs/)
- [Configuration Reference](https://starship.rs/config/)
- Ansible template: `ansible-playbooks/roles/common-shell/templates/starship.toml.j2`
