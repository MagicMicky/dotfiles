# Starship Prompt Configuration Reference

This document describes the Starship prompt design, what was removed during vanilla simplification, and options for rebuilding a custom prompt.

## Current Status: Vanilla Starship (Absolute Minimal)

**Active prompt features:**
- ✅ Default Starship config (no customization)
- ✅ Basic directory display
- ✅ Git integration (branch, status)
- ✅ Default prompt character (❯)

**Removed features:** All custom formatting, colors, machine-type differentiation, Unicode characters, language indicators

---

## Problem Being Solved

**Issue:** Character duplication when completion menu appears (`gi<tab>` → `gigit`)

**Root cause identified:**
- ❌ NOT zsh completion plugins (removed all plugins, bug persists)
- ❌ NOT completion configuration (setopt commands correct)
- ❌ NOT completion styles (tried various zstyles)
- ✅ **IS Starship prompt rendering** (confirmed: empty `PS1='$ '` fixes it)

**Hypothesis:** Complex Starship formatting with ANSI escape codes, Unicode characters, or custom formats causes zsh to miscalculate prompt length, resulting in character insertion at wrong offset when completion menu renders.

**Testing approach:** Strip down to absolute vanilla Starship, then rebuild incrementally to identify which specific elements cause the rendering bug.

---

## Original Design Goals (Before Simplification)

### Machine Type Differentiation

**Goal:** Instantly recognize which machine you're on by prompt appearance

**Method:** Character-based visual system + color coding

| Machine Type | Character | Color | Example |
|--------------|-----------|-------|---------|
| Personal Laptop | λ (lambda) | Blue `#82AAFF` | `[λ] ~/project ❯` |
| Work Laptop (Pro) | λ (lambda) | Teal `#7FDBCA` | `[λ] ~/work ❯` |
| WSL | λ (lambda) | Blue `#82AAFF` | `hostname [λ] ~/proj ❯` |
| Production Server | ! (exclamation) | Red `#FF5370` | `prod [!] /opt/app ❯` |
| Dev Server | · (middle dot) | Orange `#FFB86C` | `dev [·] /opt/app ❯` |
| Gaming Server | · (middle dot) | Purple `#C792EA` | `gaming [·] ~/games ❯` |
| Homelab | · (middle dot) | Sky Blue `#89DDFF` | `nas [·] /mnt/data ❯` |

**Rationale:**
- Shape (λ vs ! vs ·) = Primary differentiation (laptop vs critical vs other)
- Color = Secondary differentiation (specific machine type)
- Two-level hierarchy prevents need to remember 7 different symbols

### Format Structure

**Original custom format:**
```
[username@]hostname [λ] ~/directory  on  branch [?!+] via  py3.11  via  node18
took 2s
❯
```

**Elements:**
1. **Username** (only root or SSH) - Security awareness
2. **Hostname** (servers/WSL only) - Machine identification
3. **[Character]** - Machine type indicator
4. **Directory** - Current path (truncated, with repo awareness)
5. **Git** - Branch and status symbols
6. **Language versions** - Python, Node, Go, Rust, etc. (context-aware)
7. **Docker context** - If in Docker project
8. **Package version** - From package.json, Cargo.toml, etc.
9. **Command duration** - If >500ms
10. **Line break** - Separate info from input
11. **Prompt character** - Green ❯ (success) or Red ❯ (error)

---

## Removed Features (for Vanilla Testing)

### 1. Machine Type Character System
**What was removed:**
```toml
{% if machine_profile in ['server', 'wsl'] %}$hostname\
{% endif %}[{{ starship_char }}](bold {{ starship_color }}) \
```

**Original behavior:**
- Personal/Pro: `[λ]` in blue/teal
- Servers: `hostname [!]` or `hostname [·]` in red/orange/purple
- WSL: `hostname [λ]` in blue

**Why removed:** Custom Unicode characters and color escaping might cause prompt length miscalculation

**Vanilla equivalent:** Just shows default `❯` character

