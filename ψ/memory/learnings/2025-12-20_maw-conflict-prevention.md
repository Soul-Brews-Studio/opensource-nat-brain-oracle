# MAW Focus.md Conflict Prevention

**Date**: 2025-12-20
**Category**: MAW Coordination
**Status**: Solved (Trial 9+)

---

## The Problem

`ψ/inbox/focus.md` is a session state file that **every agent updates constantly**. When agents work in parallel, this creates the #1 source of merge conflicts during `maw sync`.

```
Agent 1: STATE: working, TASK: "documenting hey.sh"
Agent 2: STATE: working, TASK: "creating learnings"
Agent 3: STATE: working, TASK: "writing tests"

Result: 3-way merge conflict on every sync!
```

---

## Root Cause Analysis

### Why This File Conflicts

| Factor | Impact |
|--------|--------|
| **All agents write to it** | Every task update touches this file |
| **Frequent updates** | STATE changes constantly (working → pending → completed) |
| **Same location** | `ψ/inbox/focus.md` is identical path in every worktree |
| **Merge semantics** | Git sees different content, cannot auto-merge |

### The Rebase Conflict Pattern

During `maw sync`, each agent rebases onto main:

```bash
git -C agents/1 rebase main
# CONFLICT: focus.md has different content!
# Agent's version: "TASK: hey.sh docs"
# Main's version:  "TASK: sync patterns"
```

`maw sync` auto-aborts on conflict, leaving agent unchanged — but this prevents the sync from completing.

---

## Prevention Strategies

### Strategy 1: Per-Agent Focus Files (Recommended)

Create separate focus files for each agent:

```
ψ/inbox/focus.md    # Main worktree
ψ/inbox/focus-1.md  # Agent 1 only
ψ/inbox/focus-2.md  # Agent 2 only
ψ/inbox/focus-3.md  # Agent 3 only
ψ/inbox/focus-4.md  # Agent 4 only
ψ/inbox/focus-5.md  # Agent 5 only
```

**Benefits**:
- Zero conflicts possible (different files)
- Each agent owns their state completely
- `maw peek` can read all files for system overview

**Implementation**:
```bash
# In agent N's session hook or CLAUDE.md instructions:
FOCUS_FILE="ψ/inbox/focus-${AGENT_NUM}.md"

echo "STATE: working
TASK: $CURRENT_TASK
SINCE: $(date '+%H:%M')" > "$FOCUS_FILE"
```

### Strategy 2: Gitignore focus.md

Add to `.gitignore`:

```gitignore
# Focus files (session state, not synced)
ψ/inbox/focus.md
agents/*/ψ/inbox/focus.md
```

**Benefits**:
- Simple solution
- No changes to existing workflow

**Trade-offs**:
- Focus state not preserved in git history
- Cannot track agent activity via commits

### Strategy 3: Overwrite Pattern (Workaround)

Accept that focus.md will always conflict, resolve by overwriting:

```bash
# During conflict resolution:
git checkout --theirs ψ/inbox/focus.md  # Accept main's version
git add ψ/inbox/focus.md
git rebase --continue

# Immediately after:
echo "STATE: working
TASK: Resumed after sync
SINCE: $(date '+%H:%M')" > ψ/inbox/focus.md
```

**When to use**: Quick fix when other strategies aren't in place.

---

## Resolution Workflow

### When Conflict Occurs

```bash
# 1. maw sync reports conflict
$ maw sync
=== Agent 2 ===
✗ Rebase conflict
  → Manual resolution: git -C agents/2 rebase main

# 2. Check which file conflicted
$ git -C agents/2 status
UU ψ/inbox/focus.md

# 3. Resolve by accepting main's version
$ git -C agents/2 checkout --theirs ψ/inbox/focus.md
$ git -C agents/2 add ψ/inbox/focus.md

# 4. Continue rebase
$ git -C agents/2 rebase --continue

# 5. Agent updates their focus
$ echo "STATE: working
TASK: Sync completed
SINCE: $(date '+%H:%M')" > agents/2/ψ/inbox/focus.md
```

### Quick Resolution Script

```bash
#!/bin/bash
# resolve-focus-conflict.sh

AGENT_DIR="$1"
if [[ -z "$AGENT_DIR" ]]; then
  echo "Usage: resolve-focus-conflict.sh agents/N"
  exit 1
fi

# Accept theirs (main) and continue
git -C "$AGENT_DIR" checkout --theirs ψ/inbox/focus.md
git -C "$AGENT_DIR" add ψ/inbox/focus.md
git -C "$AGENT_DIR" rebase --continue

echo "✓ Resolved focus.md conflict in $AGENT_DIR"
```

