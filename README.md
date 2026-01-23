# Dotfiles

Modern shell configuration using Zinit + Starship, deployed via Ansible.

## Quick Start

These dotfiles are designed to be deployed via Ansible playbooks from [ansible-playbooks](https://github.com/MagicMicky/ansible-playbooks). Manual installation is possible but not recommended.

```bash
# Via Ansible (recommended)
cd ~/Development/terminal_improvements/ansible-playbooks
make wsl        # For WSL
make mac-personal  # For macOS
```

## Structure

```
dotfiles/
├── zsh/
│   ├── .zshrc              # Entry point - sources ~/.zsh.d/*
│   ├── core/               # Universal configs (all machines)
│   │   ├── 01-zinit.zsh    # Plugin manager setup
│   │   ├── 10-path.zsh     # PATH configuration
│   │   ├── 20-env.zsh      # Environment + UTF-8 fix
│   │   ├── 25-tools.zsh    # Tool integrations
│   │   ├── 30-aliases.zsh  # Common aliases
│   │   └── 40-functions.zsh # Helper functions
│   └── profiles/           # Machine-specific configs
│       ├── laptop/         # Personal laptop
│       ├── pro/            # Work laptop
│       ├── server/         # Servers (minimal)
│       └── wsl/            # Windows WSL
├── git/                    # Git configuration
├── vim/                    # Vim configuration
└── scripts/                # Utility scripts
```

## How It Works

Ansible creates symlinks in `~/.zsh.d/` pointing to these files:

```
~/.zsh.d/
├── 01-zinit.zsh    -> ~/dotfiles/zsh/core/01-zinit.zsh
├── 10-path.zsh     -> ~/dotfiles/zsh/core/10-path.zsh
├── 20-env.zsh      -> ~/dotfiles/zsh/core/20-env.zsh
├── 25-tools.zsh    -> ~/dotfiles/zsh/core/25-tools.zsh
├── 30-aliases.zsh  -> ~/dotfiles/zsh/core/30-aliases.zsh
├── 40-functions.zsh -> ~/dotfiles/zsh/core/40-functions.zsh
├── config.zsh      -> ~/dotfiles/zsh/profiles/{profile}/config.zsh
├── overrides.zsh   -> ~/dotfiles/zsh/profiles/{profile}/overrides.zsh
├── plugins.zsh     -> ~/dotfiles/zsh/profiles/{profile}/plugins.zsh
└── .machine-type   # Contains: laptop, pro, server, or wsl
```

The `.zshrc` sources all `*.zsh` files in `~/.zsh.d/` alphabetically.

## Machine Profiles

| Profile | Description | Prompt |
|---------|-------------|--------|
| **laptop** | Full-featured personal setup | Blue λ |
| **pro** | Work laptop with extra tools | Cyan λ |
| **server** | Minimal for performance | Varies |
| **wsl** | WSL with Windows integration | Blue λ |

## Modern Tool Stack

- **[Zinit](https://github.com/zdharma-continuum/zinit)** - Fast plugin manager
- **[Starship](https://starship.rs/)** - Cross-shell prompt
- **[fzf](https://github.com/junegunn/fzf)** - Fuzzy finder (Ctrl+R, Ctrl+T)
- **[zoxide](https://github.com/ajeetdsouza/zoxide)** - Smart cd (`z` command)
- **[bat](https://github.com/sharkdp/bat)** - Better cat
- **[eza](https://github.com/eza-community/eza)** - Better ls
- **[fd](https://github.com/sharkdp/fd)** - Better find
- **[ripgrep](https://github.com/BurntSushi/ripgrep)** - Better grep

## Key Bindings

| Binding | Action |
|---------|--------|
| `Ctrl+R` | Fuzzy history search (fzf) |
| `Ctrl+T` | Fuzzy file finder (fzf) |
| `Alt+C` | Fuzzy cd (fzf) |
| `z <dir>` | Smart directory jump (zoxide) |

## Common Aliases

```bash
# Navigation
..          # cd ..
...         # cd ../..
~           # cd ~

# Git
g           # git
gs          # git status
gd          # git diff
gco         # git checkout
gp          # git push

# Docker
d           # docker
dc          # docker compose
dps         # docker ps

# Modern replacements (when installed)
ls          # eza (if available)
cat         # bat (if available)
find        # fd (if available)
grep        # rg (if available)
```

## Performance

Target shell startup times:
- **Laptop/WSL**: <100ms (typical: 50-80ms)
- **Server**: <50ms (typical: 30-50ms)

Measure with: `time zsh -i -c exit`

## Troubleshooting

### Tab completion duplicates characters
Fixed in `zsh/core/20-env.zsh` - ensures UTF-8 locale before Starship init.

### Zinit not loading plugins
Run `zinit self-update` then restart shell. First startup takes ~10-15s to download plugins.

### Machine type not detected
Check `~/.zsh.d/.machine-type` exists and contains correct profile name.

## Related Repositories

- [ansible-playbooks](https://github.com/MagicMicky/ansible-playbooks) - Deployment automation
- [mac-playbook-work](https://github.com/MagicMicky/mac-playbook-work) - Work-specific configs (private)
