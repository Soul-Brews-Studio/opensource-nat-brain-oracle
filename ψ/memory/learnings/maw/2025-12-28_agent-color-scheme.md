# Agent Color Scheme

**Date**: 2025-12-28

## The Colors

| Agent | Color | ANSI |
|-------|-------|------|
| 1 | Yellow | `\033[0;33m` |
| 2 | Magenta | `\033[0;35m` |
| 3 | Green | `\033[0;32m` |
| 4 | Cyan | `\033[0;36m` |
| 5 | Red | `\033[0;31m` |
| Main | Blue | `\033[0;34m` |

## Where Colors Apply

1. **SessionStart hook** (`.claude/scripts/agent-identity.sh`)
   - Colored border box on session start

2. **Statusline** (`~/.claude/statusline-command.sh`)
   - Colors `Nat-s-Agents/agents/N` in path
   - Colors `*` for dirty state in branch

## Design Principles

- **No redundant badges**: Don't show `[A1]` + `[agents/1]`
- **Color what exists**: Just color the path/branch, don't add badges
- **Dirty star**: Only `*` is colored, not whole branch name

## Example Output

```
# Agent 1 (yellow)
12:00 ~/Code/.../Nat-s-Agents/agents/1 [agents/1*] • Opus
                 ^^^^^^^^^^^^^^^^^^^^^^         ^
                 yellow                         yellow

# Main (blue)
12:00 ~/Code/.../Nat-s-Agents [main*] • Opus
                 ^^^^^^^^^^^^      ^
                 blue              blue
```

## Tags

`maw` `colors` `statusline` `identity`
