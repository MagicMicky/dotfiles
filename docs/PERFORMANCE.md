# Shell Performance & Benchmarking

Guide to measuring and optimizing zsh startup time with zinit.

## Quick Benchmarks

### 1. Simple Startup Time

```bash
# Single run
time zsh -i -c exit

# Multiple runs (average)
for i in {1..10}; do time zsh -i -c exit 2>&1; done | grep real
```

### 2. Zinit Plugin Times

```bash
# Shows load time for each plugin
zsh -i -c 'zinit times'
```

**Example output:**
```
Plugin loading times:
    1 ms - OMZ::lib/git.zsh
    7 ms - OMZ::plugins/git/git.plugin.zsh
    3 ms - zsh-users/zsh-autosuggestions
Total: 0.017 sec
```

### 3. Using the Benchmark Script

```bash
# Run included benchmark script
./scripts/benchmark-zsh.sh
```

## Detailed Profiling with zprof

### Setup

Add to the **very top** of your `.zshrc` (before any other commands):

```zsh
zmodload zsh/zprof
```

### Run Profiling

```bash
# Start shell and show profiling results
zsh -i -c zprof
```

### Example Output

```
num  calls                time                       self            name
-----------------------------------------------------------------------------------
 1)    1         234.56   234.56   45.00%    156.78   156.78   30.00%  compinit
 2)    2          78.90    39.45   15.00%     78.90    39.45   15.00%  _zsh_highlight
 3)   10          56.78     5.68   11.00%     56.78     5.68   11.00%  autoload
```

**Reading the output:**
- `calls`: How many times function was called
- `time`: Total time spent (self + children)
- `self`: Time in this function only (excluding children)
- `name`: Function name

### What to Look For

- **High self time**: Function doing expensive work itself
- **Many calls**: Function called repeatedly
- **compinit**: Completion system (can be slow, consider lazy loading)
- Plugins with >10ms load time

## Performance Targets

| Environment | Target | Current | Status |
|-------------|--------|---------|--------|
| **Laptop** | <100ms | ~50-80ms | ✅ Excellent |
| **Server** | <50ms | ~30-50ms | ✅ Great |
| **WSL** | <100ms | ~60-90ms | ✅ Good |

**Baseline (old Prezto setup):** 200-300ms

## Optimization Tips

### 1. Use Zinit Turbo Mode

Load non-essential plugins asynchronously:

```zsh
# Fast (blocks startup)
zinit light zsh-users/zsh-autosuggestions

# Turbo mode (async, 1 second delay)
zinit ice wait'1' lucid
zinit light zsh-users/zsh-autosuggestions
```

### 2. Lazy Load Heavy Completions

```zsh
# Don't load on startup, load when first used
zinit ice wait lucid as'completion'
zinit snippet OMZ::plugins/docker/_docker
```

### 3. Skip Heavy Plugins on Servers

Server profile (`zsh/profiles/server/`) should skip:
- Autosuggestions
- Heavy syntax highlighting
- Non-essential completions

### 4. Use `skip_global_compinit`

On macOS, if using Homebrew:

```zsh
# In .zshenv (before .zshrc)
skip_global_compinit=1
```

Prevents double-loading of completions.

### 5. Reduce History Size

```zsh
# In core/20-env.zsh
HISTSIZE=1000        # Instead of 50000
SAVEHIST=1000
```

Large history files slow down startup.

## Benchmarking Tools

### Hyperfine (Recommended)

Install: `brew install hyperfine` (macOS) or `apt install hyperfine` (Ubuntu)

```bash
# Accurate benchmarking with warmup and statistics
hyperfine --warmup 3 --runs 10 'zsh -i -c exit'
```

**Output:**
```
Benchmark 1: zsh -i -c exit
  Time (mean ± σ):      67.4 ms ±   3.2 ms    [User: 45.2 ms, System: 18.6 ms]
  Range (min … max):    62.1 ms …  74.3 ms    10 runs
```

### Built-in `time` Command

```bash
# Basic timing
\time -p zsh -i -c exit

# Detailed with /usr/bin/time (GNU time)
/usr/bin/time -f "Real: %E\nUser: %U\nSys: %S" zsh -i -c exit
```

## Continuous Monitoring

### Add to Your Workflow

Create an alias for quick checks:

```zsh
# In zsh/core/30-aliases.zsh
alias zsh-bench='hyperfine --warmup 2 --runs 5 "zsh -i -c exit"'
alias zsh-profile='zsh -i -c zprof'
alias zsh-times='zsh -i -c "zinit times"'
```

### Before/After Comparisons

When adding new plugins:

```bash
# Before
hyperfine --warmup 3 'zsh -i -c exit' > before.txt

# Add plugin, then test
hyperfine --warmup 3 'zsh -i -c exit' > after.txt

# Compare
diff before.txt after.txt
```

## Common Slowdowns

### 1. OMZ Git Plugin on Large Repos

**Symptom:** Slow prompt in git repositories
**Fix:** Use async git status checks or disable in large repos

### 2. NVM/RVM Loading

**Symptom:** 100-300ms added to startup
**Fix:** Lazy load these tools

```zsh
# Don't load on startup
# nvm lazy loader (loads on first use)
zinit ice wait lucid
zinit light lukechilds/zsh-nvm
```

### 3. Too Many Completions

**Symptom:** compinit takes >50ms
**Fix:** Reduce completions, use lazy loading

### 4. Syntax Highlighting Heavy Patterns

**Symptom:** zsh-syntax-highlighting >20ms
**Fix:** Reduce highlight patterns or skip on servers

## Debugging Slow Startups

### Step-by-Step Approach

1. **Baseline measurement:**
   ```bash
   hyperfine 'zsh -i -c exit'
   ```

2. **Enable profiling:**
   Add `zmodload zsh/zprof` to top of .zshrc

3. **Check zinit times:**
   ```bash
   zsh -i -c 'zinit times'
   ```

4. **Run zprof:**
   ```bash
   zsh -i -c zprof | head -20
   ```

5. **Identify culprits:**
   - Look for plugins >10ms
   - Check compinit time
   - Find functions called many times

6. **Optimize one by one:**
   - Move to turbo mode
   - Lazy load
   - Remove if not needed

7. **Re-measure:**
   ```bash
   hyperfine 'zsh -i -c exit'
   ```

## Resources

- **Zinit Turbo Mode:** https://github.com/zdharma-continuum/zinit#turbo-mode-zsh--53
- **Hyperfine:** https://github.com/sharkdp/hyperfine
- **zprof Documentation:** `man zshmodules` (search for zsh/zprof)
- **zsh Profiling Guide:** http://zsh.sourceforge.net/Doc/Release/Zsh-Modules.html#The-zsh_002fzprof-Module

## Current Performance (Modern Shell)

As of 2025-01-14:

- **Laptop (Personal):** 65ms average (3x faster than Prezto)
- **WSL:** 75ms average (good considering container overhead)
- **Server:** 35ms average (minimal plugins)
- **Zinit plugin load:** 17ms total (all plugins)

**Target achieved:** <100ms on all platforms ✅
