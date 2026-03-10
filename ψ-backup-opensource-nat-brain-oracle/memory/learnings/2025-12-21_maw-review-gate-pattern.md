# MAW Review Gate Pattern

**Date**: 2025-12-21

## What We Learned

The MAW workflow was too fast — agents finish, sync, push without human review. This violates the principle of human oversight.

### The Problem
```
dispatch → monitor → sync → push  ← No review!
```

### The Solution
```
dispatch → checkpoint → monitor → REVIEW → approve/reject → sync
```

## Key Components

### 1. Checkpoint Before Dispatch
```bash
# Tag each agent's starting point
git -C agents/1 tag -f maw-start-1
git -C agents/2 tag -f maw-start-2
...
```

### 2. Review Before Merge
```bash
# Show what each agent did
for i in 1 2 3 4 5; do
  git -C agents/$i diff --stat maw-start-$i
done
```

### 3. Accept or Reject Per-Agent
```bash
# Accept: rebase to main
# Reject: reset to checkpoint
git -C agents/2 reset --hard maw-start-2
```

## How Things Connect

| Old Problem | New Solution |
|-------------|--------------|
| Auto-merge blindly | Review gate requires approval |
| Can't undo agent work | Checkpoint enables rollback |
| `sleep 45` wastes tokens | `maw watch` user runs locally |
| Lose start point after commits | Per-agent tags preserve start |

## The Insight

> **Speed without review = risk. Automation should amplify control, not remove it.**

Same principle as:
- Git branches (can always rollback)
- PR reviews (human gate before merge)
- Staging environments (test before prod)

## Tags

`maw` `workflow` `review-gate` `checkpoint` `rollback` `safety`
