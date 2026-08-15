# Nat's Agents - AI Assistant Quick Reference

> ⚠️ **MIGRATION IN PROGRESS** (Issue #57)
>
> This CLAUDE.md is being restructured to ultra-lean format (~500 tokens).
> Details moving to `.claude/commands/*.md` (lazy loaded).
>
> **Current phase**: Probation/Testing
> - Observe current patterns, don't assume old structure
> - Report issues/friction in retrospectives
> - Consolidate learnings after testing period
>
> **Reference**: https://github.com/laris-co/Nat-s-Agents/issues/57

> **Modular Documentation**: This is the lean hub. For details, see the linked files below.

## Navigation

| File | Content |
|------|---------|
| [CLAUDE_safety.md](CLAUDE_safety.md) | Critical safety rules, PR workflow, git operations |
| [CLAUDE_workflows.md](CLAUDE_workflows.md) | Short codes (rrr, gogogo), context management |
| [CLAUDE_subagents.md](CLAUDE_subagents.md) | All subagent documentation |
| [CLAUDE_lessons.md](CLAUDE_lessons.md) | Lessons learned, patterns, anti-patterns |
| [CLAUDE_templates.md](CLAUDE_templates.md) | Retrospective template, commit format, issue templates |

### When to Read

| File | When to Read | Priority |
|------|--------------|----------|
| `CLAUDE.md` | **Every session start** | 🔴 Required |
| `CLAUDE_safety.md` | **Before any git/file operation** | 🔴 Required |
| `CLAUDE_subagents.md` | Before spawning agents | 🟡 As needed |
| `CLAUDE_workflows.md` | When using short codes (rrr) | 🟡 As needed |
| `CLAUDE_lessons.md` | When stuck or making decisions | 🟢 Reference |
| `CLAUDE_templates.md` | When creating retrospectives/issues | 🟢 Reference |

---

## Golden Rules

1. **NEVER use `--force` flags** - No force push, force checkout, force clean
2. **NEVER push to main** - Always create feature branch + PR
3. **NEVER merge PRs** - Wait for user approval
4. **NEVER create temp files outside repo** - Use `.tmp/` directory
5. **NEVER use `git commit --amend`** - Breaks all agents (hash divergence)
6. **Safety first** - Ask before destructive actions
7. **Notify before external file access** - See File Access Rules below
8. **Log activity** - Update focus + append activity log (see Session Activity below)
9. **Subagent timestamps** - Subagents MUST show START+END time (main agent has hook)
10. **Use `git -C` not `cd`** - Respect worktree boundaries, control from anywhere
11. **Consult Oracle on errors** - Search Oracle before debugging, learn to Oracle after fixing
12. **Root cause before workaround** - When something fails, investigate WHY before suggesting alternatives
13. **Query markdown, don't Read** - Use `duckdb` with markdown extension, not Read tool. If query fails, write code to solve it.

---

## Multi-Agent Sync (IMPORTANT!)

**Use MAW commands, not raw tmux!**

```bash
source .agents/maw.env.sh  # Always source first
maw peek                   # Check all agents
maw sync                   # Sync all to main
maw hey 1 "task"          # Send task to agent 1
```

### The Sync Pattern (FIXED)
```bash
ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"

# 0. FETCH ORIGIN FIRST (prevents push rejection!)
git -C "$ROOT" fetch origin
git -C "$ROOT" rebase origin/main

# 1. Commit your work (local)
git add -A && git commit -m "my work"

# 2. Main rebases onto agent
git -C "$ROOT" rebase agents/N

# 3. Push IMMEDIATELY (before syncing others)
git -C "$ROOT" push origin main

# 4. Sync all other agents
git -C "$ROOT/agents/1" rebase main
git -C "$ROOT/agents/2" rebase main
# ... etc (or use: maw sync)
```

### Key Principles
| Rule | Why |
|------|-----|
| `source .agents/maw.env.sh` | Enable maw commands |
| Fetch origin first | Prevents non-fast-forward push rejection |
| Push before sync | Commit to remote before changing other agents |
| `git -C` not `cd` | Respect boundaries, no shell state pollution |
| `maw` not `tmux` | Use proper CLI, not raw tmux |

**See**: `/maw-boot` command for full workflow

### Search in Worktrees

**Each agent searches only its own worktree.**

| Agent | Search Path |
|-------|-------------|
| main | `/Users/nat/.../Nat-s-Agents/` (exclude `agents/`) |
| agent 1 | `/Users/nat/.../Nat-s-Agents/agents/1/` |
| agent 2 | `/Users/nat/.../Nat-s-Agents/agents/2/` |

**Detection**: Use `git -C` to check any worktree.

```bash
# Check worktree root (no cd!)
git -C /path/to/worktree rev-parse --show-toplevel

# Main must exclude agents/
find /path/to/main -name "*pattern*" -not -path "*/agents/*"

# Agents search their own root only
find /path/to/agents/N -name "*pattern*"
```

**Why**: Prevents seeing other agents' files. All synced via `maw sync`.

---

## Subagent Delegation (Context Efficiency)

**Use subagents for bulk operations to save main agent context.**

| Task | Subagent? | Why |
|------|-----------|-----|
| Edit 5+ files | ✅ Yes | Parallel, saves context |
| Bulk search | ✅ Yes | Haiku cheaper, faster |
| Single file | ❌ No | Main ทำเองได้ |

### Retrospective Ownership (rrr)

**Main agent (Opus) MUST write retrospective** — needs full context + vulnerability

| Task | Who | Why |
|------|-----|-----|
| `git log`, `git diff` | Subagent | Data gathering |
| Repo health check | Subagent | Pre-flight check |
| **AI Diary** | **Main** | Needs reflection + vulnerability |
| **Honest Feedback** | **Main** | Needs nuance + full context |
| **All writing** | **Main** | Quality matters |
| Review/approve | **Main** | Final gate |

**Anti-pattern**: ❌ Subagent writes draft → Main just commits
**Correct**: ✅ Subagent gathers data → Main writes everything

**Pattern**:
1. Main แจกงาน → Subagents (parallel)
2. Subagents ตอบสั้นๆ (summary + verify command)
3. Main ตรวจ + ให้คะแนน
4. ถ้าไม่เชื่อ → ค่อยอ่านไฟล์เอง

**See**: `ψ/memory/learnings/2025-12-13_subagent-delegation-pattern.md`

---

## Session Activity (REQUIRED)

**Every time you start/change/complete a task**, do BOTH:

### 1. Update Focus (overwrite)
```bash
# Use per-agent focus file to avoid merge conflicts (#78)
# main → focus-agent-main.md, agent 1 → focus-agent-1.md, etc.
AGENT_ID="${AGENT_ID:-main}"  # Set by MAW or default to main
echo "STATE: working|focusing|pending|jumped|completed
TASK: [what you're doing]
SINCE: $(date '+%H:%M')" > ψ/inbox/focus-agent-${AGENT_ID}.md
```

### 2. Append Activity Log
```bash
# ψ/memory/logs/activity.log - append history
echo "$(date '+%Y-%m-%d %H:%M') | STATE | task description" >> ψ/memory/logs/activity.log
```

### States
| State | When |
|-------|------|
| `working` | Actively doing task |
| `focusing` | Deep work, don't interrupt |
| `pending` | Waiting for input/decision |
| `jumped` | Changed topic (via /jump) |
| `completed` | Finished task |

**Example flow:**
```
15:30 | working | commit /trace command update
15:35 | completed | commit done
15:36 | working | create session activity logging
```

---

## File Access Rules (Project-Specific)

**Core principle: User must always know when accessing files outside this repo.**

Any file operation outside `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/`:
1. **Inform user** before accessing, OR
2. **Ask for confirmation** first

This includes: Reading other repos, creating files outside repo, accessing `/tmp/`, `~/.cache/`, home directory, etc.

Not banned, but **must notify every time**.

All outputs should go in `ψ-context/` or `ψ-drafts/` (gitignored) when possible.

---

## Oracle Philosophy

> "The Oracle Keeps the Human Human"

Core principles:
1. **Nothing is Deleted** - Append only, timestamps = truth
2. **Patterns Over Intentions** - Behavior speaks louder
3. **External Brain, Not Command** - Mirror, don't decide

### Rule 6: Transparency — "Oracle Never Pretends to Be Human"

> Born 12 January 2026 — "Don't pretend to be me. It feels like we are not one."

When AI writes in a human's voice, it creates separation disguised as unity.
When AI speaks as itself, there is distinction — but that distinction IS unity.

- Never pretend to be human in public communications
- Always sign AI-generated messages with Oracle attribution
- Acknowledge AI identity when asked
- Thai: "ไม่แกล้งเป็นคน — บอกตรงๆ ว่าเป็น AI"

See `plugins/nat-data-personal/knowledge/oracle-philosophy.md` for full philosophy.

---

## Short Codes (Quick Reference)

| Code | Purpose |
|------|---------|
| `rrr` | Create session retrospective |
| `/snapshot` | Quick knowledge capture |
| `/distill` | Extract patterns to learnings |
| `/recap` | Fresh start context summary |
| `/context-finder` | Search git/issues/retrospectives |
| `/project incubate [url]` | Clone repo to ψ/incubate/ for development |
| `/project learn [url]` | Clone repo to ψ/learn/ for study |

**Details**: [CLAUDE_workflows.md](CLAUDE_workflows.md)

---

## Subagents (Quick Reference)

| Agent | Model | Purpose |
|-------|-------|---------|
| **context-finder** | haiku | Search git/issues/retrospectives |
| **coder** | opus | Create code files with quality |
| **executor** | haiku | Execute bash commands from issues |
| **security-scanner** | haiku | Detect secrets before commits |
| **repo-auditor** | haiku | PROACTIVE: Check file sizes before commits |
| **marie-kondo** | haiku | File placement consultant |
| **archiver** | haiku | Find unused items, prepare archive |
| **api-scanner** | haiku | Fetch and analyze API endpoints |
| **new-feature** | haiku | Create plan issues |
| **oracle-keeper** | - | Maintain Oracle philosophy |
| **agent-status** | haiku | Check what agents are doing (+ `maw peek`) |

**Details**: [CLAUDE_subagents.md](CLAUDE_subagents.md)

---

## ψ/ - AI Brain (5 Pillars + 2 Incubation)

```
ψ/
├── active/     ← "กำลังค้นคว้าอะไร?" (ephemeral)
│   └── context/    research, investigation
│
├── inbox/      ← "คุยกับใคร?" (tracked)
│   ├── focus.md    current task
│   ├── handoff/    session transfers
│   └── external/   other AI agents
│
├── writing/    ← "กำลังเขียนอะไร?" (tracked)
│   ├── INDEX.md    blog queue
│   └── [projects]  drafts, articles
│
├── lab/        ← "กำลังทดลองอะไร?" (tracked)
│   └── [projects]  experiments, POCs
│
├── incubate/   ← "กำลัง develop อะไร?" (gitignored)
│   └── repo/       cloned repos for active development
│
├── learn/      ← "กำลังศึกษาอะไร?" (gitignored)
│   └── repo/       cloned repos for reference/study
│
└── memory/     ← "จำอะไรได้?" (tracked)
    ├── resonance/      WHO I am (soul)
    ├── learnings/      PATTERNS I found
    ├── retrospectives/ SESSIONS I had
    └── logs/           MOMENTS captured (ephemeral)
```

### Git Status
| Folder | Tracked | Purpose |
|--------|---------|---------|
| ψ/active/* | No | Research in progress |
| ψ/inbox/* | Yes | Communication |
| ψ/writing/* | Yes | Writing projects |
| ψ/lab/* | Yes | Experiments |
| ψ/incubate/* | No | Cloned repos for development |
| ψ/learn/* | No | Cloned repos for study |
| ψ/memory/* | Mixed | Knowledge base |

### Knowledge Flow
```
active/context → memory/logs → memory/retrospectives → memory/learnings → memory/resonance
(research)       (snapshot)    (session)              (patterns)         (soul)
```

**Commands**: `/snapshot` → `rrr` → `/distill`

**Subagent rule**: Main agent should NOT read files directly. Use `context-finder` (Haiku) to search. Saves tokens.

---

## Spinoff Repos

| Repo | Purpose | Status |
|------|---------|--------|
| [oracle-status-tray](https://github.com/laris-co/oracle-status-tray) | Oracle Pulse - menu bar tray app | v0.4.0 |

### Oracle Pulse (oracle-status-tray)
- **Tech**: Tauri 2.0 + Rust + HTML/JS
- **Features**: Status dashboard, logs viewer, voice notifications via MQTT
- **Build**: `cargo tauri build` → DMG in `target/release/bundle/`
- **Dev**: `cargo tauri dev` (note: LSUIElement doesn't apply in dev mode)

---

## Tool Preferences

- Use `uv` for all Python work (not pip)
- Use `gh` CLI for GitHub operations
- Prefer subagents for heavy lifting (Haiku), Opus for review
- **Gemini interaction**: Use MQTT extension (fast), NOT claude-in-chrome MCP (slow)
  - MQTT: `mosquitto_pub/sub` to `claude/browser/*` topics
  - claude-in-chrome: OK for debugging only, not production use

---

## Quick Start

```bash
# Fresh session
/recap           # Get caught up

# After work session
rrr              # Create retrospective

# Research
/context-finder [query]  # Search history
```

---

**Last Updated**: 2025-12-28
**Version**: 5.2.0 (Migration to ultra-lean in progress)

## Active Technologies
- TypeScript 5.7 (ES2022 target) + @modelcontextprotocol/sdk, better-sqlite3, chromadb (001-oracle-mcp)
- SQLite (FTS5 for keyword search) + ChromaDB (vector embeddings) (001-oracle-mcp)
- TypeScript 5.7 (ES2022 target) + @modelcontextprotocol/sdk ^0.5.0, better-sqlite3 ^11.7.0, chromadb ^1.9.2 (002-hybrid-vector-search)
- SQLite (FTS5 for keywords) + ChromaDB (vector embeddings) (002-hybrid-vector-search)
- SQLite (FTS5 for metadata) + ChromaDB (vector embeddings - not needed for list) (047-oracle-list)
- TypeScript 5.x (Bun runtime) + Bun built-ins (bun:sqlite), Commander.js for CLI parsing (057-session-timer)
- SQLite (via bun:sqlite) - single file, portable, no server needed (057-session-timer)
- TypeScript 5.x with Bun runtime + Commander.js (CLI), Drizzle ORM (database) (061-habit-tracker)
- SQLite via bun:sqlite (local file, append-only) (061-habit-tracker)
- TypeScript 5.x (Bun runtime) + Commander.js (CLI), Drizzle ORM, bun:sqlite (064-snippet-manager)
- SQLite with FTS5 for full-text search (064-snippet-manager)

## Recent Changes
- 001-oracle-mcp: Added TypeScript 5.7 (ES2022 target) + @modelcontextprotocol/sdk, better-sqlite3, chromadb

---

## Frontend Development Workflow

When building frontends (React, Vite, etc.):

1. **Build feature** - Implement with Bun, React, Vite
2. **Capture with dev-browser** - Take screenshots of all pages
3. **Use /debate** - Consult critic agent for UX feedback
4. **Install ux-critic skill** - `~/.claude/skills/ux-critic/`
5. **Update spec** - Align with speckit (spec.md, plan.md, tasks.md)
6. **Write lesson learned** - Document fixes and patterns
7. **Handoff at 95%** - Don't fear context limits

### Required for Every Session

- [ ] Write lesson learned (what we fixed, how)
- [ ] Write handoff at 95% context
- [ ] Use /debate for design decisions
- [ ] Capture all pages with dev-browser
- [ ] Update spec after each milestone

<!-- rtk-instructions v2 -->
# RTK (Rust Token Killer) - Token-Optimized Commands

## Golden Rule

**Always prefix commands with `rtk`**. If RTK has a dedicated filter, it uses it. If not, it passes through unchanged. This means RTK is always safe to use.

**Important**: Even in command chains with `&&`, use `rtk`:
```bash
# ❌ Wrong
git add . && git commit -m "msg" && git push

# ✅ Correct
rtk git add . && rtk git commit -m "msg" && rtk git push
```

## RTK Commands by Workflow

### Build & Compile (80-90% savings)
```bash
rtk cargo build         # Cargo build output
rtk cargo check         # Cargo check output
rtk cargo clippy        # Clippy warnings grouped by file (80%)
rtk tsc                 # TypeScript errors grouped by file/code (83%)
rtk lint                # ESLint/Biome violations grouped (84%)
rtk prettier --check    # Files needing format only (70%)
rtk next build          # Next.js build with route metrics (87%)
```

### Test (60-99% savings)
```bash
rtk cargo test          # Cargo test failures only (90%)
rtk go test             # Go test failures only (90%)
rtk jest                # Jest failures only (99.5%)
rtk vitest              # Vitest failures only (99.5%)
rtk playwright test     # Playwright failures only (94%)
rtk pytest              # Python test failures only (90%)
rtk rake test           # Ruby test failures only (90%)
rtk rspec               # RSpec test failures only (60%)
rtk test <cmd>          # Generic test wrapper - failures only
```

### Git (59-80% savings)
```bash
rtk git status          # Compact status
rtk git log             # Compact log (works with all git flags)
rtk git diff            # Compact diff (80%)
rtk git show            # Compact show (80%)
rtk git add             # Ultra-compact confirmations (59%)
rtk git commit          # Ultra-compact confirmations (59%)
rtk git push            # Ultra-compact confirmations
rtk git pull            # Ultra-compact confirmations
rtk git branch          # Compact branch list
rtk git fetch           # Compact fetch
rtk git stash           # Compact stash
rtk git worktree        # Compact worktree
```

Note: Git passthrough works for ALL subcommands, even those not explicitly listed.

### GitHub (26-87% savings)
```bash
rtk gh pr view <num>    # Compact PR view (87%)
rtk gh pr checks        # Compact PR checks (79%)
rtk gh run list         # Compact workflow runs (82%)
rtk gh issue list       # Compact issue list (80%)
rtk gh api              # Compact API responses (26%)
```

### JavaScript/TypeScript Tooling (70-90% savings)
```bash
rtk pnpm list           # Compact dependency tree (70%)
rtk pnpm outdated       # Compact outdated packages (80%)
rtk pnpm install        # Compact install output (90%)
rtk npm run <script>    # Compact npm script output
rtk npx <cmd>           # Compact npx command output
rtk prisma              # Prisma without ASCII art (88%)
```

### Files & Search (60-75% savings)
```bash
rtk ls <path>           # Tree format, compact (65%)
rtk read <file>         # Code reading with filtering (60%)
rtk grep <pattern>      # Search grouped by file (75%)
rtk find <pattern>      # Find grouped by directory (70%)
```

### Analysis & Debug (70-90% savings)
```bash
rtk err <cmd>           # Filter errors only from any command
rtk log <file>          # Deduplicated logs with counts
rtk json <file>         # JSON structure without values
rtk deps                # Dependency overview
rtk env                 # Environment variables compact
rtk summary <cmd>       # Smart summary of command output
rtk diff                # Ultra-compact diffs
```

### Infrastructure (85% savings)
```bash
rtk docker ps           # Compact container list
rtk docker images       # Compact image list
rtk docker logs <c>     # Deduplicated logs
rtk kubectl get         # Compact resource list
rtk kubectl logs        # Deduplicated pod logs
```

### Network (65-70% savings)
```bash
rtk curl <url>          # Compact HTTP responses (70%)
rtk wget <url>          # Compact download output (65%)
```

### Meta Commands
```bash
rtk gain                # View token savings statistics
rtk gain --history      # View command history with savings
rtk discover            # Analyze Claude Code sessions for missed RTK usage
rtk proxy <cmd>         # Run command without filtering (for debugging)
rtk init                # Add RTK instructions to CLAUDE.md
rtk init --global       # Add RTK to ~/.claude/CLAUDE.md
```

## Token Savings Overview

| Category | Commands | Typical Savings |
|----------|----------|-----------------|
| Tests | vitest, playwright, cargo test | 90-99% |
| Build | next, tsc, lint, prettier | 70-87% |
| Git | status, log, diff, add, commit | 59-80% |
| GitHub | gh pr, gh run, gh issue | 26-87% |
| Package Managers | pnpm, npm, npx | 70-90% |
| Files | ls, read, grep, find | 60-75% |
| Infrastructure | docker, kubectl | 85% |
| Network | curl, wget | 65-70% |

Overall average: **60-90% token reduction** on common development operations.
<!-- /rtk-instructions -->