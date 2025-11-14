# Zsh Plugins Reference

This document lists plugins that have been removed during the vanilla completion simplification, and provides guidance for when to re-add them.

## Current Status: Vanilla + Enhanced Styles

**Active completion features:**
- ✅ Native zsh completion (compinit)
- ✅ Arrow key menu navigation (`zstyle menu select`)
- ✅ Case-insensitive matching
- ✅ Colorized completions
- ✅ Grouped completions with headers
- ✅ fzf (Ctrl+R history, Ctrl+T files, Alt+C directories)

**Removed plugins:** 3 plugins disabled for testing baseline

---

## Removed Plugins

### 1. zsh-autosuggestions
**Repository:** https://github.com/zsh-users/zsh-autosuggestions

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

**Does it affect tab completion?** NO - This is separate from completion

**When to re-add:**
- If you want command suggestions while typing
- If you frequently repeat similar commands
- Quality-of-life improvement for productivity

**Configuration removed from `profiles/laptop/config.zsh`:**
```zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
```

**How to re-enable:**
1. Uncomment in `profiles/laptop/plugins.zsh` (line 22)
2. Uncomment config in `profiles/laptop/config.zsh` (lines 6-7)
3. Restart shell

---

### 2. zsh-syntax-highlighting
**Repository:** https://github.com/zsh-users/zsh-syntax-highlighting

**What it does:**
- Colors commands as you type based on validity
- Green = valid command exists
- Red = command not found or syntax error
- Shows other syntax elements (strings, options, etc.)

**Visual example:**
```bash
$ git commti   ← (red - invalid command)
$ git commit   ← (green - valid command)
```

**Does it affect tab completion?** YES - Can interfere with completion widgets

**Known issues:**
- Must be loaded LAST (after all other plugins)
- Can wrap widgets causing "unhandled ZLE widget" errors
- May interfere with prompt redraw

**When to re-add:**
- If you want real-time command validation
- Helpful for learning command syntax
- Nice visual feedback

**Configuration removed from `profiles/laptop/config.zsh`:**
```zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
```

**How to re-enable:**
1. Uncomment in `profiles/laptop/plugins.zsh` (lines 25-26)
2. Uncomment config in `profiles/laptop/config.zsh` (line 10)
3. **IMPORTANT:** Ensure it loads AFTER all other plugins
4. Restart shell

**Loading order requirement:**
```zsh
# Other plugins first
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search

# syntax-highlighting MUST be last
zinit light zsh-users/zsh-syntax-highlighting
```

---

### 3. zsh-history-substring-search
**Repository:** https://github.com/zsh-users/zsh-history-substring-search

**What it does:**
- Enhanced history search with up/down arrows
- Filters history by substring you've already typed
- Better than default history search

**Visual example:**
```bash
$ git commit<UP>
# Shows only previous "git commit..." commands
# Not all commands starting with "git"
```

**Does it affect tab completion?** NO - This is history search, not completion

**Known issues:**
- Creates ZLE widgets that must exist before binding keys
- Keybindings must be set AFTER plugin loads
- Previously caused "unhandled ZLE widget" error

**When to re-add:**
- If you search command history frequently
- Alternative: Use fzf's Ctrl+R (already enabled)
- Consider if you really need both

**Keybindings removed from `profiles/laptop/config.zsh`:**
```zsh
bindkey '^[[A' history-substring-search-up    # Up arrow
bindkey '^[[B' history-substring-search-down  # Down arrow
bindkey -M vicmd 'k' history-substring-search-up    # vi mode
bindkey -M vicmd 'j' history-substring-search-down  # vi mode
```

**How to re-enable:**
1. Uncomment plugin in `profiles/laptop/plugins.zsh` (lines 29-30)
2. Add keybindings AFTER plugin load (at end of plugins.zsh):
   ```zsh
   zinit light zsh-users/zsh-history-substring-search

   # Keybindings AFTER plugin loads
   bindkey '^[[A' history-substring-search-up
   bindkey '^[[B' history-substring-search-down
   ```
3. Restart shell

---

## Plugins Still Active

### fzf (Fuzzy Finder)
**Repository:** https://github.com/junegunn/fzf

**What it does:**
- Fuzzy finding for files, history, and more
- Interactive search with preview

**Keybindings:**
- `Ctrl+R` - Fuzzy history search
- `Ctrl+T` - Fuzzy file search (inserts in command line)
- `Alt+C` - Fuzzy directory change

**Status:** ✅ ACTIVE (not a zsh plugin, loaded in `.zshrc` lines 112-133)

**Why keep it:** Essential productivity tool, doesn't interfere with completion

---

## Alternative Plugins to Consider

