---
title: "DustBoy Streamlit Dashboard + Oracle Discovery"
date: 2026-01-02 02:04
duration: ~2.5 hours (continued from previous session)
context_at_end: 95%
mood: productive
---

# Session Retrospective

## What We Built

### 1. Multi-page Streamlit Dashboard
- `app.py` + 4 pages for sensor exploration
- Overview, Sensor Explorer, Data Validity, Model Comparison
- Expandable sections with Plotly charts

### 2. Pre-calculation Script
- `precalculate.py` - aggregate once, load fast
- NOT YET RUN (interrupted)

### 3. Ralph-Local Bug Fix
- **Problem**: Hook output leaking across git worktrees
- **Root cause**: Relative path `.claude/ralph-loop.local.md`
- **Fix**: Changed to `${CLAUDE_PROJECT_DIR}/.claude/ralph-loop.local.md`
- **PR #88**: Merged to main

### 4. Oracle Discovery
- Location: `ψ/lab/oracle-v2/`
- HTTP server: `localhost:37778`
- Shared across all agents
- 4,670 documents indexed

### 5. CLAUDE.md for DustBoy
- Documented WHITE server usage
- tmux + DuckDB CLI pattern for long queries
- LAN: `white.local`, Remote: `floodboy-white4.alchemycat.org`

## Key Learnings

1. **Pre-calculate for static data** - Historical data doesn't change, aggregate once
2. **WHITE for heavy queries** - More RAM, use tmux for multi-hour queries
3. **Hook isolation** - Always use `$CLAUDE_PROJECT_DIR` for worktree-specific files
4. **Oracle is shared** - All agents read/write same knowledge base

## What's Pending

- [ ] Run `precalculate.py`
- [ ] Update Streamlit to use `precalc/*.parquet`
- [ ] All sensors visualization (DuckDB CLI + precalc)
- [ ] Push main's cleanup commit

## Technical Wins

| Task | Result |
|------|--------|
| Dashboard | 4-page Streamlit with expandable sections |
| Bug fix | PR #88 merged (ralph-local isolation) |
| Documentation | CLAUDE.md + Oracle learning added |
| Handoffs | 3 handoff files created |

## AI Diary

Good debugging session on the ralph-local hook leak. The issue was subtle - relative paths work fine in single-worktree setups but break when you have multiple worktrees all using the same plugin. The fix was simple but required tracing through the hook system to understand.

Oracle is more integrated than I realized - it's truly a shared brain across all agents. The 4,670 documents are a significant knowledge base built up over time.

The user's preference for WHITE server for long queries makes sense - dedicated hardware with more RAM means complex aggregations won't OOM.

## Next Session

1. Run precalculate.py on local 7.6GB data
2. Create all-sensors-by-model visualization
3. Consider deploying Streamlit to WHITE for shared access

---
🤖 Generated with Claude Code
