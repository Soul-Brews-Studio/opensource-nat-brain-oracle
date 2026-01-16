---
title: **Bash Multi-Command Pattern: Proper Chaining**
tags: [bash, shell, error-handling, tool-usage]
created: 2026-01-08
source: Session 2026-01-08 exit code trace
---

# **Bash Multi-Command Pattern: Proper Chaining**

**Bash Multi-Command Pattern: Proper Chaining**

When combining multiple commands in one Bash call:

**Problematic pattern** (newlines without chaining):
```bash
echo "=== A ===" && command1
echo ""
echo "=== B ===" && command2
```
Issue: Exit code unpredictable, potential parsing issues.

**Safe pattern** (explicit chaining):
```bash
echo "=== A ===" && \
  command1 && \
echo "" && \
echo "=== B ===" && \
  command2
```

Benefits:
- Exit code predictable (fails on first error)
- No newline parsing ambiguity
- Backslash continuation is explicit

**Key insight**: Multi-line bash in tool calls needs explicit `&&` chaining or backslash continuation.

---
*Added via Oracle Learn*
