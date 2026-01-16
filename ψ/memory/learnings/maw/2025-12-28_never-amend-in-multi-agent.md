# Never Use Git Amend in Multi-Agent Setup

**Date**: 2025-12-28
**Category**: Critical Safety Rule
**Source**: Session retrospective - learned through painful experience

## The Rule

**NEVER use `git commit --amend` when working with MAW/multi-agent setup.**

## Why It Breaks Everything

```
1. Main has commit abc123
2. Agents sync → all have abc123
3. You amend → Main now has def456
4. Agents still have abc123

Result:
- Content is IDENTICAL
- But hashes are DIFFERENT
- Git sees "nothing to do" on rebase
- Branches are FOREVER DIVERGED
```

## The Trap

`git rebase` reports "already up to date" because content matches.
But the branch pointers point to different commits.
This creates phantom divergence that only `reset --hard` can fix.

## What Happens When You Amend

| Step | Main | Agent 1 | Agent 2-5 |
|------|------|---------|-----------|
| Before amend | abc123 | abc123 | abc123 |
| After amend | **def456** | abc123 | abc123 |
| After sync | def456 | def456 | abc123 (!) |
| After more syncs | def456 | def456 | abc123 (stuck!) |

## The Only Fix

```bash
# Human must run manually (blocked by safety hook)
git -C agents/N reset --hard main
```

## Prevention

1. **Hook blocks amend**: `~/.claude/hooks/safety-check.sh` now blocks `git commit.*--amend`
2. **Documentation**: CLAUDE.md Golden Rule #5, CLAUDE_safety.md detailed section
3. **Alternative**: Create NEW commit instead: `git commit -m "fix: ..."`

## Pattern

```bash
# WRONG - breaks all agents
git commit --amend -m "fix typo"

# RIGHT - safe for multi-agent
git commit -m "fix: correct typo in previous commit"
```

## Key Insight

In single-developer workflow: amend = convenient cleanup
In multi-agent workflow: amend = nuclear option that orphans all agents

The extra commit is a small price for system stability.

---

**Related**:
- `CLAUDE_safety.md` - Multi-Agent Worktree Safety section
- `~/.claude/hooks/safety-check.sh` - Blocking hook
