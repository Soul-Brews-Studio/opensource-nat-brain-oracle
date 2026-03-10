# ghq Symlink Pattern

**Date**: 2025-12-21
**Context**: Fixed broken learn projects, simplified project-manager skill

## Golden Rule

> **ghq owns the clone → ψ/ owns the symlink**

Never copy. Always symlink. One source of truth.

## Pattern

```bash
# Acquire
ghq get -u https://github.com/owner/repo

# Link (flat, not nested!)
ln -sf "$(ghq root)/github.com/owner/repo" ψ/learn/repo-name
```

## Anti-Patterns

| ❌ Wrong | ✅ Right |
|----------|----------|
| `git clone` to ψ/ | `ghq get` then symlink |
| Copy files | Symlink always |
| Nested: `ψ/learn/repo/github.com/...` | Flat: `ψ/learn/name` |
| Partial copy (no .git) | Symlink to ghq |

## Why This Matters

- **Single source**: ghq manages all clones
- **Easy update**: `ghq get -u URL`
- **No broken refs**: Symlinks always point to valid repos
- **Flat structure**: Easy to browse, no deep nesting

## Health Check

```bash
# Find broken symlinks
find ψ/learn ψ/incubate -type l ! -exec test -e {} \; -print

# Fix broken: re-clone via ghq
ghq get -u [url]
```

## Quote

> "Let ghq own the source; let symlinks own the identity."
