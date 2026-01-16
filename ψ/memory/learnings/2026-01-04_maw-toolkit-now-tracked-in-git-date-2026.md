---
title: ## MAW Toolkit Now Tracked in Git
tags: [maw, git, tracking, infrastructure, multi-agent, toolkit]
created: 2026-01-04
source: 2026-01-04 Session - MAW tracking fix
---

# ## MAW Toolkit Now Tracked in Git

## MAW Toolkit Now Tracked in Git

**Date**: 2026-01-04

The `.agents/` folder (Multi-Agent Workflow toolkit) is now version controlled.

### What's Tracked
- 37 scripts (peek, hey, sync, start, kill, etc.)
- Agent configs (agents.yaml)
- Launch profiles (profile0-14)
- Shell completions (bash/zsh)

### Why Track It
- Backup infrastructure
- Version history for fixes
- Share across machines
- All agents share same scripts (single source of truth)

### Key Fix Included
`peek.sh` updated to read per-agent focus files:
- `focus-agent-main.md` instead of shared `focus.md`
- No more stale task data
- No merge conflicts

### Architecture
```
.agents/           ← Only in main repo
agents/1/          ← Worktree (no .agents)
agents/2/          ← Worktree (no .agents)
```
All agents source from main's .agents/

---
*Added via Oracle Learn*
