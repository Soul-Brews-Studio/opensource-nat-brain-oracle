# Agent Incubation Workflow

**Date**: 2025-12-17

## What We Learned

- **Git worktrees** = same repo, different filesystem paths. All agents/1-5 share the same git content, just checked out at different locations.

- **Incubation workflow** for new projects:
  ```
  1. gh repo create --private
  2. ghq get [repo]
  3. init commit + push
  4. symlink ψ/incubate/repo/github.com/[org]/[repo] → ghq path
  5. register slug in ψ/memory/slugs.yaml
  ```

- **Shared state architecture**:
  | Layer | Mechanism | When shared |
  |-------|-----------|-------------|
  | `.agent-logs/` | Filesystem | Instant |
  | `claude-mem` | MCP | Instant |
  | ψ/, code | Git | After merge |

- **pushd/popd** is better than `cd` for working on incubated projects - maintains "home base" context.

- **Subagent delegation**: Haiku does bulk work (scaffold, search), Opus does quality work (logic, review).

## How Things Connect

```
agents/1 (home base)
    ↓ symlink
ψ/incubate/repo/github.com/nazt/project
    ↓ points to
~/Code/github.com/nazt/project (ghq - actual code)
    ↓ pushes to
GitHub (private repo)
```

All agents can access the same ghq path, so collaboration is possible even though symlinks are local (gitignored).

## Practical Example

Built `claude-mem-visualization` (Bun + Hono + SQLite):
- Created from agents/1 space
- Symlinked to ψ/incubate/
- Actual code in ghq
- Working API serving 840 observations

## Tags

`git-worktree` `incubation` `workflow` `ghq` `subagents` `pushd-popd`