---

### 2. Custom Colors & Styling
**What was removed:**
- All `style = "bold {{ starship_color }}"` configurations
- Custom color hex codes for machine types
- Bold formatting throughout

**Why removed:** ANSI escape codes for colors are prime suspects for prompt length bugs

**Vanilla equivalent:** Starship's default colors

---

### 3. Directory Icon Substitutions
**What was removed:**
```toml
[directory.substitutions]
"Documents" = " "
"Downloads" = " "
"Music" = " "
"Pictures" = " "
"Development" = " "
```

**Why removed:** Unicode icons can cause width calculation issues

**Vanilla equivalent:** Plain text directory names

---

### 4. Git Symbols & Formatting
**What was removed:**
```toml
[git_branch]
symbol = " "  # Git branch icon

[git_status]
format = "([ \\[$all_status$ahead_behind\\]]($style))"
ahead = "⇡${count}"
behind = "⇣${count}"
diverged = "⇕⇡${ahead_count}⇣${behind_count}"
untracked = "?"
stashed = "$"
modified = "!"
staged = "+"
renamed = "»"
deleted = "✘"
conflicted = "="
```

**Why removed:** Complex formatting with brackets and Unicode arrows

**Vanilla equivalent:** Starship's default git indicators (simpler)

---

### 5. Language Indicators with Icons
**What was removed:**
- Python:  " " (snake icon)
- Node.js:  " " (node icon)
- Golang:  " " (go icon)
- Rust:  " " (rust icon)
- Docker:  " " (docker icon)
- Package:  " " (package icon)

**Why removed:** Nerd Font icons are complex multi-byte Unicode

**Vanilla equivalent:** Simpler text-based indicators

---

### 6. Kubernetes & Cloud Indicators
**What was removed:**
```toml
[kubernetes]
symbol = "☸ "  # Kubernetes icon

[aws]
symbol = "☁️ "  # Cloud emoji

[terraform]
symbol = "💠 "  # Diamond emoji
```

**Why removed:** Emojis and special Unicode symbols

**Vanilla equivalent:** None (disabled by default in Starship)

---

### 7. Custom Prompt Characters
**What was removed:**
```toml
[character]
success_symbol = " [❯](bold green)"
error_symbol = " [❯](bold red)"
vimcmd_symbol = " [❮](bold green)"
```

**Why removed:** Custom spacing and bold formatting

**Vanilla equivalent:** Starship's default `❯` character

---

### 8. Complex Format String
**What was removed:**
```toml
format = """
$username\
{% if machine_profile in ['server', 'wsl'] %}$hostname\
{% endif %}[{{ starship_char }}](bold {{ starship_color }}) \
$directory\
$git_branch\
$git_status\
$python\
$nodejs\
$golang\
$rust\
$docker_context\
$package\
$cmd_duration\
$line_break\
$character
"""
```

**Why removed:** Custom ordering, conditional logic, Jinja2 templating

**Vanilla equivalent:** Starship's default format order

---

## Vanilla Starship Config (Current)

**Filename:** `starship.toml.j2` (simplified)

```toml
# Absolute Vanilla Starship Configuration
# No customization - using Starship defaults for debugging

# Empty file = use all Starship defaults
```

**What this gives you:**
- Default prompt character: `❯`
- Directory display: full path (no truncation)
- Git branch: ` on branch-name`
- Git status: basic symbols (*, +, !, etc.)
- Language versions: only shown in relevant projects
- No Unicode icons, no custom colors, no machine differentiation

---

## Starship Feature Categories

### Core Elements (Always Visible)
1. **Directory** - Where you are
2. **Prompt Character** - Input marker (❯)

### Contextual Elements (Show When Relevant)
3. **Git** - Branch and status (only in git repos)
4. **Language Versions** - Python, Node, etc. (only in relevant projects)
5. **Docker** - Context (only when Docker files present)
6. **Package** - Version from package.json, Cargo.toml (only when present)

