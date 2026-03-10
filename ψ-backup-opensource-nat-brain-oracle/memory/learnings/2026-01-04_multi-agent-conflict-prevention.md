# Multi-Agent Conflict Prevention

**Date**: 2026-01-04

## What We Learned

Three sources of merge conflicts in multi-agent workflows - and how to fix them.

### 1. statusline.json → Gitignore

**Problem**: Each agent has different session data (session_id, context usage)
**Fix**: Add to .gitignore - each agent keeps local copy
```
ψ/active/statusline.json
**/ψ/active/statusline.json
```

### 2. focus.md → Per-Agent Files

**Problem**: Shared focus.md causes stale data + conflicts
**Fix**: Per-agent files (tracked, one writer per file)
```
focus-agent-main.md  ← Main writes here
focus-agent-1.md     ← Agent 1 writes here
focus-agent-2.md     ← Agent 2 writes here
```

### 3. .agents/ → Track in Git

**Problem**: MAW scripts local only, not backed up
**Fix**: Remove from .gitignore, track the toolkit
- All agents share same scripts (single source of truth)
- Version history for fixes
- Backup infrastructure

## The Pattern

| File Type | Strategy | Why |
|-----------|----------|-----|
| Session-specific (statusline) | Gitignore | Different per agent |
| Task focus | Per-agent files | One writer, no conflicts |
| Shared tooling (.agents) | Track in git | Single source of truth |

## How Things Connect

- `maw sync` now runs clean (no conflicts)
- `maw peek` shows correct per-agent tasks
- All agents share fixed scripts automatically
- Oracle notified of all patterns

## Tags

`multi-agent` `git` `conflict` `maw` `sync` `infrastructure`
