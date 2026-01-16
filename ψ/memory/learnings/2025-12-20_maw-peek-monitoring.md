# MAW Peek Monitoring System

> Real-time visibility into multi-agent state without interruption.

## Overview

The `maw peek` command provides a read-only monitoring interface for the Multi-Agent Workflow system. This document focuses on the internal monitoring mechanics: how status is detected, git state is tracked, and commit synchronization is observed.

---

## Status Display Architecture

### Status Detection Pipeline

The status display follows a three-stage pipeline:

```
Git Worktree → git status --porcelain → Parser → Display Format
```

Each stage has specific responsibilities:

| Stage | Input | Output | Purpose |
|-------|-------|--------|---------|
| Git Query | Worktree path | Raw status | Get file changes |
| Parser | Porcelain output | Counts | Classify changes |
| Formatter | Counts | Display string | Human-readable |

### The Porcelain Format

The `--porcelain` flag produces machine-stable output:

```bash
git status --porcelain
# Output format:
# XY FILENAME
# Where X = staging area status, Y = worktree status
```

**Status Code Reference:**

| Code | Staging | Worktree | Meaning |
|------|---------|----------|---------|
| `M ` | Modified | - | Staged modification |
| ` M` | - | Modified | Unstaged modification |
| `MM` | Modified | Modified | Both (partially staged) |
| `A ` | Added | - | New file staged |
| `??` | - | - | Untracked file |
| `D ` | Deleted | - | Staged deletion |
| ` D` | - | Deleted | Unstaged deletion |

### Status Parsing Logic

```bash
# From peek.sh - the core parsing function
get_status() {
  local dir="$1"
  local status

  # Use git -C for remote inspection (no cd needed)
  if [[ "$dir" == "." ]]; then
    status=$(git status --porcelain 2>/dev/null)
  else
    status=$(git -C "$dir" status --porcelain 2>/dev/null)
  fi

  if [[ -z "$status" ]]; then
    echo -e "${GREEN}✓${NC}"  # Clean state
  else
    # Count modifications and new files separately
    local mod=$(echo "$status" | grep -c "^ M\| M\|^M" || true)
    local new=$(echo "$status" | grep -c "^??" || true)

    # Format based on what changed
    if [[ $mod -gt 0 && $new -gt 0 ]]; then
      echo -e "${YELLOW}${mod}m ${new}+${NC}"
    elif [[ $mod -gt 0 ]]; then
      echo -e "${YELLOW}${mod} mod${NC}"
    elif [[ $new -gt 0 ]]; then
      echo -e "${YELLOW}${new} new${NC}"
    else
      local total=$((mod + new))
      echo -e "${YELLOW}${total} chg${NC}"
    fi
  fi
}
```

### Status Display Formats

| Condition | Display | Example |
|-----------|---------|---------|
| No changes | `✓` (green) | Clean worktree |
| Modified only | `N mod` (yellow) | `3 mod` |
| New only | `N new` (yellow) | `2 new` |
| Both types | `Nm N+` (yellow) | `3m 2+` |
| Other changes | `N chg` (yellow) | `5 chg` |

---

## Git Status Integration

### Remote Worktree Inspection

The key pattern enabling non-invasive monitoring:

```bash
# Instead of cd + command (changes shell state)
cd agents/1 && git status

# Use git -C (pure inspection, no side effects)
git -C agents/1 status --porcelain
```

**Benefits of `git -C`:**

| Aspect | cd + command | git -C |
|--------|--------------|--------|
| Shell state | Modified | Preserved |
| Error recovery | Complex | Simple |
| Parallel safety | Risky | Safe |
| Script simplicity | Lower | Higher |

### Multi-Worktree Discovery

The monitoring system discovers agents dynamically:

```bash
# List all worktrees
git worktree list

# Output format:
# /path/to/repo                     abc1234 [main]
# /path/to/repo/agents/1            def5678 [agents/1]
# /path/to/repo/agents/2            ghi9012 [agents/2]
```

The parser extracts agent numbers using regex:

```bash
if [[ "$path" =~ agents/([0-9]+)$ ]]; then
  agent_num="${BASH_REMATCH[1]}"
fi
```

### Status Scope

Each agent's status is isolated to their worktree:

```
Main (root)       → ψ/inbox/focus.md, ψ/memory/...
Agent 1           → agents/1/ψ/inbox/focus.md, agents/1/...
Agent 2           → agents/2/ψ/inbox/focus.md, agents/2/...
```

Git tracks changes relative to each worktree's branch.

---

## Commit Tracking

### Latest Commit Detection

```bash
get_commit() {
  local dir="$1"
  if [[ "$dir" == "." ]]; then
    git log -1 --format="%h" 2>/dev/null || echo "-"
  else
    git -C "$dir" log -1 --format="%h" 2>/dev/null || echo "-"
  fi
}
```