### Optional Elements (Configurable)
7. **Username** - Can show always, only for root, only for SSH
8. **Hostname** - Can show always, only for SSH, never
9. **Command Duration** - Show if command took >X time
10. **Time** - Current time (disabled by default)
11. **Battery** - Battery status (useful for laptops)
12. **Jobs** - Background job count
13. **Status** - Exit status of last command
14. **Memory** - Memory usage (disabled by default)

### Advanced Elements
15. **Kubernetes** - Current context
16. **AWS** - Current profile/region
17. **Terraform** - Current workspace
18. **Environment Variables** - Custom env vars
19. **Custom Commands** - Output from custom scripts

---

## Incremental Rebuild Strategy

After confirming vanilla Starship works without character duplication:

### Phase 1: Essential Information Only (No Unicode)
**Add back (plain text only):**
```toml
format = """
$directory\
$git_branch\
$git_status\
$line_break\
$character
"""

[directory]
truncation_length = 3
truncate_to_repo = true

[character]
success_symbol = "[>](bold green)"
error_symbol = "[>](bold red)"
```

**Test:** Does `gi<tab>` still work?

---

### Phase 2: Add Basic Colors (No Unicode)
**Add back:**
```toml
[directory]
style = "bold blue"

[git_branch]
style = "bold purple"
```

**Test:** Does color cause duplication?

---

### Phase 3: Add Simple Hostname (Servers Only)
**Add back:**
```toml
format = """
$hostname\
$directory\
$git_branch\
$git_status\
$line_break\
$character
"""

[hostname]
ssh_only = false
format = "[$hostname](bold blue) "
disabled = false
```

**Test:** Does hostname display cause issues?

---

### Phase 4: Add Machine Type Indicator (Text Only)
**Add back (without Unicode):**
```toml
# Instead of [λ], use [LAP], [SRV], [PRD]
format = """
$hostname\
[{{ machine_type_text }}](bold {{ starship_color }}) \
$directory\
...
"""
```

**Test:** Does machine type text work?

---

### Phase 5: Add Simple Unicode Character
**Try adding back (one at a time):**
- First try: Simple ASCII arrow `>`
- Then try: Single Unicode `❯`
- Then try: Lambda `λ`
- Then try: With brackets `[λ]`

**Test after each:** Identify which specific character/format breaks it

---

### Phase 6: Add Language Indicators (No Icons)
**Add back (text only):**
```toml
[python]
format = " via [py$version](bold yellow)"
symbol = ""  # No icon

[nodejs]
format = " via [node$version](bold green)"
symbol = ""  # No icon
```

**Test:** Does language detection work?

---

### Phase 7: Add Nerd Font Icons (If Needed)
**Only if all above work, try adding:**
```toml
[git_branch]
symbol = " "  # Git branch icon

[python]
symbol = " "  # Python icon
```

**Test:** Do Nerd Font icons cause issues?

---

## Alternative Prompts to Consider

If Starship continues to have rendering issues:

### 1. Pure Zsh Prompt (No External Tools)
**Pros:** Maximum control, no dependencies, guaranteed compatibility
**Cons:** More complex to configure, less features out of the box

**Example:**
```zsh
PROMPT='%F{blue}%~%f %F{green}❯%f '
RPROMPT='%F{yellow}$(git_branch)%f'
```

### 2. Powerlevel10k
**Pros:** Very fast, highly customizable, good zsh integration
**Cons:** Complex setup, heavy configuration

### 3. Pure Prompt
**Pros:** Minimalist, fast, pure zsh
**Cons:** Fewer features than Starship

### 4. Spaceship Prompt
**Pros:** Similar to Starship, zsh-native
**Cons:** May have similar rendering issues

---

## Known Starship + Zsh Issues

### Issue Type: Prompt Length Calculation
**Symptoms:** Character duplication, cursor positioning errors, menu rendering bugs
**Cause:** Zsh doesn't correctly count invisible characters (ANSI escapes) in prompt
**Affected by:**
- Unicode characters with combining marks
- Nerd Font icons (multi-byte characters)
- Complex ANSI escape sequences
- Right-side prompts (RPROMPT) interfering with left

