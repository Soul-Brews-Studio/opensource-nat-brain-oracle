# MAW Journey Index — 2025-12-13

> A full-day journey from discovery to working multi-agent setup

---

## Timeline Overview

```
08:21 ─────────────────────────────────────────────────────── 23:27
  │                                                              │
  │  PHASE 1: Discovery          PHASE 2: Learn         PHASE 3: Setup
  │  (morning)                   (afternoon)            (evening)
  │                                                              │
  └──────────────────────────────────────────────────────────────┘
                         ~15 hours total
```

---

## Phase 1: Discovery (Morning)

**Goal**: Find out what MAW is, where it came from

| Time | Event | Outcome |
|------|-------|---------|
| ~08:21 | Session start | Full-day retrospective begins |
| ~14:13 | Created `ψ/learn/maw.md` | Initial MAW definition |
| ~14:16 | Documented weyermann origin | MAW came from real project |
| ~14:18 | Added FloodBoy Workshop story | Historical context |

**Key Discovery**: MAW = Multi-Agent Workflow, uses tmux + git worktrees

---

## Phase 2: Learning (Afternoon)

**Goal**: Understand how MAW works, document patterns

| Time | Event | Outcome |
|------|-------|---------|
| ~20:24 | Recognized weyermann = MAW prototype | Pattern connection |
| ~21:09 | Full-day patterns documented | `2025-12-13_full-day-patterns.md` |
| ~22:02 | Brewing notes + MAW session prep | WIP for evening |
| ~22:08 | Comprehensive retrospective | 13.5 hours, 70+ commits |

**Key Learning**: MAW has tiers (Strategic → Tactical → Operational)

---

## Phase 3: Setup (Evening)

**Goal**: Get MAW working in Nat-s-Agents repo

| Time | Event | Outcome |
|------|-------|---------|
| 22:33 | `2025-12-13_maw-start-control.md` | Control commands documented |
| 22:43 | `2025-12-13_maw-comprehensive-guide.md` | Full reference guide |
| 22:50 | MAW installed in Nat-s-Agents | 3 worktrees created |
| 23:00 | First session commit | `55b82b3` |
| 23:04 | New session - /recap | Fresh context |
| 23:06 | /trace maw | Found 000-workshop has more |
| 23:11 | Copied from 000-workshop | Profiles, scripts, config |
| 23:19 | Debugged `maw kill` hang | Subagent found root cause |
| 23:21 | Copied start-agents.sh | Profile14 layout support |
| 23:22 | **Profile14 working!** | 2 windows × 3 panes |
| 23:24 | rrr retrospective | Journey documented |
| 23:26 | /snapshot | Pattern extracted |
| 23:27 | This index | Full journey mapped |

---

## Files Created (Chronological)

### Learnings

| Time | File | Focus |
|------|------|-------|
| 22:33 | `2025-12-13_maw-start-control.md` | Start, control, capture commands |
| 22:43 | `2025-12-13_maw-comprehensive-guide.md` | Full 449-line reference |
| 23:14 | `2025-12-13_maw-setup-patterns.md` | What to copy from 000 |
| 23:22 | `2025-12-13_maw-setup-mistakes.md` | 4 mistakes + solutions |
| 23:26 | `2025-12-13_maw-copy-order-pattern.md` | Config→Setup→Script→Start |

### Retrospectives

| Time | File | Focus |
|------|------|-------|
| 22:03 | `22.03_full-day-maw-brewing-architecture.md` | 13.5 hour day summary |
| 23:01 | `23.01_maw-installation-journey.md` | Installation session |
| 23:24 | `23.24_maw-profile14-setup-journey.md` | Profile14 setup journey |

### Reference

| File | Purpose |
|------|---------|
| `ψ/learn/maw.md` | MAW definition |
| `ψ/learn/weyermann.md` | Origin story |
| `ψ/WIP.md` | Current status |

---

## Git Commits (MAW-related)

```
55b82b3 docs: MAW installed + WIP forward for next session
5b1ef42 learn: MAW profile14 + auto-start + capture pattern
fdb19c8 learn: MAW start & control patterns
ee7928e docs: comprehensive full-day retrospective - MAW + brewing + architecture
173db4b docs: brewing notes + WIP for MAW session
d5e2d13 feat: add maw.md
cbcacf5 docs: weyermann = MAW origin
449d844 docs: Added FloodBoy Workshop origin story
5e8c329 docs: Added maw-workshop-raw.md
842d79c refactor: /jump stack + brewing lab + ψ/learn structure
```

---

## Key Patterns Learned

### 1. Architecture
```
Tier 1 (Strategic)  → Agent 0: You (orchestration)
Tier 2 (Tactical)   → Agent 1: Shadow Claude (commands)
Tier 3 (Operational) → Agents 2-5: Specialists (parallel)
```

### 2. Copy Order
```
Config → Setup → Script → Start
```
**NOT**: Start → Debug → Realize missing

### 3. Kill Command
```bash
# DON'T (hangs on y/N)
maw kill

# DO (direct, no prompt)
tmux kill-session -t ai-Nat-s-Agents
```

### 4. Control Commands
```bash
source .envrc && maw hey 1 "task"
source .envrc && maw hey all "broadcast"
source .envrc && maw start profile14
```

### 5. Profile14 Layout
```
WINDOW 1: Agents 1-3 (horizontal)
WINDOW 2: Agents 4-5 + Monitor (horizontal)
```

---

## Mistakes Made → Lessons Learned

| Mistake | Lesson |
|---------|--------|
| Copied profiles only | Script has implementation |
| Used `maw kill` | Use direct tmux |
| Didn't check config | Config first, then setup |
| Retried failed command | Debug after first failure |

---

## Reference Repos

| Repo | Purpose |
|------|---------|
| `Soul-Brews-Studio/multi-agent-workflow-kit` | Canonical source |
| `/Users/nat/000-workshop-product-page` | Working example |
| `laris-co/Nat-s-Agents` | This repo (now working) |

---

## Current State

```
SESSION: ai-Nat-s-Agents
PROFILE: profile14
AGENTS: 5 (1-5)
LAYOUT: 2 windows × 3 panes
STATUS: WORKING
```

---

## Next Steps

- [ ] Commit all MAW setup changes
- [ ] Use MAW for real multi-agent work
- [ ] Find pain points → improve kit
- [ ] PR improvements back to Soul-Brews-Studio

---

## Stats

| Metric | Value |
|--------|-------|
| Total session time | ~15 hours |
| MAW-focused time | ~3 hours |
| Learning files | 5 |
| Retrospectives | 3 |
| Git commits | 10+ |
| Mistakes documented | 4 |
| Patterns learned | 5 |

---

*Full journey from "what is MAW?" to "Profile14 working" in one day.*
