---
title: ## Debug Pattern: Binary Search for Broken Files
tags: [debugging, binary-search, isolation, claude-code]
created: 2026-01-08
source: debugging session 2026-01-08
---

# ## Debug Pattern: Binary Search for Broken Files

## Debug Pattern: Binary Search for Broken Files

When Claude Code crashes on startup/autocomplete with cryptic error:

**Pattern:**
1. **Isolate** - Move ALL suspect files to backup
2. **Verify** - Confirm error gone
3. **Batch restore** - Bring back 3-5 folders at a time
4. **Binary search** - If breaks, narrow down which folder
5. **Single file** - Test one file at a time
6. **Inspect** - Find the bad syntax

**This session's finding:**
- Error: `$.description.split is not a function`
- Location: `~/.claude/skills/trace-finder/SKILL.md`
- Cause: `description: [TODO:...]` - brackets parsed as YAML array
- Fix: Use plain string, no brackets

**Time saved:** Systematic approach vs random guessing

---
*Added via Oracle Learn*
