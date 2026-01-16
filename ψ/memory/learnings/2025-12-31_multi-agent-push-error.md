# Learning: Multi-Agent Push Rejection Error

**Date**: 2025-12-31 22:35
**Context**: Session wrap-up, commit + push to main
**Error Type**: Git push rejection (non-fast-forward)

---

## What Happened 🔴

### The Error
```bash
git push origin main
# ! [rejected]        main -> main (fetch first)
# error: failed to push some refs
# hint: Updates were rejected because the remote contains work that you do
# hint: not have locally.
```

### The Scenario
1. Working session created 4 new files
2. Committed locally: `f7268d8`
3. Attempted to push → **REJECTED**
4. Remote had new commit `5105b30` that I didn't have
5. Had to fetch + rebase first

---

## Root Cause Analysis 🔍

### Why It Failed
**Multi-agent environment**: Another session/agent pushed to main while I was working

**Timeline**:
- 10:07: I started session (on commit `4c94646`)
- [Unknown time]: Another agent pushed `5105b30` to origin/main
- 22:35: I tried to push → collision

### The Mistake
**I didn't fetch before pushing** in a multi-agent repository.

In solo development, you might be the only one pushing. But in multi-agent setup (MAW), **multiple agents can push to main simultaneously**.

---

## The Fix ✅

### What I Did
```bash
git fetch origin
git rebase origin/main
git push origin main
```

**Result**: Successfully rebased `f7268d8` onto `5105b30` → new commit `6b8c9a8`

### Why It Worked
- `fetch`: Downloaded remote changes without merging
- `rebase`: Replayed my commit on top of remote changes
- `push`: Now fast-forward was possible

---

## The Pattern 📋

### ❌ OLD (Wrong)
```bash
git commit -m "message"
git push origin main  # FAIL in multi-agent env
```

### ✅ NEW (Correct)
```bash
git commit -m "message"
git fetch origin
git rebase origin/main
git push origin main
```

### ⭐ BEST (Proactive)
```bash
# BEFORE committing
git fetch origin
git rebase origin/main

# THEN commit
git commit -m "message"

# THEN push (will always succeed)
git push origin main
```

---

## Multi-Agent Context 🤖

### Why This Matters Here

**This repository uses MAW (Multi-Agent Workflow)**:
- Main agent (me)
- agents/1, agents/2, agents/3 (worktrees)
- All can push to `main` branch
- All can push to origin/main

**From CLAUDE.md** (lines 61-107):
```bash
# The Sync Pattern (FIXED)
ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"

# 0. FETCH ORIGIN FIRST (prevents push rejection!)
git -C "$ROOT" fetch origin
git -C "$ROOT" rebase origin/main

# 1. Commit your work (local)
git add -A && git commit -m "my work"

# 2. Main rebases onto agent
git -C "$ROOT" rebase agents/N

# 3. Push IMMEDIATELY (before syncing others)
git -C "$ROOT" push origin main
```

**The documentation already told me to fetch first!** I just didn't follow it.

---

## Lesson Learned 💡

### Principle
**In multi-agent environments, ALWAYS fetch + rebase before pushing**

### Why
1. **Race condition**: Other agents push while you work
2. **Non-fast-forward rejections**: Your local is behind remote
3. **Wasted time**: Have to fetch + rebase anyway after error
4. **Context switching**: Interrupts flow when push fails

### When to Apply
- **Before every push** in repositories with:
  - Multiple human collaborators
  - Multiple AI agents (MAW)
  - CI/CD that auto-commits
  - Any concurrent writers

---

## Action Items ✅

### Immediate
- [x] Document this learning
- [ ] Update mental model: "fetch before push" in multi-agent repos

### Process Change
**New habit**: In Nat-s-Agents repository, ALWAYS:
```bash
# Step 1: Fetch first
git fetch origin
git rebase origin/main

# Step 2: Commit
git add <files>
git commit -m "message"

# Step 3: Push (guaranteed fast-forward)
git push origin main
```

### Pattern Recognition
**Trigger**: When about to run `git push origin main`
**Check**: Did I fetch + rebase first?
**If no**: Run `git fetch origin && git rebase origin/main` FIRST

---

## Related Documentation

### CLAUDE.md Reference
Lines 61-107: "Multi-Agent Sync (IMPORTANT!)"
- Already documents fetch-first pattern
- I ignored it → got error
- Lesson: **Read the governance docs before pushing**

### MAW Commands
```bash
source .agents/maw.env.sh
maw sync  # Syncs all agents (includes fetch + rebase)
```

If I had used `maw sync` instead of manual git commands, this would have been handled automatically.

---

## Success Criteria ✅

**I will know this lesson is learned when**:
1. Next time I push to main, I fetch + rebase FIRST
2. Zero push rejections in next 10 commits
3. I can explain to another agent why fetch-first matters

---

## Quotes Worth Keeping

> "In multi-agent environments, your local main is ALWAYS potentially stale"

> "Fetch first, push later - prevents rejection errors"

> "The documentation already told me to fetch first. I just didn't read it."

---

## Tags

`#git` `#multi-agent` `#maw` `#error-recovery` `#process-improvement` `#claude-md-violation`

---

**Status**: Lesson captured, pattern updated, ready to apply
**Next**: Follow fetch-first pattern on every push