**Workarounds tried:**
1. ✅ Initialize compinit after Starship (already done)
2. ✅ Disable ALWAYS_TO_END (already done)
3. ✅ Disable COMPLETE_IN_WORD (already done)
4. ✅ Add precmd hook (didn't work)
5. ✅ Enable PROMPT_SP and PROMPT_SUBST (didn't work)
6. ✅ Disable list-prompt and select-prompt (didn't work)
7. ✅ Simplify Starship format (removed brackets - didn't work)
8. 🔄 **Current: Try absolute vanilla** (testing now)

---

## Testing Checklist

When testing any Starship configuration:

```bash
# 1. Apply new config
ansible-playbook playbooks/wsl/setup.yml -i tests/inventories/wsl.yml

# 2. Start fresh shell
exec zsh

# 3. Test basic completion
gi<tab>
# Expected: Shows "git" in menu, NOT "gigit"

# 4. Test menu with multiple options
git a<tab>
# Expected: Shows menu with add/apply/am/etc, clean display

# 5. Test arrow key navigation
git a<tab><down><down>
# Expected: Highlights move cleanly

# 6. Test completion in various contexts
cd ~/<tab>        # Directory completion
ls --<tab>        # Option completion
docker <tab>      # Subcommand completion

# 7. Check prompt rendering
# - No overlapping text
# - Correct colors
# - No garbled characters
# - Cursor in right position

# 8. Test multiline prompts
# Type long command that wraps

# 9. Test with git repo
cd /path/to/git/repo
# Check git status displays correctly

# 10. Measure startup time
time zsh -i -c exit
# Should be <100ms for laptop
```

---

## Decision Matrix

| Feature | Priority | Risks Rendering Bug? | Keep in Vanilla? |
|---------|----------|---------------------|------------------|
| Directory display | Essential | Low | ✅ YES |
| Prompt character | Essential | Low | ✅ YES |
| Git branch | High | Low | ✅ YES (default) |
| Git status | High | Medium (symbols) | ⚠️ Test |
| Colors | Medium | Medium (ANSI codes) | ⚠️ Add after vanilla works |
| Machine type indicator | High | **HIGH** (Unicode + format) | ❌ NO - Add Phase 4+ |
| Hostname | Medium | Low | ⚠️ Add Phase 3 |
| Language versions | Low | Medium (icons) | ❌ NO - Add Phase 6+ |
| Nerd Font icons | Low | **HIGH** (multi-byte) | ❌ NO - Add Phase 7+ |
| Custom format | Medium | High (complexity) | ❌ NO - Add incrementally |
| Command duration | Low | Low | ⚠️ Optional |

---

## Success Criteria

**Minimum viable prompt (must work):**
- Shows current directory
- Shows git branch (in git repos)
- Shows prompt character
- **NO character duplication on tab completion**

**Nice to have (rebuild incrementally):**
- Machine type differentiation (text or simple character)
- Colors for visual organization
- Hostname on servers/WSL
- Git status indicators
- Language version detection

**Can live without (if breaks rendering):**
- Nerd Font icons
- Complex Unicode characters
- Custom format strings
- Multiple colors

---

## Next Steps

1. **Test vanilla Starship** - Confirm absolute default works
2. **If vanilla works** - Add features back one at a time following rebuild phases
3. **If vanilla STILL breaks** - Consider alternative prompts or report Starship bug
4. **Document findings** - Update this file with what specifically causes the bug

---

## Resources

- **Starship docs**: https://starship.rs/config/
- **Starship default config**: https://starship.rs/presets/
- **Nerd Fonts**: https://www.nerdfonts.com/
- **Zsh prompt expansion**: http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
- **ANSI escape codes**: https://en.wikipedia.org/wiki/ANSI_escape_code
