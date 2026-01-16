# Session: Statusline Shared Context

**Date**: 2025-12-29 15:08-15:16
**Duration**: ~8 minutes
**Energy**: 🔥 High

## Summary

Built shared AI context system using statusline data.

## Timeline

| Time | Topic |
|------|-------|
| 15:08 | Found custom statusline at `~/.claude/statusline-command.sh` |
| 15:11 | Added JSON export to `ψ/active/statusline.json` |
| 15:12 | Confirmed multi-agent separation (each worktree = own file) |
| 15:14 | Added token warning hooks to UserPromptSubmit |

## What Was Built

| File | Purpose |
|------|---------|
| `~/.claude/statusline-command.sh` | Now writes JSON to project |
| `ψ/active/statusline.json` | Shared context (session, tokens, cost) |
| `.claude/scripts/tokens.sh` | Manual token check |
| `.claude/scripts/token-check.sh` | Auto-warning in prompt hook |
| `ψ/memory/learnings/workflow/2025-12-29_statusline-json-shared-context.md` | Documentation |

## Token Warning Thresholds

| Usage | Action |
|-------|--------|
| < 50% | Silent |
| 50-69% | `📊 Context X%` |
| 70-84% | `⚡ Context X% - Run /ccc soon` |
| ≥ 85% | `⚠️ CONTEXT X% - Consider /ccc or handoff NOW` |

## Key Insight

Statusline JSON = bridge between Claude internals and shared AI context. Now both human and AI can see token usage, session cost, and know when to /ccc.

---

**Next**: Test the warning thresholds in a long session.
