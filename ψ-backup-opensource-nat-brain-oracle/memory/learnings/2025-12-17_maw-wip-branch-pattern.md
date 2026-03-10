# MAW PR Review Pattern: Simple & Optional

**Date**: 2025-12-17
**Status**: Current (simplified from earlier complex version)

## Core Rule

**PR review is OPTIONAL. User decides.**

```
Default:  agents/N → main rebase → push → sync  (fast, no review)
Optional: agents/N → push → PR → merge → sync  (when user wants review)
```

## The Two Flows

### Flow A: Direct Sync (Default)

```bash
# Agent commits
git -C agents/N commit -m "work"

# Main gets work
git rebase agents/N

# Push and sync
git push origin main
maw sync
```

**When**: Routine work, small fixes, trusted changes

### Flow B: PR Review (Optional)

```bash
# Agent commits
git -C agents/N commit -m "work"

# Push agent branch to origin
git -C agents/N push origin agents/N

# Create PR
gh pr create --head agents/N --base main

# ... review on GitHub ...

# Merge
gh pr merge --rebase

# Sync everyone
git fetch origin
git rebase origin/main
maw sync
```

**When**: Risky changes, want visibility, user requests review

## AI Decision Point

When agent work is done, AI asks:

> "Agent work complete. How do you want to proceed?
> 1. **Direct sync** — merge to main now
> 2. **PR review** — create PR for review first"

### When to Suggest Each

| Situation | Suggest |
|-----------|---------|
| Small fix | Direct sync |
| Routine task | Direct sync |
| User says "just push" | Direct sync |
| Risky change | PR review |
| New feature | PR review |
| User says "review first" | PR review |

## Rules

1. **User decides** — AI suggests, user chooses
2. **Rebase merge** — Always use `--rebase` for clean history
3. **Sync after merge** — All agents get the merged work
4. **No force push** — Never `--force`
5. **Cleanup branches** — Delete remote agents/N after PR merge

## Reject Pattern

```bash
# If PR rejected or work is bad:
gh pr close                           # Close PR
git push origin --delete agents/N     # Delete remote branch
git -C agents/N rebase main           # Reset agent to main
```

## Quick Reference

| Goal | Command |
|------|---------|
| Direct sync | `git rebase agents/N && git push && maw sync` |
| Push for PR | `git -C agents/N push origin agents/N` |
| Create PR | `gh pr create --head agents/N --base main` |
| Merge PR | `gh pr merge --rebase` |
| Sync after merge | `git fetch origin && git rebase origin/main && maw sync` |

---

## Future Discussion Topics

> These need more thought. Discuss later.

- [ ] Should agents/N ever be pushed to origin by default?
- [ ] What about wip/* branch naming for cleaner separation?
- [ ] How to handle multiple agents collaborating on same feature?
- [ ] CI/CD triggers — should agent branches run tests?
- [ ] Auto-cleanup of merged remote branches?

## Tags

`maw` `pr` `review` `optional` `simple` `branching`
