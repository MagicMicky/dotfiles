# Zsh Plugins - Modern Shell 2025

This document describes the plugin architecture and modern shell tools used in our dotfiles configuration.

## Architecture Overview

The plugin system uses a **layered approach** with clear separation between universal features and profile-specific enhancements:

```
Core Layer (ALL profiles)
├── zinit plugin manager
├── zsh-autosuggestions (ghost text from history)
├── zsh-fast-syntax-highlighting (command validation)
└── Arrow key history navigation

Workstation Layer (laptop/pro/wsl only)
├── fzf-tab (fuzzy completion interface)
├── fzf enhanced configuration (previews)
└── zoxide (smart directory jumping)

Server Layer (server profile)
└── Core only - no additional plugins
```

---

## Core Plugins (Universal - ALL Profiles)

These plugins are loaded for **every machine type** via `dotfiles/zsh/core/01-zinit.zsh`:

### 1. zsh-autosuggestions
**Repository**: https://github.com/zsh-users/zsh-autosuggestions

**What it does:**
- Shows ghost text suggestions from your command history as you type
- Displays in gray/dim color behind your cursor
- Press `→` (right arrow) to accept suggestion
- Press `Alt+F` to accept next word only

**Visual example:**
```bash
$ git comm█
$ git commit -m "fix bug"
        ^^^^^^^^^^^^^^^^^ (gray ghost text from history)
```

**Configuration** (`core/20-env.zsh`):
```zsh
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"  # Limit to short commands for performance
ZSH_AUTOSUGGEST_USE_ASYNC=1            # Async suggestions for better performance
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'  # Gray color for suggestions
```

**Performance**: <5ms startup impact with async mode

---

### 2. zsh-fast-syntax-highlighting
**Repository**: https://github.com/zdharma-continuum/zsh-fast-syntax-highlighting

**What it does:**
- Colors commands as you type based on validity
- Green = valid command exists
- Red = command not found or syntax error
- Shows other syntax elements (strings, options, etc.)
- **Optimized version** with better performance than original zsh-syntax-highlighting

**Visual example:**
```bash
$ git commti   ← (red - invalid command)
$ git commit   ← (green - valid command)
```

**Why fast-syntax-highlighting?**
- Feature-rich with additional highlighting modes
- Better performance than original
- More actively maintained

**Important**: MUST load LAST (loaded at end of `core/01-zinit.zsh`)

**Performance**: ~5-10ms startup impact

---

### 3. Arrow Key History Navigation
**What it does:**
- Smart history search based on what you've typed
- Type "git" then press UP to see only commands starting with "git"
- Native zsh feature (no plugin needed)

**Implementation** (`core/40-functions.zsh`):
```zsh
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search    # Up arrow
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search  # Down arrow
```

**Performance**: No impact (built-in zsh feature)

---

## Workstation-Only Enhancements

These features are added ONLY for `laptop`, `pro`, and `wsl` profiles via their respective `plugins.zsh` and `config.zsh` files:

### 1. fzf-tab
**Repository**: https://github.com/Aloxaf/fzf-tab

**What it does:**
- Replaces default tab completion menu with fzf fuzzy finder interface
- Works with ALL existing completions (commands, variables, directory stack)
- Interactive filtering of completion results
- Supports preview windows

**Visual example:**
```bash
$ git a<TAB>
> add
  am
  apply
  archive
  ───────────────────────────────
  > Preview window shows documentation
```

**When NOT to use:**
- Server profiles (keep minimal)
- Conflicts with zsh-autocomplete (choose one or the other)

**Performance**: ~20-30ms startup impact with turbo mode

---

### 2. fzf Enhanced Configuration

**What it does:**
- Improves default fzf keybindings (Ctrl+R, Ctrl+T, Alt+C)
- Adds preview windows with bat and eza
- Uses fd instead of find for better performance

**Configuration** (in each workstation `config.zsh`):

```zsh
# Ctrl+T: File finder with bat preview
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
"

# Alt+C: Directory navigator with eza tree preview
export FZF_ALT_C_OPTS="
  --preview 'eza --tree --color=always {} | head -200'
"
```

