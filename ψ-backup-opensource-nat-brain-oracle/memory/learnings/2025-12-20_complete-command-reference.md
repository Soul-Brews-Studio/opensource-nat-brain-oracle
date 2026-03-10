# Complete Command Reference Guide

> 42 slash commands organized by category

---

## Activity Logging (6 commands)

| Command | Purpose | Example |
|---------|---------|---------|
| `/feel` | Log emotions (hybrid mode) | `/feel frustrated with debugging` |
| `/fyi` | Log info for future reference | `/fyi API rate limit is 1000/hour` |
| `/idea` | Log concept for later | `/idea use websockets for sync` |
| `/random` | Random notes + AI interpretation | `/random weird bug pattern` |
| `/emotional` | Full emotional tracking | `/emotional` (interactive) |
| `/snapshot` | Extract lesson from context | `/snapshot` |

---

## Session Workflow (8 commands)

| Command | Purpose | Example |
|---------|---------|---------|
| `/rrr` | Create session retrospective | `rrr` (Main agent only) |
| `/recap` | Fresh start context summary | `/recap` |
| `/distill` | Extract patterns → learnings/ | `/distill` |
| `/draft` | Blog draft from session | `/draft topic-name` |
| `/done` | Mark task complete | `/done fix-auth-bug` |
| `/forward` | Hand off to new session | `/forward` (before /clear) |
| `/standup` | Daily standup check | `/standup` |
| `/hours` | Work hours summary | `/hours` |

---

## Multi-Agent (6 commands)

| Command | Purpose | Example |
|---------|---------|---------|
| `/maw-demo` | MAW multi-agent demo | `/maw-demo research APIs` |
| `/maw-sync-demo` | Demo sync pattern | `/maw-sync-demo` |
| `/parallel` | Spawn parallel subagents | `/parallel search:auth search:db` |
| `/sync` | Full system sync | `/sync` |
| `/ampere` | Run as Ampere | `/ampere commit` |
| `/bm` | Run as BM | `/bm update docs` |

---

## Context & Search (6 commands)

| Command | Purpose | Example |
|---------|---------|---------|
| `/context-finder` | Search history/issues/code | `/context-finder auth patterns` |
| `/trace` | Find lost projects | `/trace old-project` |
| `/catalog` | Index all markdown files | `/catalog` |
| `/active` | Show current work | `/active` |
| `/pending` | Show pending tasks | `/pending` |
| `/wip` | Raw WIP.md content | `/wip` |

---

## Project Management (6 commands)

| Command | Purpose | Example |
|---------|---------|---------|
| `/project` | Clone for learn/incubate | `/project incubate github.com/repo` |
| `/plan` | Smart planning router | `/plan add authentication` |
| `/speckit.plan` | Full implementation planning | `/speckit.plan` |
| `/schedule` | Calendar/events | `/schedule add meeting 3pm` |
| `/learn` | Deep dive (3 parallel agents) | `/learn` |
| `/update` | Parallel status update | `/update` |

---

## Git & Repository (5 commands)

| Command | Purpose | Example |
|---------|---------|---------|
| `/commit` | Smart commit (Haiku) | `/commit` |
| `/gogogo` | Execute with PR workflow | `/gogogo` (never main) |
| `/repo-audit` | Repository health check | `/repo-audit` |
| `/repo-scan` | Directory size scan | `/repo-scan ψ/memory` |
| `/spinoff` | Extract folder to new repo | `/spinoff large-folder` |

---

## Identity Modes (2 commands)

| Command | Purpose | Example |
|---------|---------|---------|
| `/guest` | Guest mode (asks identity) | `/guest` |
| `/anon` | Anonymous mode | `/anon` |

---

## Utility (3 commands)

| Command | Purpose | Example |
|---------|---------|---------|
| `/oracle` | Mission alignment check | `/oracle` |
| `/jump` | Topic change (stack-based) | `/jump` |
| `/headline-api-scan` | U-LIB API analysis | `/headline-api-scan` |

---

## Command Patterns

**Timestamp Commands** (auto-log start/end):
`/context-finder`, `/distill`, `/hours`, `/oracle`, `/recap`, `/standup`, `/trace`

**Subagent-Delegating** (uses Haiku):
`/commit`, `/context-finder`, `/learn`, `/parallel`, `/update`

**Main-Agent-Only** (requires Opus):
`/rrr`, `/draft`, `/distill`

---

*Last Updated: 2025-12-20 | Total: 42 commands*
