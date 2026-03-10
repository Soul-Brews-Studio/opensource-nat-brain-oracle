---
date: 2026-01-01
tags: [workflow, session, speckit, tasks, handoff]
context: Data-Aware RAG v2 - Effective session workflow
---

# Effective Session Workflow Pattern

## The Pattern

This session demonstrated an effective workflow for continuing work across sessions:

### 1. Read Handoff First
```bash
# Previous session context
cat ψ/inbox/handoff/latest.md
```

### 2. Check Tasks Status
```bash
# See what's done/pending
cat specs/PROJECT/tasks.md | grep -E '\[x\]|\[\~\]|\[ \]'
```

### 3. Update Tasks as You Work
- Mark `[x]` when complete
- Mark `[~]` when in progress
- Update progress summary at bottom

### 4. Test Before Claiming Done
```bash
# Verify CLI works
bun run cli stats --debug
bun run cli search "query" --debug

# Verify frontend builds
bun run frontend:build
```

### 5. Write Lesson Learned
Document:
- What was fixed
- How it was fixed
- What didn't work (anti-patterns)

### 6. Write Handoff at 95% Context
Include:
- What was done
- What's still pending
- Quick start commands

## Example Session Flow

```
1. Read handoff → Understand context
2. Check tasks.md → See Phase 1 CLI incomplete
3. Test existing code → CLI works!
4. Update tasks.md → Mark done items
5. Continue next task → Add page size selector
6. Test change → Frontend builds
7. Update tasks.md → Mark complete
8. Write lesson + handoff
```

## Key Behaviors

| Do | Don't |
|----|-------|
| Test before marking complete | Assume previous work is done |
| Update tasks.md incrementally | Wait until end to update |
| Write specific lessons | Write generic notes |
| Include quick start commands | Expect user to remember |

## Commands Used

```bash
# CLI
bun run cli stats --debug
bun run cli search "query" --limit 5 --debug
bun run cli serve

# Frontend
bun run frontend:dev
bun run frontend:build

# Dashboard
bun run dashboard
```

## Progress Tracking

Using checkboxes in tasks.md:
- `[ ]` = Not started
- `[~]` = In progress
- `[x]` = Completed with ✅

Update the progress summary table after changes.

## Lesson

> "Sessions that start by reading handoff and checking tasks are 10x more effective than sessions that start fresh."

The handoff + tasks.md combo provides complete context continuity.
