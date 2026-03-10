# Memory Archive — Distilled

> Distilled from `memory/archive/handoffs/` (36 handoff files) + remaining `memory/retrospectives/` individual files
> Covers: 2025-12-11 to 2026-01-15
> Distilled: 2026-03-11

---

## Overview

The archive contains session handoffs documenting the evolution of the Oracle system from initial concept through production deployment. These handoffs served as inter-session continuity documents, passing context between Claude sessions.

---

## December 2025 Handoffs (32 files)

### Dec 11 — Local AI Pitch + Agent SDK (2 files)

- **Urgent**: Local AI pitch deadline (Dec 12 submit, Dec 16 present at Chiang Mai University)
- Demo story: AI built system in 96 minutes (human 15 min vision, AI 81 min execution), 1,517 lines, 7 APIs
- Agent SDK learning lab paused at POC score 78/120
- Skills marketplace structure: GitHub API for commands, Haiku for reading
- Key message: "Human lets go, AI works"

### Dec 17 — MAW Deep Dive + Philosophy Feeding (2 files)

- **Iteration 2**: MAW (Multi-Agent Workflow) deep dive — agent worktrees, parallel execution
- Philosophy feeding session: Oracle principles documentation
- 5 agents coordinated via tmux, focus.md as shared context

### Dec 28 — MAW + Migration (2 files)

- MAW lazy loading implementation for performance
- Ultra-lean migration: reducing Oracle footprint for portability
- Moved from heavy plugin architecture to lightweight approach

### Dec 29 — Pattern Archaeology + Statusline (2 files)

- Pattern archaeology: tracing Oracle patterns back to original Weyermann repo (166 commits, 82 issues)
- Statusline shared context: building shared awareness across sessions

### Dec 30 — Intensive Sprint Day (7 files)

- Oracle list + speckit complete (08:39)
- Arthur voice UI handoff (11:02) — voice interface for advisor's AI assistant
- Context awareness session (11:45)
- Spec050 complete (12:38) — specification system
- MAW see profile15 (14:45), MAW all-claude (14:53), MAW smooth sprint (15:30)
- Ralph handoff testing (16:27)
- Intensive parallel development across oracle-v2, Arthur, MAW

### Dec 31 — Marathon Close (14 files)

- MCP memory analysis (06:24) — evaluating MCP for Oracle memory
- Handoff MCP complete (06:56) — MCP integration done
- Speckit mastery + Oracle fix (07:27)
- Handoff MCP v4 complete (09:42) — fourth iteration of MCP handoff
- Practice ready/complete (09:44, 10:10) — workshop preparation
- Session timer complete (10:00)
- Claude-mem install check (10:09)
- FB RAG complete (11:15) — Facebook data RAG integration
- Long run practice/complete (11:55, 12:16) — endurance testing
- Final handoff + final (12:34, 12:40) — year-end wrap
- White local setup (12:40) — local development environment
- Arthur demo ready/complete (13:28, 13:35) — demo for advisor
- Trace ESPHome data question (22:32) — IoT exploration

---

## January 2026 Handoffs (3 files)

### Jan 14 — Port Migration + Hand Tracker (2 files)

