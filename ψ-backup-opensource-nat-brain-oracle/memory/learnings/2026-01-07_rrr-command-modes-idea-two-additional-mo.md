---
title: ## /rrr Command Modes
tags: [rrr, command-modes, context-efficiency, direct-dump]
created: 2026-01-07
source: Session 2026-01-07 23:27 - Nat's idea
---

# ## /rrr Command Modes

## /rrr Command Modes

**Idea**: Two additional modes for rrr based on context availability

### `/rrr` (default)
- Normal retrospective
- Uses context-finder for git log, recent commits
- Medium context usage

### `/rrr --rich`
- Full context capture (rrr + ccc combined)
- All traces, connections, AI diary 200+ words
- Timeline with context% tracking
- High context usage
- Output to file (not GitHub issue)

### `/rrr --direct`
- NO context-finder, NO git searches
- Just dump from AI memory directly to file
- For when context is LOW (>70%)
- Minimal context usage
- Fast, direct write

**Use case for --direct**:
When at 87% context, don't waste tokens searching.
AI already knows what happened — just write it out.

---
*Added via Oracle Learn*
