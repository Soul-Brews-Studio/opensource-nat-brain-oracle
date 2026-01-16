# direnv exec Pattern for Multi-Agent Workflows

> Run commands in a directory's environment without changing working directory

## The Problem

When agents need to run `maw` commands (or any direnv-managed tools), they can't just call the command directly:

```bash
maw peek  # Error: command not found
```

Because `maw` is defined in `.envrc` and only loaded when you're in that directory.

## The Solution

```bash
direnv exec /path/to/repo maw peek
```

This runs the command AS IF you're in that directory, with all its environment loaded.

## Why This Matters for Multi-Agent Workflows

| Approach | Problem |
|----------|---------|
| `cd /repo && maw peek && cd -` | Pollutes shell state, fragile |
| `source .envrc && maw peek` | Side effects, may break things |
| `direnv exec /repo maw peek` | Clean, no side effects |

## Pattern Alignment

Works well with existing patterns:

| Pattern | Use Case |
|---------|----------|
| `git -C /repo` | Git commands across worktrees |
| `direnv exec /repo` | direnv-managed commands |

Both follow the same philosophy: **control from anywhere, respect boundaries**

## Examples

```bash
# Check all agents from anywhere
direnv exec /Users/nat/Code/github.com/laris-co/Nat-s-Agents maw peek

# Run maw commands without cd
direnv exec "$ROOT" maw sync
direnv exec "$ROOT" maw hey "message"
```

## Key Insight

> `direnv exec` = "run command AS IF I'm in that directory"

Perfect for agents that need to coordinate across multiple worktrees without leaving their own.

---

*Discovered: 2025-12-17 by Agent 3*
*Context: Trying to run `maw peek` from agent worktree*
