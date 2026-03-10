# Inbox — Distilled

> Distilled from 43 files across inbox/{daily,external,handoff,templates,tracks,weekly,workflow}
> Source: ψ-backup-opensource-nat-brain-oracle/inbox/
> Date: 2026-03-11

---

## Structure Overview

The inbox was a communication hub ("คุยกับใคร?") with focus tracking, handoffs, daily notes, project tracks, templates, and workflow logs.

---

## Focus & Agent State (7 files)

Multi-agent focus tracking system. At time of backup:

| Agent | State | Task |
|-------|-------|------|
| main | completed | Oracle 3D Graph visualization with KlakMath patterns |
| agent-3 | working | Facebook posting history analysis |
| focus.md | jumped | workshop-context-finder (Track 009) |
| agents 1,2,4,5 | idle | - |

---

## Daily Notes (5 files)

Sparse daily logs (Dec 2025 - Jan 2026). Only 2025-12-18 had content:
- Schedule: arm massage, dinner at Nagiya Kad Luang
- Tasks: Watch Bangkok Meetup FB Live, create FB Page for AI content, set up ManyChat auto-reply, create waiting list
- Other dates (12/23, 12/26, 12/27, 01/07): empty templates only

---

## External (1 file)

**2025-12-20 Claude Code CNX Meetup** — Placeholder template for Chiang Mai meetup notes (09:45-12:30). Fields for attendees, discussions, MAW relevance, follow-ups. Never filled in.

---

## Handoffs (5 files + 1 log)

### 2026-01-15 10:02 — Oracle-v2 Open Source Ready
- Removed all hardcoded `/Users/nat/` paths from oracle-v2
- Port migration 37778 to 47778
- npm publish infra: `@laris-co/oracle-v2` with auto-publish workflow
- Archived 42 old handoff files
- Distribution strategy: GitHub now, npm soon, MCP Registry later
- Pending: NPM_TOKEN secret, MISSION-05 push, MCP Registry submission

### 2026-01-15 18:57 — /hours Skill + Plugin Trace
- Restored `/hours` command with work hours detection
- 38 days tracked: 396.1h total, 10.4h avg/day, 1,692 commits
- 5 parallel Haiku agents traced plugin architecture
- Found 11 registered marketplaces, documented nat-agents-core v1.10.0
- Pending: Soul-Brews MCP Marketplace repo, npm publish, `/rrr --deep`

### 2026-01-16 10:28 — /physical Skill Not Working
- Created work pattern analysis (39 days, 399.5h, intensity formula)
- Changed context limit 180k to 160k (80% of 200k)
- Restored `/physical` skill from git history but symlink not detected
- Bug: Claude Code doesn't follow symlinks for skill discovery
- Gist: https://gist.github.com/nazt/b0576a0902594c7a45ec32dfb36752f2

### 2026-01-16 11:55 — /learn Skill + HTML5 Game
- Fixed `/physical` (symlink to real directory) and `/draft` (case-sensitive SKILL.md)
- Blog draft: "The Skill That Saved Itself"
- /learn skill iterated 3x, user wanted revert to verbose version
- Next: HTML5 2D game (raw canvas, no framework)

### 2026-01-16 12:22 — Pluto Game Iteration 2
- HTML5 2D physics digging game (614 lines, single file)
- Spring-based scoop, gems/bombs, 5 rounds with score
- Repo: https://github.com/Soul-Brews-Studio/pluto
- Issues: items fall through scoop, no sound, O(n^2) collision
- Key formula: `vel += (target - pos) * spring; vel *= damping`

### Handoff Log (auto-appended at 97%+ context)
- 2026-01-14: Oracle 3D Graph, port migration docs
- 2026-01-15: rrr skill fix, handoff consolidation, oracle-v2 open source, MCP marketplace discovery
- Distribution decision: Skip npm public, use `bunx github:laris-co/oracle-v2`

---

## Tracks — Active (5 files)