---

## Trial History

### Evolution of Solutions

| Trial | Approach | Result |
|-------|----------|--------|
| 1-6 | No prevention | Frequent conflicts |
| 7-8 | Manual resolution | Works but tedious |
| 9 | Per-agent focus files | **Zero conflicts** |
| 10+ | Verified pattern | 1447+ lines, no issues |

### Trial 9 Success Pattern

Commit `927fa15` documented:
```
docs: trial 9 success - zero conflicts with focus.md exclusion
```

This trial introduced `focus-N.md` files, achieving:
- ✓ All 5 agents working in parallel
- ✓ Zero merge conflicts
- ✓ Clean `maw sync` every time

---

## Integration with MAW Commands

### maw peek (Reading Focus State)

```bash
# Read all agent focus states
for i in 1 2 3 4 5; do
  if [[ -f "agents/$i/ψ/inbox/focus-$i.md" ]]; then
    TASK=$(grep "^TASK:" "agents/$i/ψ/inbox/focus-$i.md" | cut -d: -f2-)
  elif [[ -f "agents/$i/ψ/inbox/focus.md" ]]; then
    TASK=$(grep "^TASK:" "agents/$i/ψ/inbox/focus.md" | cut -d: -f2-)
  fi
  echo "Agent $i: $TASK"
done
```

### maw sync (Pre-Check)

Add to smart-sync.sh:
```bash
# Check for focus.md in dirty files - these are expected
FOCUS_ONLY=$(echo "$worktree_status" | grep -v "focus" | wc -l)
if [[ "$FOCUS_ONLY" -eq 0 ]]; then
  # Only focus.md changed - safe to auto-resolve
  git checkout --theirs ψ/inbox/focus.md
  git add ψ/inbox/focus.md
fi
```

---

## Best Practices

### Do's

| Practice | Why |
|----------|-----|
| Use per-agent focus files (`focus-N.md`) | Zero conflicts |
| Overwrite, don't append | No merge needed |
| Accept `--theirs` for shared focus.md | Quick resolution |
| Update focus immediately after sync | Fresh state |

### Don'ts

| Anti-Pattern | Problem |
|--------------|---------|
| Append to shared focus.md | Creates merge markers |
| Commit focus.md changes frequently | More conflict chances |
| Edit focus.md during rebase | Blocks rebase completion |
| Ignore focus conflicts | Blocks entire sync |

---

## File Structure

### Recommended Layout

```
ψ/inbox/
├── focus.md          # Main worktree (optional)
├── focus-1.md        # Agent 1's state
├── focus-2.md        # Agent 2's state
├── focus-3.md        # Agent 3's state
├── focus-4.md        # Agent 4's state
├── focus-5.md        # Agent 5's state
└── INDEX.md          # Directory index
```

### Focus File Format

```markdown
STATE: working|pending|completed|jumped|focusing
TASK: Current task description
SINCE: 14:25
```

---

## Monitoring

### Check for Potential Conflicts

```bash
# See which agents have modified focus.md
for i in 1 2 3 4 5; do
  STATUS=$(git -C "agents/$i" status --porcelain ψ/inbox/focus.md 2>/dev/null)
  if [[ -n "$STATUS" ]]; then
    echo "Agent $i: focus.md modified"
  fi
done
```

### Verify No Conflicts Before Sync

```bash
# Safe sync check
maw peek | grep -v "focus.md" | grep "M "
# If output is empty, sync should be conflict-free
```

---

## Summary

| Solution | Complexity | Reliability |
|----------|------------|-------------|
| Per-agent files | Low | **Highest** |
| Gitignore | Low | High |
| Auto-resolve script | Medium | Medium |
| Manual resolution | High | Variable |

**Recommendation**: Use per-agent focus files (`focus-N.md`). This is the proven pattern from Trial 9 that eliminated all focus.md conflicts in MAW parallel execution.

---

## Related Documentation

| File | Topic |
|------|-------|
| `maw-sync-command.md` | Smart sync mechanics |
| `maw-git-workflow-patterns.md` | Conflict resolution patterns |
| `maw-sync-internals.md` | Per-agent logging strategy |
| `maw-peek-monitoring.md` | Reading agent state |

---

## Tags

`maw` `focus.md` `conflict-prevention` `sync` `per-agent` `worktree` `parallel-execution`
