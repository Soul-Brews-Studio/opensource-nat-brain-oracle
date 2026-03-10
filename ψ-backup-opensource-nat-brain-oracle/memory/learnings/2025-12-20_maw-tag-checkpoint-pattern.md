# MAW Git Tag Checkpoint Pattern

**Date**: 2025-12-20
**Category**: Multi-Agent Safety

---

## The Problem: Why Branches Aren't Enough

### Scenario: Agent Work Goes Wrong

When running parallel agents, things can go wrong:

```
Main assigns tasks to 3 agents
    ↓
Agent 1: completes task, commits
Agent 2: completes task, commits
Agent 3: makes mistake, commits BAD code
    ↓
maw sync → all work merged to main
    ↓
💥 Main is now broken, agent branches have moved
```

**Why branches fail for rollback:**

| Issue | Why Branches Don't Help |
|-------|------------------------|
| Branch heads move | After rebase, old position is lost |
| Reflog expires | Local reflog helps, but expires and isn't shared |
| No clear point | Which commit was "safe"? Hard to remember |
| Multi-agent chaos | 3 agents = 3 different histories to untangle |

**Key insight**: You need an **immutable snapshot** at a known-safe point.

---

## The Solution: Git Tags as Checkpoints

Git tags are immutable markers that:
- Never move (unlike branch heads)
- Are shared across worktrees
- Can be listed and filtered
- Include timestamps and messages

### Tag Naming Convention

```
maw/<type>/<YYYYMMDD-HHMM>[-description]
```

| Type | When Created | Purpose |
|------|--------------|---------|
| `pre-work` | Before assigning tasks | Safe rollback point |
| `post-sync` | After successful sync | Milestone marker |
| `checkpoint` | Manual safety point | User-triggered save |
| `recovery` | After rollback | Mark recovery point |

**Examples:**
```
maw/pre-work/20251220-1154                    # Before task assignment
maw/pre-work/20251220-1154-feature-003        # With description
maw/post-sync/20251220-1230                   # After sync complete
maw/checkpoint/20251220-1400-before-refactor  # Manual checkpoint
maw/recovery/20251220-1500-from-1154          # After rollback
```

---

## Implementation Commands

### Creating Checkpoints

```bash
# Pre-flight checkpoint (before work)
git tag -a "maw/pre-work/$(date +%Y%m%d-%H%M)" -m "Before parallel work"

# With description
git tag -a "maw/pre-work/$(date +%Y%m%d-%H%M)-feature-003" \
    -m "Before MAW-FEATURE-003 tasks"

# Post-sync milestone
git tag -a "maw/post-sync/$(date +%Y%m%d-%H%M)" -m "All agents synced"

# Manual checkpoint (any time)
git tag -a "maw/checkpoint/$(date +%Y%m%d-%H%M)" -m "Manual save point"
```

### Listing Checkpoints

```bash
# All MAW tags
git tag -l "maw/*"

# Only pre-work checkpoints
git tag -l "maw/pre-work/*"

# With dates and messages
git tag -l "maw/*" --format='%(refname:short) - %(contents:subject) (%(creatordate:short))'

# Today's checkpoints
git tag -l "maw/*/$(date +%Y%m%d)*"
```

### Rollback Operations

```bash
# 1. List available checkpoints
git tag -l "maw/pre-work/*" --sort=-creatordate | head -5

# 2. Inspect a checkpoint
git log -1 "maw/pre-work/20251220-1154"
git diff "maw/pre-work/20251220-1154"..HEAD

# 3. Rollback main to checkpoint
git checkout main
git reset --hard "maw/pre-work/20251220-1154"

# 4. Mark recovery point
git tag -a "maw/recovery/$(date +%Y%m%d-%H%M)-from-1154" \
    -m "Rolled back from failed sync"

# 5. Re-sync all agents to recovered main
ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"
for i in 1 2 3 4 5; do
    git -C "$ROOT/agents/$i" rebase main
done
```

### Comparing States

```bash
# What changed since checkpoint?
git diff "maw/pre-work/20251220-1154"..HEAD

# Which files changed?
git diff --name-only "maw/pre-work/20251220-1154"..HEAD

# Commits since checkpoint
git log --oneline "maw/pre-work/20251220-1154"..HEAD
```

