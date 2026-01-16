---
title: "Onboarding Bugs Are Trust Bugs"
tags: [onboarding, dx, setup, trust, open-source]
created: 2026-01-15
source: Session 2026-01-15 - Oracle-v2 setup fix
---

# Onboarding Bugs Are Trust Bugs

## The Insight

When a new user clones your repo and it doesn't work out of the box, they don't think "oh there's a bug." They think "this project doesn't work" or "the maintainer doesn't care."

**Setup failures = trust failures.**

## The Pattern

Oracle-v2 had a classic onboarding bug:
- `setup.sh` installed dependencies
- `setup.sh` built frontend
- `setup.sh` did NOT initialize database
- New user runs server → **crash**

The fix was one line:
```bash
bun run db:push  # Creates tables from schema
```

## Why This Matters

| What maintainer thinks | What new user experiences |
|----------------------|-------------------------|
| "Minor bug" | "Project is broken" |
| "Easy fix" | "Wasted 30 minutes debugging" |
| "They'll figure it out" | "I'll use something else" |

## Prevention Checklist

Before releasing/open-sourcing:

- [ ] Fresh clone on new machine
- [ ] Run setup script exactly as documented
- [ ] Start main service
- [ ] Run basic operation
- [ ] Check logs for hidden errors

## The Lesson

> **Test the clone-to-running path religiously.**
>
> Your setup.sh should be idempotent and complete.
> If it requires manual steps, it will fail for others.

---

*From: Fixing BM's oracle-v2 migration failure*