**Format Specifiers:**

| Specifier | Output | Example |
|-----------|--------|---------|
| `%h` | Abbreviated hash | `f59ff0b` |
| `%H` | Full hash | `f59ff0baa...` |
| `%s` | Subject line | `Add feature X` |
| `%cr` | Relative time | `2 hours ago` |

### Sync State Detection

Commit hash comparison reveals synchronization state:

```
Agent  │ Commit
───────┼────────
Main   │ f59ff0b  ← Reference point
1      │ f59ff0b  ← Synced (same hash)
2      │ 64f574b  ← Diverged (different hash)
3      │ f59ff0b  ← Synced
```

### Interpreting Commit Differences

| Scenario | Symptoms | Action Needed |
|----------|----------|---------------|
| All same | All agents show same hash | None - fully synced |
| Agent ahead | Agent has newer hash | Main should rebase onto agent |
| Agent behind | Agent has older hash | Agent needs `git rebase main` |
| Diverged | Different hash, no relationship | Investigate branches |

### Detail View Commit Display

```bash
# In detail mode, show full commit context
git log -1 --format="  %h %s (%cr)"
# Output: f59ff0b Add feature X (2 hours ago)
```

---

## Focus State Monitoring

### Focus File Structure

Each agent maintains `ψ/inbox/focus.md`:

```markdown
STATE: working
TASK: Create maw peek monitoring documentation
SINCE: 14:00
```

### Task Extraction

```bash
get_task() {
  local focus_file="$1"
  if [[ -f "$focus_file" ]]; then
    local task=$(grep "^TASK:" "$focus_file" | sed 's/TASK: //' | head -1)
    # Truncate to 30 chars for table view
    if [[ ${#task} -gt 30 ]]; then
      echo "${task:0:27}..."
    else
      echo "$task"
    fi
  else
    echo "-"
  fi
}
```

### Focus States

| State | Meaning | Interrupt? |
|-------|---------|------------|
| `working` | Actively on task | Check first |
| `focusing` | Deep work mode | Do not interrupt |
| `pending` | Waiting for input | Safe to engage |
| `jumped` | Changed context | May need guidance |
| `completed` | Task finished | Safe to assign new |

---

## Monitoring Patterns

### Pattern 1: Pre-Sync Validation

```bash
# Before any sync operation
maw peek

# Expected: all agents show ✓
# If any show changes: wait for commits
```

### Pattern 2: Progress Tracking

```bash
# Quick check during parallel work
maw peek

# Deep dive if concerned about specific agent
maw peek 2

# Output shows file-level changes + focus state
```

### Pattern 3: Commit Divergence Alert

```bash
# When hashes don't match
maw peek
# Agent 2 shows different commit

# Investigate the divergence
git -C agents/2 log --oneline -3
```

### Pattern 4: Session Recovery

```bash
# Returning after break - what's happening?
maw peek

# Task column shows current activities
# Status shows uncommitted work
# Commit shows sync state
```

---

## Color Coding Reference

| Color | Variable | ANSI Code | Usage |
|-------|----------|-----------|-------|
| Green | `$GREEN` | `\033[0;32m` | Clean status (✓) |
| Yellow | `$YELLOW` | `\033[1;33m` | Changes present |
| Red | `$RED` | `\033[0;31m` | Reserved (errors) |
| Cyan | `$CYAN` | `\033[0;36m` | Headers/titles |
| Dim | `$DIM` | `\033[2m` | Subtle text |
| Reset | `$NC` | `\033[0m` | Clear formatting |

---

## Implementation Notes

### Non-Destructive Guarantee

The peek command is strictly read-only:
- No `git checkout`, `git reset`, or `git stash`
- No file modifications
- No process signals to agents
- Pure observation via `git status` and file reading

### Error Handling

```bash
set -euo pipefail

# Safe fallbacks
git log -1 --format="%h" 2>/dev/null || echo "-"
grep "^TASK:" "$focus_file" 2>/dev/null || true
```

### Performance Considerations

| Operation | Cost | Mitigation |
|-----------|------|------------|
| `git status` per agent | Low | Parallel possible |
| File read (focus.md) | Minimal | Single line grep |
| `git log -1` | Low | Single commit lookup |

---

## Related Documentation

- `ψ/memory/learnings/2025-12-20_maw-peek-guide.md` - Usage patterns
- `ψ/memory/learnings/2025-12-17_peek-before-sync.md` - Sync safety
- `ψ/memory/learnings/2025-12-17_maw-peek-table-format.md` - Format evolution

---

*Last updated: 2025-12-20*
*Source: `.agents/scripts/peek.sh` implementation analysis*
