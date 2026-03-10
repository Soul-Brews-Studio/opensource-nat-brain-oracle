# Lab Experiments — Distilled Archive

> Distilled from `ψ-backup-opensource-nat-brain-oracle/lab/` (112 files, 36 subdirectories)
> Generated: 2026-03-11

---

## 1. Agent SDK Deep Dive

**Location was**: `lab/agent-sdk/`
**Status**: Complete (2025-12-11)
**Files**: 16

### Purpose
Deep reference and hands-on learning for Claude Agent SDK (`@anthropic-ai/claude-agent-sdk`). Covered v0.1.0 through v0.1.61.

### Key Findings
- **V2 API** (unstable): Simplified `send()`/`receive()` pattern replaces async generators. Multi-turn just calls `send()` again.
- **Sandboxing**: OS-level (Linux bubblewrap, macOS seatbelt). Reduces permission prompts by 84%.
- **Tool allowlists** (v0.1.57): `tools: ['Read', 'Glob', 'Grep']` for restricted agents; `tools: []` for pure reasoning.
- **1M context** (v0.1.58 beta): `betas: ['context-1m-2025-08-07']` on Sonnet 4/4.5.
- **Budget control** (v0.1.30): `--max-budget-usd` prevents runaway costs.

### Reusable Patterns

```typescript
// V2 one-shot
import { unstable_v2_prompt } from '@anthropic-ai/claude-agent-sdk'
const result = await unstable_v2_prompt('Hello', { model: 'claude-sonnet-4-5-20250929' })

// V2 session
await using session = unstable_v2_createSession({ model: 'claude-sonnet-4-5-20250929' })
await session.send('Hello!')
for await (const msg of session.receive()) { console.log(msg) }

// Tool configs
tools: { type: 'preset', preset: 'claude_code' }  // All tools
tools: ['Read', 'Glob', 'Grep']                    // Read-only
tools: []                                           // No tools
```

### Lab 001 Results
- Tested `query()` API, V2 session APIs, tool configurations
- 3 experiments, all passed after 3 iterations
- Cost: ~$0.16, Time: ~30 min
- Key learning: "Use ALLOWLIST in production (explicit > implicit)"

### Version Recommendations
- **Minimum production**: v0.1.30 (budget control + reliable hooks)
- **Recommended**: v0.1.45+ (structured outputs + Azure)
- **Advanced**: v0.1.57+ (tools allowlist + 1M context)

---

## 2. /recap Iteration 4 — Simplification Design

**Location was**: `lab/ITERATION_4_*.md`, `lab/recap-*.md`
**Status**: Design complete, ready for implementation
**Files**: 6

### Purpose
Simplify the `/recap` command from complex 6-point scoring to lean 2-point system.

### Key Changes (Iter 3 -> Iter 4)
| Aspect | Before | After |
|--------|--------|-------|
| Scoring | 3 factors, 9 values | 2 factors, 3 values (0, 2, 4) |
| States | 5 (working/focusing/pending/jumped/completed) | 3 (active/idle/done) |
| Output | 4 tiers + narrative | 2 tiers, compact table |
| Code | 120-150 lines | 60-80 lines |
| Read time | 30s | 15s |

### Core Scoring Algorithm
```python
score = 0
if age_minutes < 240: score += 2   # < 4 hours
if is_code_file(path): score += 2   # code or agent file
# 0 -> white, 2 -> yellow, 4 -> red
```

### Design Philosophy
"System shows facts, user decides" — removed blocker detection, narrative synthesis, and fine-grained scoring. Table format beats prose for quick decisions.

### Success Criteria
- Speed: < 20 seconds
- Read time: < 5 seconds
- Code: < 100 lines
- No false positives

---

## 3. Claude Code Features Testing

**Location was**: `lab/claude-code-features/`
**Status**: Complete (2025-12-11)
**Files**: 1

### Results
| Feature | Result | Key Finding |
|---------|--------|-------------|
| Skills | Pass | Model-invoked modular capabilities; load on-demand |
| /standup | Pass | Daily standup via context-finder (Haiku); token efficient |
| Explore subagent | Pass | Built-in Haiku read-only agent with thoroughness levels |
| Resume Agent | Pass | Remembers context across sessions; game-changer for research |

### Key Insight
Skills = reusable knowledge (model-invoked). Subagents = isolated workers (explicitly spawned). Different concepts.

---

## 4. GitHub Profile Analysis

**Location was**: `lab/github-profile-analysis/`, `lab/github-analysis/`
**Status**: Complete (2025-12-11)
**Files**: 2