- **Morning**: Fixed `/physical` time bug, closed 4 issues (#90, #92, #94, #103)
- Port migration: all services 37778 to 47778 (oracle-v2, oracle-status-tray)
- Auto-handoff improvement: append to single file, 1/hour rate limit
- **Afternoon**: Hand tracker Rust app with camera capture (640x480), gesture detection (fist=zoom, open=zoom out)
- MQTT publishing to `hand/position`, ~30 FPS achieved
- Limitation: skin detection catches face + hand (no ML model for hand-only)
- Session done partly via voice commands from car

### Jan 15 — Oracle-v2 CI (1 file)

- Critical fix: `setup.sh` missing `db:push` for fresh clones
- Integration tests: database (17), HTTP (~30), MCP (~15)
- GitHub Actions CI: unit tests (92) + database integration (17)
- MISSION-05 Oracle v2 POC created

---

## Remaining Retrospectives (individual files not in day-subdirectories)

### December 2025 (10 files)

| Date | Session | Key Outcome |
|------|---------|-------------|
| Dec 17 | Agent 3 peek & sync | `maw peek` table format (71 lines to 8), direnv exec pattern |
| Dec 20 | MAW wait & conflict fix | focus.md conflict prevention (3-layer), `maw wait` command, trials 9-11 (9.6-10/10) |
| Dec 20 | MAW demo command | `/maw-demo` command for multi-agent workflow demonstration |
| Dec 20 | Trial 15 MAW dashboard | Dashboard for monitoring multi-agent trials |
| Dec 20 | Trials 11-14 portfolio demo | Portfolio demo using MAW, high success rates |
| Dec 27 | Garmin data analysis | Health/fitness data analysis from Garmin device |
| Dec 27 | Global safety hooks (2 files) | Safety hooks for preventing destructive operations |
| Dec 27 | Obsidian vault setup | Obsidian integration for knowledge management |
| Dec 31 | Trace ESPHome exploration | IoT device configuration exploration |

### January 2026 (23 files + 8 in 01/ + 6 in 2026/01/)

| Date | Session | Key Outcome |
|------|---------|-------------|
| Jan 1 | Data-aware RAG charts | UI/UX testing, Playwright, PR #84 merged |
| Jan 1 | Data-aware RAG v2-v7 marathon | Multi-version iteration of RAG system |
| Jan 1 | White DuckDB thesis | DuckDB for PhD thesis data analysis |
| Jan 2 | White local Oracle cleanup | Local Oracle environment cleanup |
| Jan 2 | Self-hosted runner setup | GitHub Actions self-hosted runner |
| Jan 2 | Final session | Day wrap-up |
| Jan 2 | Oracle ecosystem complete | Ecosystem visualization/documentation |
| Jan 2 | Oracle ecosystem migration philosophy | Migration philosophy documentation |
| Jan 2 | InfluxDB export (2 files in 01/) | InfluxDB 2024 data export sessions |
| Jan 2 | Dagster push continuation (01/) | Pipeline deployment continuation |
| Jan 3 | Nat deep research | Personal/professional research session |
| Jan 3 | Trace working style | Analyzing work patterns via traces |
| Jan 3 | Session UUID discovery | UUID-based session tracking |
| Jan 3 | Philosophy evolution timeline | Timeline of Oracle philosophy development |
| Jan 4 | Oracle tools hooks session | Tooling and hooks development |
| Jan 4 | Multi-agent forum breakthrough | Forum-based agent coordination |
| Jan 4 | Pure MCP breakthrough (2 files) | MCP-only architecture discovery |
| Jan 4 | Infrastructure fixes | System maintenance and fixes |
| Jan 4 | TingTing course design | Course design session |
| Jan 4 | Full session wrap | Day wrap with data summary |
| Jan 4 | Next actions + session data summary | Planning and metrics |
| Jan 4 | DustBoy spinoff (01/) | DustBoy project independence |
| Jan 4 | Oracle forum coordination (01/) | Multi-oracle coordination patterns |
| Jan 4 | Session close (01/) | Final session wrap |
| Jan 10 | Oracle origin story timeline | Historical timeline of Oracle system |

### DustBoy-specific (6 files in 2026/01/)

| Date | Session | Key Outcome |
|------|---------|-------------|
| Jan 1 | DustBoy data pipeline | Data pipeline for PM2.5 sensor data |
| Jan 1 | DustBoy PhD thesis | Academic work on air quality |
| Jan 2 | DustBoy Streamlit Oracle | Streamlit dashboard for DustBoy data |
| Jan 2 | DustBoy model cleanup | ML model organization |
| Jan 2 | DustBoy all sensors dashboard | Multi-sensor visualization |
| Jan 2 | PhD data pipeline complete | Pipeline completion for thesis |

---

## Key Patterns Across All Handoffs

1. **Velocity**: Dec 30-31 and Jan 1-4 saw the highest density of handoffs (20+ files per day cluster)
2. **Multi-stream work**: Oracle v2, Arthur, MAW, DustBoy, and workshop preparation ran in parallel
3. **Philosophy-first**: Technical work consistently grounded in Oracle principles
4. **Handoff quality improved over time**: Early handoffs were detailed but unstructured; later ones followed consistent templates
5. **Port migration 37778 to 47778**: Ecosystem-wide infrastructure change in January

---

*Distilled from 36 archive handoffs + 47 individual retrospective files*
*Source directories: `memory/archive/`, `memory/retrospectives/` (non-distilled individual files)*