---

## Integration with MAW Workflow

### Option 1: Manual Checkpoint (Current)

Add to pre-flight checklist:

```bash
# Pre-flight protocol
mkdir -p .agent-signals
rm -f .agent-signals/*.done
git tag -a "maw/pre-work/$(date +%Y%m%d-%H%M)" -m "Before parallel work"
maw sync
```

**Pros**: Simple, explicit, user controls
**Cons**: Easy to forget

### Option 2: Auto-Checkpoint in `maw sync`

Modify sync script to auto-create tag:

```bash
# In maw sync function
maw_sync() {
    # Auto-checkpoint before sync
    git tag -a "maw/pre-sync/$(date +%Y%m%d-%H%M)" \
        -m "Auto: before sync" 2>/dev/null || true

    # ... existing sync logic ...

    # Mark successful sync
    git tag -a "maw/post-sync/$(date +%Y%m%d-%H%M)" \
        -m "Auto: sync complete" 2>/dev/null || true
}
```

**Pros**: Never forget, automatic safety
**Cons**: More tags to manage

### Option 3: New Command `maw checkpoint`

Add dedicated checkpoint command:

```bash
# maw checkpoint [description]
maw_checkpoint() {
    local desc="${1:-manual}"
    local tag="maw/checkpoint/$(date +%Y%m%d-%H%M)-${desc}"

    git tag -a "$tag" -m "Checkpoint: $desc"
    echo "Created checkpoint: $tag"
}

# Usage
maw checkpoint before-refactor
maw checkpoint  # Creates maw/checkpoint/20251220-1400-manual
```

**Pros**: Explicit, descriptive
**Cons**: Extra command to remember

### Recommended: Hybrid Approach

1. **Auto-tag on sync** → Always have pre-sync checkpoints
2. **Manual checkpoint** → For important moments
3. **Tag cleanup** → Prune old tags weekly

---

## Pre-Flight Checklist (Updated)

Before assigning parallel work:

```bash
# 1. Create checkpoint
git tag -a "maw/pre-work/$(date +%Y%m%d-%H%M)" -m "Before parallel work"

# 2. Sync all agents to same commit
maw sync

# 3. Verify checkpoint created
git tag -l "maw/pre-work/*" | tail -1

# 4. Create signal directory
mkdir -p .agent-signals
rm -f .agent-signals/*.done

# 5. Record checkpoint in task message
echo "Rollback point: maw/pre-work/$(date +%Y%m%d-%H%M)"
```

---

## Tag Cleanup Strategy

Tags accumulate. Clean periodically:

```bash
# List old checkpoints (> 7 days)
git tag -l "maw/*" --format='%(refname:short) %(creatordate:short)' \
    | awk -v cutoff="$(date -d '7 days ago' +%Y-%m-%d)" '$2 < cutoff'

# Delete old pre-work tags (keep post-sync for history)
git tag -l "maw/pre-work/*" | while read tag; do
    age=$(git log -1 --format='%ct' "$tag")
    week_ago=$(date -d '7 days ago' +%s)
    if [ "$age" -lt "$week_ago" ]; then
        git tag -d "$tag"
    fi
done

# Push tag deletions to remote
git push origin --delete <tag-name>
```

**Retention Policy:**
| Type | Keep Duration |
|------|---------------|
| `pre-work` | 7 days |
| `post-sync` | 30 days |
| `checkpoint` | 90 days |
| `recovery` | Forever (document incidents) |

---

## How Things Connect

```
Pre-flight ──────► maw/pre-work tag
    │
    ▼
Tasks assigned ──► Agents work in parallel
    │
    ▼
maw sync ────────► maw/post-sync tag
    │
    ├── Success → Continue
    │
    └── Failure → Rollback to pre-work tag
                      │
                      ▼
                  maw/recovery tag
```

---

## Key Takeaways

1. **Tags are insurance** - Cost nothing, save everything
2. **Pre-work tags are essential** - Always know where to rollback
3. **Naming convention matters** - Easy to filter and find
4. **Cleanup prevents clutter** - Prune old checkpoints weekly

---

## Tags

`git` `tags` `maw` `checkpoint` `rollback` `safety` `multi-agent`