**Keybindings:**
- `Ctrl+R` - Fuzzy history search
- `Ctrl+T` - Fuzzy file search (inserts in command line)
- `Alt+C` - Fuzzy directory change
- `Ctrl+/` - Toggle preview window (custom binding)

**Performance**: No startup impact (fzf itself is extremely fast)

---

### 3. zoxide
**Repository**: https://github.com/ajeetdsouza/zoxide

**What it does:**
- Smart directory jumping based on frecency (frequency + recency)
- Learns which directories you visit most often
- Jump to directories with partial names
- Rust-based for maximum performance

**Usage:**
```bash
$ z proj          # Jump to most frequently used dir matching "proj"
$ z foo bar       # Jump to dir matching both "foo" and "bar"
$ zi proj         # Interactive selection with fzf
```

**Configuration** (in each workstation `config.zsh`):
```zsh
export _ZO_DATA_DIR="$HOME/.local/share/zoxide"
export _ZO_ECHO=1  # Print matched directory when jumping
eval "$(zoxide init zsh)"
```

**Aliases automatically created:**
- `z` - Jump to directory
- `zi` - Jump with interactive selection (uses fzf)

**Performance**: <5ms startup impact

---

## Server Profile (Minimal)

**Philosophy**: Keep servers lightweight, secure, and fast.

**What's included:**
- ✅ Core plugins (autosuggestions, syntax-highlighting)
- ✅ Arrow key history navigation
- ✅ Basic completion (from core)
- ❌ No fzf-tab (keep vanilla completion menu)
- ❌ No zoxide (not needed on servers)
- ❌ No enhanced fzf config

**Result**: <100ms startup time, minimal dependencies

---

## Modern CLI Tools Integration

These Rust-based tools are used throughout the configuration:

### Starship Prompt
**Repository**: https://starship.rs

- Fast, cross-shell prompt
- Configured via Ansible (`ansible-playbooks/roles/common-shell/templates/starship.toml.j2`)
- Machine-type aware (different characters and colors per profile)
- <10ms startup impact

### bat (Better cat)
**Repository**: https://github.com/sharkdp/bat

- Syntax highlighting for file previews
- Used in fzf previews
- Theme set by Catppuccin configuration

### eza (Better ls)
**Repository**: https://github.com/eza-community/eza

- Modern ls replacement with colors and icons
- Respects LS_COLORS from theme
- Used in fzf directory previews

### fd (Better find)
**Repository**: https://github.com/sharkdp/fd

- Fast, user-friendly alternative to find
- Respects .gitignore by default
- Used as FZF_DEFAULT_COMMAND

### ripgrep (Better grep)
**Repository**: https://github.com/BurntSushi/ripgrep

- Extremely fast grep alternative
- Respects .gitignore by default
- Used for code searching

---

## Plugin Loading Order (Critical!)

**Correct order** (as implemented in `core/01-zinit.zsh`):

1. **Zinit initialization**
2. **Core plugins:**
   - zsh-autosuggestions
   - **zsh-fast-syntax-highlighting (MUST BE LAST)**

**Why order matters:**
- Syntax highlighting wraps ZLE widgets
- If loaded first, it can interfere with other plugins
- ALWAYS load syntax highlighting as the final plugin

**Profile-specific plugins** (loaded after core):
- fzf-tab (workstations only)

---

## Performance Benchmarks

Target startup times by profile:

| Profile | Target | Actual | Plugins |
|---------|--------|--------|---------|
| Server | <100ms | ~80ms | Core only |
| Workstation | <250ms | ~180ms | Core + fzf-tab + zoxide |
| Pro (with kubectl) | <500ms | ~350ms | Workstation + tool completions |

**How to measure:**
```bash
time zsh -i -c exit
```

**How to profile:**
```bash
# Add to top of .zshrc:
zmodload zsh/zprof

# Add to bottom of .zshrc:
zprof
```

---

## Configuration File Layout