### zsh-completions (Additional completion definitions)
**Repository:** https://github.com/zsh-users/zsh-completions

**What it adds:**
- More completion definitions for commands not included in zsh
- Completions for: docker, docker-compose, npm, yarn, etc.

**When to add:** If you're missing completions for specific tools

**How to add:**
```zsh
# In profiles/laptop/plugins.zsh, add BEFORE compinit
zinit light zsh-users/zsh-completions
```

### zsh-autocomplete (Alternative to default completion)
**Repository:** https://github.com/marlonrichert/zsh-autocomplete

**What it does:**
- Real-time completion as you type (like IDEs)
- Shows menu automatically without pressing tab
- More aggressive than standard completion

**When to add:** If you want IDE-style autocomplete

**Warning:** Can conflict with other completion setups

---

## Plugin Loading Best Practices

### General Order:
1. OMZ library components (git.zsh, history.zsh, etc.)
2. OMZ plugins (git, docker, etc.)
3. Completion plugins (zsh-completions) - before compinit
4. **compinit initialization** (in .zshrc)
5. Utility plugins (zsh-autosuggestions)
6. History plugins (zsh-history-substring-search)
7. **Keybindings** (after widgets are defined)
8. Syntax highlighting LAST (zsh-syntax-highlighting)

### Turbo Mode (`wait lucid`):
- Delays plugin loading until after prompt
- Faster shell startup
- Can cause race conditions with keybindings
- **Recommendation:** Don't use for plugins that define widgets you bind

### Widget-Based Plugins:
If a plugin defines ZLE widgets (like history-substring-search):
1. Load the plugin first
2. THEN bind keys to the widgets
3. Don't use `wait` unless you use `atload` for keybindings

---

## Comparison: Plugin Setup Philosophies

### Minimal (Current)
**Plugins:** None (vanilla completion only)
**Pros:** Fast, no conflicts, simple
**Cons:** No visual aids, no suggestions
**Best for:** Debugging, learning, servers

### Basic Enhanced (Recommended starting point)
**Plugins:** fzf only
**Pros:** Fuzzy search, still simple
**Cons:** No real-time suggestions
**Best for:** Most users, good balance

### Quality of Life
**Plugins:** fzf + zsh-autosuggestions
**Pros:** Suggestions from history, still fast
**Cons:** Occasional ghost text in wrong places
**Best for:** Personal laptops, productivity

### Full Featured
**Plugins:** fzf + autosuggestions + syntax-highlighting + history-search
**Pros:** Maximum visual feedback and convenience
**Cons:** Possible conflicts, slower startup
**Best for:** Work laptops, heavy CLI users

### Power User
**Plugins:** Full featured + zsh-completions + custom completions
**Pros:** Completion for everything, all features
**Cons:** Complex setup, potential issues
**Best for:** Advanced users who understand debugging

---

## Testing Strategy

When re-adding plugins:

1. **Add ONE plugin at a time**
2. **Test thoroughly** before adding the next
3. **Check for:**
   - Character duplication in completion menu
   - "unhandled ZLE widget" errors
   - Prompt rendering issues
   - Slow shell startup (`time zsh -i -c exit`)

4. **Test commands:**
   ```bash
   # Test completion menu
   git a<TAB>           # Should show clean menu, no duplication
   cd ~/<TAB>           # Test directory completion

   # Test plugin features
   git comm<RIGHT>      # Test autosuggestions (if enabled)
   git commti           # Should be red (if syntax-highlighting enabled)
   git commit<UP>       # Test history search (if enabled)
   ```

5. **If issues appear:**
   - Remove the last plugin added
   - Check loading order
   - Verify keybindings are after widget creation
   - Check for conflicting configurations

---

## Decision Matrix

Use this to decide which plugins to re-add:

| Feature | Plugin | Impact | Recommended? |
|---------|--------|--------|--------------|
| Fuzzy search | fzf | None | ✅ YES (essential) |
| Command suggestions | zsh-autosuggestions | Low | ⚠️ Try it |
| Visual validation | zsh-syntax-highlighting | Medium | ⚠️ Optional |
| History search | zsh-history-substring-search | Low | ❌ NO (use fzf Ctrl+R) |
| More completions | zsh-completions | None | ✅ YES (if needed) |
| IDE-style complete | zsh-autocomplete | High | ❌ NO (too aggressive) |

---

## Current Configuration Summary

**Completion system:** Vanilla zsh with enhanced styles
**Active plugins:** fzf only
**Removed plugins:** 3 (autosuggestions, syntax-highlighting, history-substring-search)
**Status:** Clean baseline for testing

**Next steps:**
1. Test current setup thoroughly
2. Verify character duplication is fixed
3. Add plugins back one at a time if desired
4. Document any issues encountered
