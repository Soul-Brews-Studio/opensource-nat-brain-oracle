# Check Install Method Before Updating

> **Source**: Session 2025-12-14 00:11 (Codex update failed)
> **Problem**: `npm install -g` failed because package was installed via `bun`

---

## The Pattern

**Always check HOW something was installed before trying to update it.**

```bash
# Step 1: Find the binary
which codex
# /Users/nat/.bun/bin/codex

# Step 2: Check what it points to
ls -la $(which codex)
# lrwxrwxrwx ... codex -> ../install/global/node_modules/@openai/codex/bin/codex.js
#                         ^^^^^^^ bun's install path!

# Step 3: Update with correct tool
bun install -g @openai/codex@latest   # Not npm!
```

---

## Quick Reference

| Path Contains | Installed Via | Update With |
|---------------|---------------|-------------|
| `.bun/bin/` | bun | `bun install -g pkg@version` |
| `.npm/bin/` | npm | `npm install -g pkg@version` |
| `.local/bin/` | pip/pipx | `pip install --upgrade pkg` |
| `/opt/homebrew/` | brew | `brew upgrade pkg` |
| `.cargo/bin/` | cargo | `cargo install pkg` |

---

## The Mistake

```bash
# Codex prompt said:
# › 1. Update now (runs `npm install -g @openai/codex`)

# But codex was installed with bun!
# npm install -g failed silently / didn't find package

# Correct fix:
bun remove -g @openai/codex
bun install -g @openai/codex@0.72.0
```

---

## One-Liner Check

```bash
# Check install method for any command
check-install() { which "$1" && ls -la "$(which "$1")" 2>/dev/null; }
check-install codex
check-install claude
```

---

*Pattern discovered when Codex update prompt suggested wrong package manager*
