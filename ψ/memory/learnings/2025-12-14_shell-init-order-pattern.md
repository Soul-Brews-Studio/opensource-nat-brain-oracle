# Shell Initialization Order Pattern

> **Source**: Session 2025-12-14 00:11 (MAW auto-start polish)
> **Problem**: Environment variables not taking effect

---

## The Pattern

```
Shell Init Order (zsh):
~/.zshenv     → runs first (all shells)
~/.zshrc      → runs second (interactive shells)
direnv hook   → runs after zshrc
.envrc        → runs when entering directory
```

---

## The Lesson

**Variables must be set BEFORE their consumers load.**

| Variable | Wrong Place | Right Place | Why |
|----------|-------------|-------------|-----|
| `DIRENV_LOG_FORMAT` | `.envrc` | `~/.zshrc` | Direnv reads it before loading .envrc |
| `POWERLEVEL9K_INSTANT_PROMPT` | After p10k block | Before p10k block | P10k caches on first load |

---

## Quick Fix Template

```bash
# ~/.zshrc - TOP of file (before anything else)
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off  # Before p10k instant prompt
export DIRENV_LOG_FORMAT=""                  # Before direnv hook

# ... rest of zshrc ...
```

---

## Debug Command

```bash
# Check what's set when
zsh -xc 'exit' 2>&1 | grep -E "DIRENV|POWERLEVEL"
```

---

## Related Patterns

- **P10k `quiet` vs `off`**: Use `off` if direnv is present (quiet still warns)
- **Check install method**: `which cmd && ls -la $(which cmd)` before updating
- **bun vs npm**: Check symlink to know which package manager installed it

---

*Pattern discovered fixing MAW startup noise*
