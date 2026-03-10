# Test Scores ≠ Code Quality

**Date**: 2025-12-15
**Source**: Session 16:13 — /project command iteration
**Category**: Development Pattern

## The Pattern

Passing tests (even 10/10) doesn't mean the code is good.

```
10/10 test score + 200 lines of bash = ❌ Over-engineered
10/10 test score + 120 lines of bash = ✅ Maintainable
```

## What Happened

1. Fixed `/project` command bugs
2. Ran 5 parallel tests → scores 7.5-10/10
3. Added error handling, tables, verification → all 10/10
4. User: "make sure it not too fixed and still simple"
5. Simplified 200 → 120 lines → still 10/10, but **readable**

## The Lesson

**Test scores measure functionality, not maintainability.**

A human should be able to read the code in 5 seconds and understand what it does.

## Before (Over-engineered)

```bash
# Check if already exists
if [ -L "ψ/learn/github.com/$ORG/$REPO_NAME" ]; then
  echo "⚠️ Already learning: ψ/learn/github.com/$ORG/$REPO_NAME"
  exit 0
fi

# Create nested structure
mkdir -p "ψ/learn/github.com/$ORG"
ln -sf "$REPO_PATH" "ψ/learn/github.com/$ORG/"

# Verify
ls -la "ψ/learn/github.com/$ORG/$REPO_NAME" 2>/dev/null || echo "❌ Verification failed"
```

## After (Simple)

```bash
# 1. Clone via ghq
ghq get -u [URL]

# 2. Get path from ghq
REPO=$(basename "[URL]" .git)
PATH=$(ghq list -p | grep "$REPO" | head -1)
ORG=$(basename "$(dirname "$PATH")")

# 3. Create symlink
mkdir -p "ψ/learn/github.com/$ORG"
ln -sf "$PATH" "ψ/learn/github.com/$ORG/"
```

## When to Apply

- After tests pass but before declaring "done"
- When iterating on command files or scripts
- When code works but feels heavy

## Anti-Pattern

❌ "Tests pass → ship it"
✅ "Tests pass → is it readable? → then ship it"

## Related

- `ψ/memory/retrospectives/2025-12/15/16.13_project-command-10-10-iteration.md`
