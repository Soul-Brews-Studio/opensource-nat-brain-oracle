# MAW Sync vs Merge

**Date**: 2025-12-28

## The Two Commands

| Command | Direction | Purpose | Who |
|---------|-----------|---------|-----|
| `maw sync` | main → agents | Distribute latest to all | Anyone |
| `maw merge N` | agent N → main | Collect work from agent | Human/Main |

## Visual

```
maw sync:
main ──► agents/1
     ──► agents/2
     ──► agents/3
     ──► agents/4
     ──► agents/5

maw merge 1:
agents/1 ──► main ──► push origin ──► sync all
```

## Agent Workflow (Complete)

```bash
# 1. Agent commits to own branch
git add -A && git commit -m "feat: ..."

# 2. Agent pushes to own branch
git push origin agents/N

# 3. Agent creates PR
gh pr create --title "..." --body "..."

# 4. Human merges (choose one)
maw merge N          # CLI way
# or merge PR on GitHub

# 5. Sync all agents
maw sync             # Everyone gets latest
```

## Safety Rules

```bash
# ❌ Agent CANNOT
git push origin main           # BLOCKED by safety-check.sh

# ✅ Agent CAN
git push origin agents/N       # Own branch OK
gh pr create                   # PR OK
maw sync                       # Sync OK (read-only for agent)
```

## Current Issue

`maw sync` doesn't work from agent worktree (can't find scripts).

Workaround:
```bash
MAW_REPO_ROOT="/path/to/repo" /path/to/repo/.agents/scripts/smart-sync.sh
```

## Tags

`maw` `sync` `merge` `workflow` `git`
