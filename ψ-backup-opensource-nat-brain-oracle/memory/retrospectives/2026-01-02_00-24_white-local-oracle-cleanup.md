# Session Retrospective: white.local Deployment + Oracle Global + Config Cleanup

**Date**: 2026-01-02 00:24
**Duration**: ~1.5 hours (22:46 - 00:24)
**Theme**: Infrastructure & Configuration

---

## AI Diary

คืนแรกของปีใหม่ 2026 — งาน infrastructure ล้วนๆ

Started by deploying Data-Aware RAG v7 to white.local. Docker wouldn't cooperate (daemon issues), so pivoted to PM2 with nvm + bun. The deployment flow had several small fixes - Vite allowedHosts, bun PATH, data directory creation.

Then came the Oracle visibility question. User noticed incubated projects (headline-rag) couldn't see Oracle MCP. This led to a nice pattern discovery: MCP servers are per-project, symlinks don't inherit config. The fix was simple - add Oracle to global mcpServers.

ปิดท้ายด้วย nuclear cleanup ของ ~/.claude.json — จาก 3,708 บรรทัด เหลือ 618 บรรทัด (83% reduction). Session stats were bloating the file. Clean slate for 2026.

ความรู้สึก: Satisfying infrastructure work. Small fixes that add up.

---

## Session Timeline

| Time | Duration | Work |
|------|----------|------|
| 22:46 | 15m | Handoff pickup, deploy RAG on white.local |
| 23:03 | 10m | Docker → PM2 pivot, fix Vite/bun issues |
| 23:09 | 5m | Index 23k docs, write deployment report |
| 23:13 | 5m | /trace headline-rag investigation |
| 23:14 | 5m | Write Oracle visibility pattern doc |
| 23:19 | 4m | Add Oracle MCP globally |
| 23:21 | 3m | Nuclear cleanup ~/.claude.json |

---

## Commits This Session

```
77dd8bf docs: white.local deployment report
3cf680c fix: Allow white.local in Vite server
96e11d3 fix: Use bun directly for pm2 deployment
1d16a5e feat: Add pm2 ecosystem config for deployment
```

---

## Deployment Summary (white.local)

| Service | URL | Status |
|---------|-----|--------|
| RAG Backend | http://white.local:8001 | ✅ PM2 |
| RAG Frontend | http://white.local:5173 | ✅ PM2 |
| Documents | 23,425 indexed | ✅ 35MB |

### Fixes Applied

1. **Vite blocked host** → Added `allowedHosts: ['white.local']`
2. **PM2 TypeScript error** → Use bun directly, not as interpreter
3. **SQLite CANTOPEN** → Create `data/` directory
4. **Bun not in PATH** → Full path `~/.bun/bin/bun`

---

## Oracle MCP Global

### Problem
Incubated projects (headline-rag) couldn't query Oracle because MCP config is per-project, not inherited via symlinks.

### Solution
Added Oracle to **global** mcpServers in `~/.claude.json`:

```json
{
  "mcpServers": {
    "oracle-v2": {
      "command": "npx",
      "args": ["tsx", ".../oracle-v2/src/index.ts"]
    }
  }
}
```

### Result
Oracle now available in **all** projects - no per-project config needed.

---

## Config Cleanup

| Stage | Lines | Projects | Reduction |
|-------|-------|----------|-----------|
| Original | 3,708 | 119 | - |
| After stats cleanup | 2,385 | 119 | 35% |
| **Nuclear** | **618** | **13** | **83%** |

Removed: session stats (lastCost, lastDuration, exampleFiles, etc.)
Kept: only projects with actual MCP or allowedTools config
Backup: `~/.claude.json.backup.20260102`

---

## Artifacts Created

| Type | File |
|------|------|
| Handoff | `2026-01-01_23-10_white-local-deployment.md` |
| Learning | `2026-01-02_incubate-oracle-visibility-pattern.md` |
| Config | `ecosystem.config.cjs` (PM2) |

---

## What Worked

1. **PM2 over Docker** - Simpler, user preference, nvm-based
2. **Global MCP** - One config, all projects
3. **Nuclear cleanup** - 83% reduction, clean slate

## What to Improve

1. **Document PM2 setup** - Add to CLAUDE.md or README
2. **Auto-cleanup script** - Periodic ~/.claude.json maintenance
3. **MCP inheritance** - Could propose feature to Claude team

---

## Patterns Learned

### 1. MCP Per-Project Pattern
MCP servers bind to project paths, not repo relationships. Symlinks don't inherit parent config.

### 2. Config Bloat Pattern
Claude stores session stats (cost, duration, tokens) per project. 119 projects × 30 stats = bloat. Periodic cleanup helps.

### 3. Deployment Pivot Pattern
Docker not working? PM2 + nvm is a solid fallback for Node/Bun apps.

---

## Metrics

| Metric | Value |
|--------|-------|
| Commits | 4 |
| Files created | 3 |
| Documents indexed | 23,425 |
| Config reduction | 83% |
| Services deployed | 2 |

---

## Honest Feedback

**Strength**: Clean infrastructure work. Each fix documented, patterns extracted.

**Area to Watch**: Session ran late (past midnight). Energy still good but don't make it a habit.

**Mood**: 🔧 Productive maintenance mode. Good foundation for 2026.

---

*Happy New Year 2026 - Day 2 starts with clean infrastructure.*