### 008 — Gemini Proxy (Complete, v1.5.3)
Chrome extension: Claude Code to Gemini via MQTT. Full chat workflow with smart response detection. Actions: click, type, key, wait_response, screenshot, etc. Repo: laris-co/claude-browser-proxy.

### 009 — Workshop Context-Finder
Reframed as "Build Your Own Oracle" workshop. Evidence: 50% of subagent commands use context-finder, 95% cost reduction. Tiers: Core 3h ($500), Advanced 5h ($1200), Enterprise 2d (custom). Marketing: "Stop Paying Opus Prices for Haiku Work". Status: validation phase.

### 011 — Bun Process Manager
Standalone ProcessManager forked from claude-mem. PID management, health monitoring, graceful shutdown. Repo: laris-co/bun-process-manager. Pending: npm/jsr publish.

### 013 — Oracle-v2 Trace & Activity
Implement Issues #17 (Trace Log) and #18 (Activity Index). Tools: oracle_trace, oracle_trace_list, oracle_trace_dig, oracle_trace_chain, oracle_trace_distill, oracle_activity. Start with trace_log schema.

### 014 — Arthur Birth (Oracle Extension)
First named child Oracle for headline news. Discovered "Recursive Reincarnation Pattern": Oracle = philosophy, MCP = nervous system, Arthur = first child. Steps: incubate headline-rag, /awaken, /soul-lite, create CLAUDE.md. Key insight: "Arthur doesn't LEAVE Oracle. Arthur EXTENDS Oracle."

### Project Manager Skill
Lifecycle commands: /project create, incubate, spinoff, reunion, list, status, link. Manages repos through seed/grow/graduate/reunion phases. Uses `ghq` for cloning, `ψ/incubate/` for active work.

---

## Tracks — Archived (5 files)

### 001 — MAW Merge (Cooling)
`maw merge` command for agent-to-main merging. Known issues: uncommitted changes, merge conflicts, no dry-run.

### 002 — Garmin Data Analysis (Cooling)
Private repo laris-co/nat-garmin-data. 185 files from Garmin export, DuckDB queries. Finding: sleep improved ~1h after 2020. Pending: Streamlit dashboard.

### 003 — Ultra-Lean CLAUDE.md (Cooling)
Restructure CLAUDE.md to ~500 tokens (Issue #57). Pattern: rules + pointers only, details in `.claude/commands/*.md`.

### 004 — Tracks System (Completed)
Replaced single WIP.md with multi-track parallel system. `/jump` creates/switches tracks, `/tracks` shows decay status (Hot/Warm/Cooling/Cold/Dormant).

### 006 — Oracle v2 (Complete)
Both speckits finished (65/65 tasks). Hybrid search (FTS5 + ChromaDB), MCP tools, HTTP server, Web UI. PR #67 ready.

---

## Templates (2 files)

**Daily template**: Schedule table, tasks checklist, notes, feelings, nav links.
**Weekly template**: Week dates, goals (top 3), daily highlights table, retrospective, next week section.

---

## Workflow (1 file)

Chat log from 2025-12-15: 5 parallel agents explored repo structure, commands, subagents, workflows, and philosophy. Produced comprehensive map of the 7-pillar psi brain system.

---

## Design & Recap (2 files)

**Hybrid Recap Summary**: 9 iterations evolving from simple `/recap` to layered "Feeling + Thinking + Doing" model. Final design: Human Feeling (emoji mood), Oracle Thinking (AI pattern analysis), Doing (commits/files/tracks).

**Design Recap Agent 9**: Detailed hybrid-approach proposal combining Tier-1/2/3 data layout with emotional feeling layer. Output spec with context summary, files in motion, git state.

---

## Misc (3 files)

- **jot.md**: Quick capture pad (empty at backup)
- **jump-stack.log.backup**: Navigation history — jumps between tasks like skill development, beer brewing, MAW profile setup
- **CLAUDE.md / weekly CLAUDE.md / tracks CLAUDE.md / archived CLAUDE.md / handoff CLAUDE.md**: Auto-generated claude-mem context headers, all showing "No recent activity"
