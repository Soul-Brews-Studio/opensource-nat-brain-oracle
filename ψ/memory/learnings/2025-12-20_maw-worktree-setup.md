# MAW Worktree Setup Guide

> Complete guide to setting up git worktrees for Multi-Agent Workflow

## Overview

MAW uses **git worktrees** to give each agent an isolated filesystem directory with its own branch. This prevents merge conflicts during parallel work and eliminates `.git/index.lock` issues.

```
repo/                    <- Main worktree (branch: main)
├── agents/
│   ├── 1/              <- Agent 1 worktree (branch: agents/1)
│   ├── 2/              <- Agent 2 worktree (branch: agents/2)
│   ├── 3/              <- Agent 3 worktree (branch: agents/3)
│   ├── 4/              <- Agent 4 worktree (branch: agents/4)
│   └── 5/              <- Agent 5 worktree (branch: agents/5)
└── (shared .git)
```

---

## Creating Worktrees

### Method 1: One-Liner (Recommended)

```bash
# Create branch and worktree in one command
git worktree add agents/1 -b agents/1
```

This creates:
- Directory `agents/1/`
- Branch `agents/1` tracking current HEAD
- Full working tree with all files

### Method 2: Separate Steps

```bash
# 1. Create branch from main
git branch agents/1 main

# 2. Create worktree pointing to that branch
git worktree add agents/1 agents/1
```

### Method 3: Batch Creation (All 5 Agents)

```bash
for i in 1 2 3 4 5; do
  git worktree add "agents/$i" -b "agents/$i"
done
```

Or with explicit base branch:

```bash
for i in 1 2 3 4 5; do
  git branch "agents/$i" main
  git worktree add "agents/$i" "agents/$i"
done
```

---

## Branch Naming Convention

| Pattern | Example | Use Case |
|---------|---------|----------|
| `agents/N` | `agents/1` | Standard agent branches |
| `agents/N-topic` | `agents/1-auth` | Topic-specific work |
| `experiment/name` | `experiment/dense-wiki` | Experimental branches |

### Why `agents/N`?

1. **Clarity**: Directory structure mirrors branch names
2. **Sorting**: Branches group together alphabetically
3. **Scripting**: Easy to parse with regex patterns

---

## Directory Structure

Each agent worktree contains:

```
agents/N/
├── .agent-locks/           # Lock files (prevents concurrent assignment)
├── .agent-logs/            # Agent-specific logs
├── .agent-signals/         # Completion signals
├── .agents/                # MAW scripts and profiles
│   ├── scripts/           # maw-*, agent-* scripts
│   └── profiles/          # Layout definitions
├── .claude/                # Claude Code configuration
│   └── commands/          # Slash commands
├── .sync/                  # Shared signal directory
├── .git                    # Pointer file (NOT directory)
├── ψ/                      # AI brain structure
│   ├── inbox/focus.md     # Current task
│   └── memory/            # Learnings, retrospectives
└── [all repo files]       # Full copy of codebase
```

### Key Files

| File | Purpose |
|------|---------|
| `.git` | Text file pointing to main repo's `.git/worktrees/N` |
| `ψ/inbox/focus.md` | Agent's current focus (STATE, TASK, SINCE) |
| `.agent-signals/*.done` | Completion markers |

---

## Verification Commands

### List All Worktrees

```bash
git worktree list
```

Output:
```
/path/to/repo                     927fa15 [main]
/path/to/repo/agents/1            927fa15 [agents/1]
/path/to/repo/agents/2            927fa15 [agents/2]
/path/to/repo/agents/3            927fa15 [agents/3]
/path/to/repo/agents/4            927fa15 [agents/4]
/path/to/repo/agents/5            927fa15 [agents/5]
```

### Verify Branch-Directory Match

```bash
# From any location, check agent N's branch
git -C agents/N branch --show-current
# Should output: agents/N
```

### Check Worktree Status

```bash
# Quick status check
git -C agents/1 status --short

# Detailed porcelain output
git -C agents/1 status --porcelain
```

---

## Operating Worktrees

### Golden Rule: Use `git -C`, Not `cd`

```bash
# CORRECT: Operates from any directory
git -C agents/1 status
git -C agents/2 log -1
git -C agents/3 diff

# INCORRECT: Pollutes shell state
cd agents/1 && git status && cd ../..
```