### Subject: nazt (Nat)
- 500+ personal repos, 30+ organizations
- Polymath: IoT (30%), Blockchain (25%), AI/LLM (15%), Full-stack (15%)
- Languages: TypeScript, Python, C++, Go, JavaScript, Solidity
- Life phases: Maker (2015-2020) -> Blockchain (2021-22) -> Brewing (2022-24) -> AI/Oracle (2025+)

### Key Orgs
| Org | Purpose |
|-----|---------|
| laris-co | Primary workspace (100+ repos) |
| muskindex | Blockchain/DeFi (100+ repos) |
| cmmakerclub | Maker community (60+ repos) |
| Soul-Brews-* | Creative studio |
| DustBoy-* | IoT sensor ecosystem |

---

## 5. Handoff MCP (v1 -> v3 -> v4)

**Location was**: `lab/handoff-mcp/`, `lab/handoff-mcp-v3/`, `lab/handoff-mcp-v4/`
**Status**: Built (v1-v3), v4 started
**Files**: 5

### Purpose
MCP server for automatic session handoff management and context continuity.

### Architecture
- Tools: `handoff_create`, `handoff_read`, `handoff_search` (FTS5)
- Storage: Markdown files in `inbox/handoff/`, indexed by SQLite FTS5
- v3: Added Drizzle ORM for type-safe schema
- v4: Bun runtime rewrite

### Key Pattern
```
Session end -> handoff_create(done, pending, context)
Session start -> handoff_read(limit: 1) -> resume context
```

---

## 6. MAW Demo Kit (Multi-Agent Worktrees)

**Location was**: `lab/maw-demo/`
**Status**: Production ready (2025-12-20)
**Files**: 6

### Purpose
Demonstration kit for MAW parallel agent coordination system.

### Key Stats
- 5 agents working in parallel
- 153 files synced with 0 conflicts
- 60x faster than sequential (2 min vs 120+ min)
- Same token cost (100K review)

### Core Approach
- Locks prevent double-work
- Signals for coordination (100ms detection)
- Rebase-based sync (same hash = no conflicts)
- WIP commits as safety nets

### Why Rebase > Merge
"Merge creates unique merge commits with hidden conflicts. Rebase keeps same commit hash everywhere."

---

## 7. Oracle Command Refactor

**Location was**: `lab/oracle-command-refactor/`
**Status**: Spec complete (2025-12-29)
**Files**: 3

### Core Insight
"All documentation is fear management that became wisdom"

