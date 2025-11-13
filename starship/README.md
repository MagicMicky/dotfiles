# Starship Prompt Configuration

This unified Starship configuration adapts to different machine types through environment variables set by the shell detection script.

## Character System

Visual machine differentiation using three characters:

- **λ** (lambda) - Laptops/Workstations (Personal, Pro, WSL)
- **!** (exclamation) - Production Servers
- **·** (middle dot) - Other Servers (Dev, Gaming, Dedicated, Homelab)

## Environment Colors

| Environment | Character | Color | Hex Code |
|-------------|-----------|-------|----------|
| Personal | λ | Blue | #82AAFF |
| Pro | λ | Cyan/Teal | #7FDBCA |
| WSL | λ | Blue | #82AAFF |
| Production | ! | Red | #FF5370 |
| Dev Server | · | Orange | #FFB86C |
| Gaming | · | Purple | #C792EA |
| Dedicated | · | Coral | #F78C6C |
| Homelab | · | Cyan | #89DDFF |

## Prompt Examples

### Personal Laptop
```
[λ] ~/Development/dotfiles on  main [!+]
❯
```

### Production Server (Red Alert)
```
[!] prod-web-01 ~/app on  main
❯
```

### Dev Server (Orange)
```
[·] dev-01 ~/project on  develop [!+]
❯
```

### Root User on Production (Maximum Alert)
```
root@prod-web-01 [!] /opt
#
```

## Manual Override

Override machine type detection:

```bash
mkdir -p ~/.config/shell
echo "prod" > ~/.config/shell/machine-type
```

Options: `prod`, `dev-server`, `gaming-server`, `dedicated-server`, `homelab`, `wsl`, `laptop-personal`, `laptop-pro`

Enable pro profile (work laptop):

```bash
touch ~/.config/shell/laptop-pro
```

## Configuration

The configuration is driven by environment variables set in `zsh/core/00-detect.zsh`:

- `STARSHIP_ENV_CHAR` - Character to display (λ, !, ·)
- `STARSHIP_ENV_COLOR` - Color hex code
- `STARSHIP_SHOW_HOSTNAME` - Whether to show hostname
- `STARSHIP_SHOW_LANGS` - Whether to show language versions
- `STARSHIP_IS_ROOT` - Whether running as root user

## Customization

Edit `starship.toml` to customize:

- Shorter directory path: Change `truncation_length`
- Disable language indicators: Set module to `disabled = true`
- Change git status symbols: Modify `[git_status]` section
- Add custom modules: See [Starship docs](https://starship.rs/)

## Installation

Starship is installed automatically via Ansible playbooks or manually:

```bash
# macOS
brew install starship

# Linux
curl -sS https://starship.rs/install.sh | sh
```

## Testing

Test different machine types:

```bash
# Test as personal laptop
export MACHINE_TYPE="laptop-personal"
source ~/.zshrc

# Test as production server
export MACHINE_TYPE="prod"
source ~/.zshrc

# Test as root
sudo -s
source ~/.zshrc
```

## Features

- **Fast**: Written in Rust, minimal startup overhead
- **Customizable**: Extensive configuration options
- **Cross-shell**: Works with zsh, bash, fish, PowerShell
- **Git-aware**: Shows branch, status, and operations
- **Language-aware**: Detects Python, Node, Go, Rust, etc.
- **Context-aware**: Shows Docker, Kubernetes, AWS contexts

## Accessibility

- Character indicators provide primary differentiation
- Color is secondary enhancement (not required to distinguish types)
- Works with all modern terminals
- No reliance on emoji rendering
- High contrast color palette

## Resources

- [Starship Documentation](https://starship.rs/)
- [Configuration Reference](https://starship.rs/config/)
- [Presets](https://starship.rs/presets/)
