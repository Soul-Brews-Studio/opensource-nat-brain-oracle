---
title: ## MISSION-02 Creation - From Real Bug to Squad Challenge
tags: [mission-02, parser-bug, debugging, binary-search, squad-challenge, yaml]
created: 2026-01-08
source: Session 2026-01-08
---

# ## MISSION-02 Creation - From Real Bug to Squad Challenge

## MISSION-02 Creation - From Real Bug to Squad Challenge

**Date**: 2026-01-08

### What Happened

Found a real Claude Code parser bug at 07:50, fixed by 08:34, turned into Squad Team challenge by 09:40.

### The Bug

```
TypeError: $.description.split is not a function
```

**Root Cause**: YAML interprets `[...]` as array syntax. When `description: [TODO: something]` is parsed, it becomes an array, and `.split()` fails on arrays.

### Debugging Methodology

1. **Failed attempts** (35 min wasted):
   - Fix 50+ files with frontmatter ❌
   - Disable plugins ❌
   - Clear cache ❌

2. **Breakthrough** - Complete isolation:
   - Move ALL files to backup → works!
   - Binary search: restore 3 folders at a time
   - Narrow down to single file
   - **10 minutes** from isolation to root cause

### Key Learning

> "Stop patching symptoms. Isolate completely first, then binary search."

### Challenge Created

- **Repo**: Soul-Brews-Studio/mission-02-parser-debug
- **Files**: 12 total (6 broken, 6 valid)
- **Scoring**: Stored in Oracle (secret)
- **Submission**: Via PR with SOLUTION.md

---
*Added via Oracle Learn*