```
dotfiles/zsh/
├── core/                          # Universal - ALL profiles
│   ├── 01-zinit.zsh              # Plugin manager + core plugins
│   ├── 20-env.zsh                # Plugin configuration
│   ├── 30-aliases.zsh            # Universal aliases
│   └── 40-functions.zsh          # Arrow key navigation
│
└── profiles/
    ├── laptop/
    │   ├── plugins.zsh           # fzf-tab only
    │   └── config.zsh            # fzf config + zoxide
    ├── pro/
    │   ├── plugins.zsh           # fzf-tab only
    │   └── config.zsh            # fzf config + zoxide + kubectl
    ├── wsl/
    │   ├── plugins.zsh           # fzf-tab only
    │   └── config.zsh            # fzf config + zoxide + WSL interop
    └── server/
        └── plugins.zsh           # Empty (uses core only)
```

---

## Adding New Plugins

### For ALL profiles (core):
1. Add plugin to `dotfiles/zsh/core/01-zinit.zsh`
2. Add configuration to `dotfiles/zsh/core/20-env.zsh` if needed
3. Ensure it loads BEFORE `zsh-fast-syntax-highlighting`

### For workstations only:
1. Add plugin to each workstation `profiles/*/plugins.zsh`
2. Add configuration to each workstation `profiles/*/config.zsh`

### Testing checklist:
- [ ] Test in Docker containers (`make test-server`, `make test-wsl`)
- [ ] Check startup time (`time zsh -i -c exit`)
- [ ] Verify no "unhandled ZLE widget" errors
- [ ] Test tab completion for character duplication
- [ ] Commit to dotfiles repo and push

---

## Alternatives Considered

### Completion Systems

**fzf-tab** (chosen for workstations)
- ✅ Works with existing completions
- ✅ Familiar fzf interface
- ✅ Conservative and reliable
- ❌ Not as aggressive as IDE-like completion

**zsh-autocomplete** (not used)
- ✅ Real-time type-ahead like VSCode
- ✅ Asynchronous and feature-rich
- ❌ Different UX, steeper learning curve
- ❌ Conflicts with fzf-tab

### Syntax Highlighting

**zsh-fast-syntax-highlighting** (chosen)
- ✅ Optimized performance
- ✅ Feature-rich
- ✅ Actively maintained

**zsh-syntax-highlighting** (original, not used)
- ✅ Original, well-established
- ❌ Slower than fast version
- ❌ Fewer features

### Directory Jumping

**zoxide** (chosen)
- ✅ Rust-based, extremely fast
- ✅ Simple global frecency
- ✅ fzf integration

**autojump** (not used)
- ❌ Python-based, slower
- ❌ More complex

**z.lua** (not used)
- ✅ Context-aware
- ❌ More complex than needed

---

## Troubleshooting

### Character duplication in completion menu
**Cause**: Invalid UTF-8 locale during Starship initialization
**Fix**: Implemented in `core/20-env.zsh` with C.UTF-8 fallback

### "unhandled ZLE widget" errors
**Cause**: Plugin loading order or missing widgets
**Fix**: Ensure syntax-highlighting loads last, check keybindings happen after widgets are defined

### Slow shell startup
**Cause**: Heavy plugins or synchronous loading
**Fix**: Use `time zsh -i -c exit` and `zprof` to identify culprits. Consider lazy-loading heavy completions (kubectl, etc.)

### fzf-tab not working
**Cause**: Must load after compinit
**Fix**: Loaded in profile plugins.zsh which sources after .zshrc compinit

---

## Resources

- **Zinit**: https://github.com/zdharma-continuum/zinit
- **fzf**: https://github.com/junegunn/fzf
- **Starship**: https://starship.rs
- **Modern Unix Tools**: https://github.com/ibraheemdev/modern-unix
- **2025 Best Practices**: Based on Reddit r/zsh, GitHub trending, and community consensus

---

## Version History

- **2025-11**: Modern shell 2025 architecture - Core/workstation split, fzf-tab, zoxide
- **2024**: Vanilla baseline testing - Removed all plugins for debugging
- **2023**: Initial Oh-My-Zsh based configuration