### The 6 Commands and Their Fears
| Command | Fear | Artifact |
|---------|------|----------|
| /jot | Forgetting | jot.md append |
| /snapshot | Lost patterns | learnings/*.md |
| rrr | Context loss | retrospectives/*.md |
| /jump | Context switching | track files (stack) |
| /tracks | Invisible work | time-decay view |
| nnn | Overconfidence | GitHub issue |

### Subagent Pattern
"Opus writes, Haiku gathers" — Haiku for stateless data collection, Opus for synthesis and quality.

---

## 8. DustBoy Confidence System (PhD Data)

**Location was**: `lab/dustboy-confidence-system/`
**Status**: Active analysis
**Files**: 4

### Purpose
Air quality analysis using DustBoy sensor network for PhD thesis.

### Data Scale
- 1.29B deduplicated records (2.6B raw), 2019-2024
- 1,355 sensors across 10 models
- 7.6GB local parquet, 88GB on WHITE server

### Key Findings
- PM2.5 dropped 55% between old and new datasets
- New indoor sensors (T4): median 4 ug/m3
- New GPS mobile sensors (Donaus): spatial tracking
- Zero sensor overlap between old/new (different hardware: Wplus vs TPlus)
- >1000 PM2.5 readings are mostly sensor errors

### Reusable Pattern
DuckDB + tmux on remote server for multi-hour queries. Split large DISTINCT exports by year.

---

## 9. Electrical Load Calculator

**Location was**: `lab/electrical-load-report/`
**Status**: Sample output (2026-01-04)
**Files**: 1

### Purpose
AI-generated electrical load calculation from building plans (PDF).

### Sample Output
- Project: HABI HOUSE residential
- Total connected load: 1,340W, demand load: 800W
- Generated BOQ, breaker sizing, single-line diagram
- 95% confidence from PDF plan reading

---

## 10. Facebook Embedder (RAG Pipeline)

**Location was**: `lab/fb-embedder/`
**Status**: ETL documented
**Files**: 3

### Pipeline
```
DuckDB (47k+ records) -> CSV extract -> Embeddings -> RAG web UI
```
- Sources: messages (10K sample), posts, comments
- Extract via DuckDB SQL with content length filters

---

## 11. Brewing Lab

**Location was**: `lab/brewing/`
**Status**: Active
**Files**: 4

### Batch 001: Snow Mash Wheat (2025-12-13)
- 67% wheat / 33% pilsner, 9kg total
- Issue: 9kg too much for 23L Snow Bank mash tun
- Lesson: 6kg is the right amount

### Brew-Think Poster
"Fermentation Time" design philosophy: treating time as primary medium, amber/indigo palette, vertical ascension, circular completion. Visual language of transformation and patience.

---

## 12. Concepts (Unproven Ideas)

**Location was**: `lab/concepts/`
**Files**: 3

### 001: Cross-Repo Context Forward
Forward context between repos via `gh issue create --repo B`. Challenges: 65K char limit, format for Claude, privacy.

### 002: Content Type Commands
User tells AI content type explicitly: `/feeling`, `/info`, `/idea`, `/jump`, `/incubate`. Reduces AI guessing. Uses note-taker (Haiku) agent.

---

## 13. Ideas Incubator

**Location was**: `lab/ideas/`
**Files**: 5

### Voice Bridge (2025-12-09)
Tauri desktop app: continuous voice listening -> local STT (Whisper/Vosk) -> SQLite -> inject into terminal via tmux send-keys. Goal: avoid AI transcription cost.

### Cellar (2025-12-09)
Flutter system tray app with local SQLite. "Beer cellar" for data: session logger, voice transcript store, task tracker. Native-only, no web.

### Oracle as Enterprise Alternative (2026-01-09)
Position Oracle philosophy against Google's enterprise multi-agent approach: "AI that keeps humans human" vs "replace workforce". Consciousness-first design.

---

## 14. Squad Challenge: Parser Bug Hunt

**Location was**: `lab/squad-challenge-parser-bug/`
**Status**: Complete exercise
**Files**: 10

### Purpose
Team debugging challenge: find why Claude Code crashes with `TypeError: $.description.split is not a function` when typing `/`.

### Root Cause
YAML parsing: `[something]` in YAML frontmatter gets parsed as array instead of string.

### Method
Binary search across skill files. Team found it in ~10 minutes.

---

## 15. Bun Utility Tools (Minimal Stubs)

**Location was**: Various `lab/` subdirectories
**Status**: Stub projects (bun init only)
**Files**: ~20

All created with `bun init v1.3.4`, each with boilerplate README only:

| Tool | Purpose |
|------|---------|
| base64 | Base64 encode/decode |
| hash-gen | Hash generation |
| uuid-gen | UUID generation |
| password-gen | Password generation |
| file-size | File size calculator |
| ip-info | IP information lookup |
| json-fmt | JSON formatting |
| link-saver | URL bookmark saver |
| lorem | Lorem ipsum generator |
| slug | URL slug generator |
| timestamp | Timestamp utility |
| time-tracker | Time tracking |
| word-count | Word counting |
| daily-log | Daily logging |

### Session Timer (only one with real implementation)
CLI tool: start/stop/status/history commands. Uses Drizzle ORM + bun:sqlite + Commander.js. Built on "Timestamps = Truth" principle.

---

## 16. Other Small Projects

### Oracle v2 Incubation
**Location was**: `lab/oracle-v2/`
Oracle graduated to `~/oracle-v2/`. This was the old incubation location.

### Oracle Jarvis
**Location was**: `lab/oracle-jarvis/`
Empty project (claude-mem context only, no content).

### Projects / Analytics
**Location was**: `lab/projects/`, `lab/analytics/`
Empty CLAUDE.md files with auto-generated claude-mem context only.

---

## Key Patterns Across All Experiments

1. **Haiku gathers, Opus writes** — Subagent delegation pattern used everywhere
2. **Show facts, don't guess** — Data > inference, tables > narrative
3. **Fear management** — Every command/tool maps to a specific fear it solves
4. **Append-only** — "Nothing is deleted", timestamps are truth
5. **Binary over gradients** — Simple scoring (0/2/4) beats complex (0-9)
6. **Rebase over merge** — Same hash everywhere, no hidden conflicts
7. **Local-first** — SQLite, DuckDB, local STT over cloud services

---

*Distilled from 112 files across 36 subdirectories. Original lab/ directory deleted after distillation.*
