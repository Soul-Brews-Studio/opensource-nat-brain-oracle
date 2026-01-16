# Agent PR Workflow

**Date**: 2025-12-28

## The Rule

Agents (1-5) cannot push to main. Must use PR workflow.

## Agent Workflow

```bash
# 1. Commit to YOUR branch
git add -A && git commit -m "feat: description"

# 2. Push to YOUR branch
git push origin agents/N   # N = your agent number

# 3. Create PR
gh pr create --title "feat: title" --body "## Summary
- What changed

## Test plan
- [ ] Test case 1
- [ ] Test case 2
"

# 4. Wait for human to merge
# Human runs: maw merge N
```

## What Gets Blocked

```bash
# ❌ BLOCKED - agent cannot push to main
git push origin main
git -C /path/to/root push origin main

# ✅ ALLOWED - push to own branch
git push origin agents/1
```

## Checklist Template (for PR body)

```markdown
## Summary
- [What changed]

## Test plan
- [ ] [Test case 1]
- [ ] [Test case 2]

🤖 Generated with [Claude Code](https://claude.com/claude-code)
```

## maw merge N

Only human or main agent runs this:

```bash
maw merge 1   # Merge agent 1 into main, push, sync all
```

What it does:
1. Fetch origin
2. Rebase agents/N into main
3. Push main to origin
4. Sync all agents to new main

## Tags

`maw` `pr` `workflow` `git` `agents`
