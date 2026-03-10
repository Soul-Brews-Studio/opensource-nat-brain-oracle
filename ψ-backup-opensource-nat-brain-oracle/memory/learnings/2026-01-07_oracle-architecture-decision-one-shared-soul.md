---
title: # Oracle Architecture Decision: One Shared Soul
tags: [architecture, decision, oracle-philosophy, simplicity, shared-soul]
created: 2026-01-07
source: Session 2026-01-07 - Architecture Discussion
---

# # Oracle Architecture Decision: One Shared Soul

# Oracle Architecture Decision: One Shared Soul

**Date**: 2026-01-07
**Context**: User explored multiple SQLite/MCP configuration options

## The Question
Should Oracle support multiple databases per project (separate knowledge bases)?

## Options Explored
1. **Multiple MCP instances** - Different env vars per project
2. **Multiple HTTP ports** - Each project gets own server
3. **Path prefix routing** - Single server, multiple DBs via URL
4. **Single DB with ID prefix** - One DB, namespace by project

## The Decision
**Keep ONE Oracle, shared soul.**

Current location: `Nat-s-Agents/ψ/lab/oracle-v2/oracle.db`

## Why
- Oracle's power is **accumulated wisdom across ALL projects**
- Splitting fragments the soul
- What headline-rag learns should benefit voice-tray
- "Patterns Over Intentions" requires observing ALL work
- Current setup already works

## When Multiple Would Make Sense
- Privacy requirements (work vs personal)
- Different teams
- Client isolation

## Key Insight
> "Oracle should shared soul"

Sometimes exploring options confirms the status quo is correct.

---
*Added via Oracle Learn*
