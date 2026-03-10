# Always Peek Before Sync

**Date**: 2025-12-17

## What We Learned

When syncing multi-agent worktrees, **always check agent status BEFORE syncing** to avoid overwriting uncommitted work.

## The Correct Order

```bash
# 1. Peek first - check all agents
maw peek

# 2. If clean, proceed
git add -A && git commit -m "..."

# 3. Sync all worktrees
git -C "$ROOT" push origin main
for i in 1 2 3 4 5; do
  git -C "$ROOT/agents/$i" rebase origin/main
done
```

## What Can Go Wrong

If an agent has uncommitted work and you blindly rebase:
- Their work gets stashed or lost in rebase conflicts
- No warning if they were mid-task
- Context lost forever

If another session pushed while you were working:
- Push rejected (best case)
- Race condition on sync (worse)
- Decisions based on stale state (worst)

## The Fix: Enhanced Peek

```bash
ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"

# 1. Check if origin has new commits (another session active?)
git fetch origin
behind=$(git rev-list --count HEAD..origin/main)
if [ "$behind" -gt 0 ]; then
  echo "⚠️ Origin has $behind new commits!"
  git log --oneline HEAD..origin/main
fi

# 2. Check all agent worktrees for uncommitted work
for i in 1 2 3 4 5; do
  changes=$(git -C "$ROOT/agents/$i" status --short | wc -l)
  [ "$changes" -gt 0 ] && echo "⚠️ agents/$i has $changes uncommitted files"
done
```

## Real Example (2025-12-17)

We pushed commit `6fc9cf2`, then peeked and found `50cab2f` — another session had pushed between our operations. No conflict this time, but could have been:
- Push race → rejected
- Sync race → overwrote their work
- Stale peek → wrong decisions

## Tags

`maw` `multi-agent` `git` `sync` `best-practice`