**Why?**
- Respects worktree boundaries
- No shell state pollution
- Works in scripts without subshells
- Any agent can control any other worktree

### Cross-Worktree Operations

```bash
ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"

# Main can check agent status
git -C "$ROOT/agents/1" status

# Agent can sync from main
git -C "$ROOT" rebase agents/1  # Main rebases onto agent's work

# Agent can sync peer
git -C "$ROOT/agents/2" rebase main
```

---

## Syncing Worktrees

### Sync Pattern (Rebase, Not Merge)

```bash
ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"

# 1. Agent commits their work
git -C "$ROOT/agents/1" add -A
git -C "$ROOT/agents/1" commit -m "feat: agent 1 work"

# 2. Main rebases onto agent
git -C "$ROOT" rebase agents/1

# 3. Sync other agents to main
for i in 2 3 4 5; do
  git -C "$ROOT/agents/$i" rebase main
done

# 4. Push (if needed)
git -C "$ROOT" push origin main
```

### Why Rebase?

| Method | Result |
|--------|--------|
| Merge | Creates unique merge commits per worktree |
| Rebase | Same commit hashes across all worktrees |

Rebase keeps all worktrees at the same commit.

---

## Removing Worktrees

### Remove Single Worktree

```bash
# Remove worktree and prune
git worktree remove agents/5

# Force remove (if worktree has changes)
git worktree remove agents/5 --force
```

### Remove All Agent Worktrees

```bash
for i in 1 2 3 4 5; do
  git worktree remove "agents/$i" --force
done
```

### Clean Up Stale Worktrees

```bash
# Prune worktrees that no longer exist on disk
git worktree prune
```

---

## Troubleshooting

### Error: "Branch already exists"

```bash
# If branch exists but worktree doesn't
git worktree add agents/1 agents/1  # Point to existing branch

# Or delete and recreate
git branch -D agents/1
git worktree add agents/1 -b agents/1
```

### Error: "Worktree already exists"

```bash
# Check for stale references
git worktree list

# Prune if worktree was deleted manually
git worktree prune
```

### Error: "fatal: cannot rebase with locally uncommitted changes"

```bash
# Commit or stash before rebase
git -C agents/1 stash
git -C agents/1 rebase main
git -C agents/1 stash pop
```

### Checking Worktree Health

```bash
# Verify all worktrees are valid
for i in 1 2 3 4 5; do
  if [ -d "agents/$i" ]; then
    BRANCH=$(git -C "agents/$i" branch --show-current)
    echo "Agent $i: branch=$BRANCH"
  else
    echo "Agent $i: MISSING"
  fi
done
```

---

## Best Practices

### 1. Consistent Naming

```bash
# Directory and branch should match
agents/1  ->  agents/1
agents/2  ->  agents/2
```

### 2. Initialize from Main

```bash
# Always create branches from main
git worktree add agents/N -b agents/N main
```

### 3. Sync Before Diverging

```bash
# Before assigning parallel work
for i in 1 2 3 4 5; do
  git -C "agents/$i" rebase main
done
```

### 4. Create Safety Checkpoints

```bash
# Tag before parallel work
git tag -a "maw/pre-work/$(date +%Y%m%d-%H%M)" -m "Before parallel work"
```

### 5. Verify Identity Before Operations

```bash
# Always check you're in the right worktree
pwd
git branch --show-current
```

---

## Quick Reference

| Command | Purpose |
|---------|---------|
| `git worktree add DIR -b BRANCH` | Create worktree with new branch |
| `git worktree add DIR BRANCH` | Create worktree from existing branch |
| `git worktree list` | List all worktrees |
| `git worktree remove DIR` | Remove worktree |
| `git worktree prune` | Clean stale references |
| `git -C DIR status` | Check worktree status |
| `git -C DIR rebase main` | Sync worktree with main |

---

## Related Documentation

- `2025-12-17_maw-sync-best-practices.md` - Sync patterns and conflict prevention
- `2025-12-13_maw-comprehensive-guide.md` - Full MAW architecture
- `2025-12-20_maw-hey-communication.md` - Inter-agent messaging

---

*Created: 2025-12-20*
*Context: MAW worktree setup documentation task*
