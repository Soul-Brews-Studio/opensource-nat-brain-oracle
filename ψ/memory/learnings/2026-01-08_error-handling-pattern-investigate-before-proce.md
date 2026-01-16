---
title: **Error Handling Pattern: Investigate Before Proceeding**
tags: [error-handling, bash, debugging, oracle-consult]
created: 2026-01-08
source: Session 2026-01-08 exit code investigation
---

# **Error Handling Pattern: Investigate Before Proceeding**

**Error Handling Pattern: Investigate Before Proceeding**

When bash command shows "Exit code 1" but output looks correct:

1. **Don't ignore** - The error might indicate a real issue
2. **Investigate** - Run commands separately to isolate
3. **Check Oracle** - Search for similar errors
4. **Report** - Log the finding whether real or false positive

Common causes of "exit 1 with correct output":
- Pipe to `head` can cause SIGPIPE (141) misreported as 1
- `xargs` propagates child exit codes
- Combined commands (`&&` chains) fail on any step
- Transient file system issues

**Anti-pattern**: Seeing error, output looks fine, proceeding without investigation.

**Correct pattern**: Error shown → Investigate → Oracle search → Fix or document

---
*Added via Oracle Learn*
