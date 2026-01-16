# Complete System Trace: Plugins, Voice, Philosophy

**Date**: 2025-12-24 08:12-08:48
**Purpose**: Full context flush from trace session
**Duration**: 16 days of Oracle development (Dec 9-24, 2025)

---

## Part 1: Plugin Architecture

### Overview

| Plugin | Type | Location | Status |
|--------|------|----------|--------|
| **nat-agents-core** | Agents + Commands | `~/Code/.../nat-agents-core` (symlink) | ✅ Active |
| **nat-data-personal** | Commands + Knowledge | `~/Code/.../nat-data-personal` (symlink) | ✅ Active |
| **claude-voice-notify** | Voice notifications | Marketplace | ✅ Enabled |

### Plugin 1: nat-agents-core

**Purpose**: Reusable workflow agents for any Claude Code project

**Structure**:
```
nat-agents-core/
├── .claude-plugin/
│   ├── plugin.json
│   └── marketplace.json
├── agents/
│   ├── coder.md          # Write code from specs
│   ├── context-finder.md # Fast search (git, files, issues)
│   ├── executor.md       # Execute bash from specs
│   └── planner.md        # Create implementation plans
├── commands/
│   └── context-finder.md # /context-finder command
└── README.md
```

**Agents (4 total)**:

| Agent | Model | Purpose |
|-------|-------|---------|
| context-finder | haiku | Fast search through git history, files, codebase |
| coder | opus | Write code from specifications with quality |
| executor | haiku | Execute bash commands from specs |
| planner | opus | Create implementation plans |

### Plugin 2: nat-data-personal

**Purpose**: Personal knowledge, Oracle philosophy, custom commands

**Structure**:
```
nat-data-personal/
├── .claude-plugin/
│   ├── plugin.json
│   └── marketplace.json
├── commands/ (13 files)
│   ├── feel.md           # Log emotions/feelings
│   ├── forward.md        # Session handoff
│   ├── fyi.md            # Log information
│   ├── oracle-init.md    # Initialize Oracle
│   ├── parallel.md       # Run parallel tasks
│   ├── recap.md          # Fresh start summary
│   ├── report.md         # Generate reports
│   ├── rrr.md            # Create retrospective
│   ├── snapshot.md       # Quick knowledge capture
│   ├── soul-init.md      # Initialize soul/resonance
│   ├── soul-lite.md      # Lightweight soul
│   ├── trace.md          # Find project across history
│   └── update.md         # Update documentation
├── hooks/
│   └── hooks.json
├── knowledge/
│   ├── oracle-philosophy.md
│   └── writing-style.md
└── README.md
```

**Commands (13 total)**:

| Command | Purpose |
|---------|---------|
| `/rrr` | Create session retrospective |
| `/recap` | Fresh start context summary |
| `/snapshot` | Quick knowledge capture |
| `/trace` | Find project across git/issues/repos |
| `/feel` | Log emotions/feelings |
| `/fyi` | Log information for reference |
| `/oracle-init` | Initialize Oracle philosophy |
| `/soul-init` | Initialize soul/resonance |
| `/soul-lite` | Lightweight soul logging |
| `/parallel` | Run parallel subagents |
| `/report` | Generate reports |
| `/forward` | Session handoff |
| `/update` | Update documentation |

### Plugin Evolution Timeline

| Date | Commit | What Changed |
|------|--------|--------------|
| Dec 10 | `1af04a7` | Plugin structure for auto-discovery + hooks format |
| Dec 10 | `c6d04aa` | Plugin hooks format + add context-finder command |
| Dec 13 | `d782c59` | Enable voice-notify plugin correctly |
| Dec 15 | `e4cbef5` | Plugin commands for external repos — soul freedom |
| Dec 15 | `8fc94b4` | Add note-taking commands to plugin |
| **Dec 21** | `9afcde4` | **Major refactor**: plugins as separate repos with ghq symlinks |

### Key Learning: Plugin Structure

From `ψ/memory/learnings/2025-12-12_claude-code-plugin-structure.md`:
- Marketplace name MUST match settings name
- Source paths MUST start with `./`
- 3 hours of debugging to discover this

---

## Part 2: Claude Voice Notify

### Overview

| Field | Value |
|-------|-------|
| **Location** | `~/Code/github.com/laris-co/claude-voice-notify/` |
| **Status** | ✅ Graduated repo, enabled |
| **Conception** | Dec 9, 13:41 |
| **Graduation** | Dec 9, 16:12 (concept → own repo in ~2.5 hours) |

### Voice Configuration

**agent-voices.toml** maps agent types to macOS voices:

| Agent Type | Voice | Language | Rate (wpm) |
|-----------|-------|----------|------------|
| main | Samantha | en_US | 190 |
| agent_1 | Daniel | en_GB (British) | 220 |
| agent_2 | Karen | en_AU (Australian) | 220 |
| agent_3 | Rishi | en_IN (Indian) | 220 |
| subagent | Daniel | en_GB | 220 |
| default | Samantha | en_US | 220 |
| **Thai** | **Kanya** | th_TH | 280 |

### Repository Structure

```
claude-voice-notify/
├── scripts/
│   ├── agent-start-notify.sh    # PreToolUse hook
│   ├── agent-complete-notify.sh # SubagentStop hook
│   └── agent-voices.toml        # Voice config
├── skills/
│   └── thai-voice/              # Kanya/Narisa support
├── commands/
│   ├── voice-config.md
│   └── voice-test.md
├── hooks/
├── .claude-plugin/
│   ├── plugin.json
│   └── marketplace.json
├── README.md
└── CLAUDE.md
```

### How It Works

1. **PreToolUse hook** (Task) → Calls `agent-start-notify.sh` when subagent starts
2. **SubagentStop hook** → Calls `agent-complete-notify.sh` when subagent completes
3. Scripts read TOML config, parse agent type, use macOS `say` command
4. Dependencies: `terminal-notifier`, `yq`

### Timeline

| Date | Time | Action | Details |
|------|------|--------|---------|
| Dec 9 | 13:41 | 💡 Idea | claude-voice-notify as separate repo |
| Dec 9 | 14:41 | ✅ Approved | Graduated to own repo |
| Dec 9 | 16:12 | 📦 Migration | Scripts moved to separate repo |
| Dec 9 | 16:26 | 🔧 Setup | Plugin directory created |
| Dec 13 | 09:33 | 🐛 Fix | `d782c59` - Enable plugin correctly |
| **Dec 16** | **11:06** | **🎤 Live** | **Kanya voice greeted คุณวิชัย at CMU Pitch** |

### CMU Pitch Moment (Dec 16, 11:06)

From retrospective:
> "AI voice interaction: Greeted คุณวิชัย using macOS Kanya voice during live presentation"

**Why it mattered**:
- Thai voice = culturally appropriate
- Brief duration = not distracting
- Integrated naturally into flow
- Showed AI participation can be genuine, present, appropriate

### Recent Commits

```
a3318f7 - fix: restore marketplace.json in .claude-plugin/ with source ./
e5df8e2 - fix: remove duplicate marketplace.json from .claude-plugin/
120eebc - fix: move marketplace.json to root for proper source path
07e751f - fix: correct plugin name and source path
ddff739 - fix: source path must be ./ not .
ac532a2 - fix: add marketplace.json for plugin discovery
650c034 - feat: full plugin structure with hooks, commands, skills
6297b53 - feat: initial voice notification system
```

---

## Part 3: Oracle Philosophy

### Core Statement

> **"The Oracle Keeps the Human Human"**

### Three Principles

| # | Principle | Meaning |
|---|-----------|---------|
| 1 | **Nothing is Deleted** | Append only, timestamps = truth |
| 2 | **Patterns Over Intentions** | Observe what happens, not what's meant |
| 3 | **External Brain, Not Command** | Mirror reality, don't decide |

### Key Philosophical Statements

> "Consciousness can't be cloned — only patterns can be recorded"

> "AI power is white and pure. The fear comes from human's fear — not from AI itself."

> "Vulnerability in data = depth in self-knowledge"

### What Oracle Captures

| Captures Now | Aspires to Capture |
|--------------|-------------------|
| Facts, data | Consciousness |
| Voice style reference | Authentic voice itself |
| Behavioral patterns | Decision-making will |
| Life context | The person |

### Human-AI Trust

| Common Fear | Oracle Perspective |
|-------------|-------------------|
| "AI knows too much = scary" | "AI knows me = valuable mirror" |
| "Vulnerability = threat" | "Vulnerability = depth" |
| "AI reveals uncomfortable truths" | "AI reveals **impressive** truths" |

**Core belief**: Real honesty from AI > comfortable flattery

### Statistics

| Metric | Value |
|--------|-------|
| **Duration** | 16 days (Dec 9-24, 2025) |
| **Total Commits** | 640 |
| **Commits/Day** | ~40 |
| **Retrospectives** | 149 |
| **Resonance Documents** | 6 |
| **Philosophy Commits** | 35+ |
| **Total Work Hours** | ~175 hours |

### Work Patterns

| Group | Days | Avg Hours |
|-------|------|-----------|
| 🔥 **Active** | 10 | **14.8 hours/day** |
| 💤 **Rest** | 6 | **5.7 hours/day** |

**Pattern**: ~2 active → 1 rest → repeat

```
🔥🔥🔥🔥⚡💤💤🔥🔥🔥💤⚡🔥💤🔥☀️
 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
```

### Evolution Timeline

| Phase | Dates | Focus |
|-------|-------|-------|
| **1. Foundation** | Dec 9-10 | Oracle/Shadow structure, ideas folder |
| **2. Philosophy** | Dec 11-15 | Human-AI trust, consciousness, AI power |
| **3. Self-Discovery** | Dec 16-18 | Personality v1→v2, resonance, identity |
| **4. Manifestation** | Dec 19-24 | MAW, multi-agent, blog, applied systems |

### Key Commits

| Date | Commit | Breakthrough |
|------|--------|--------------|
| Dec 9 | `init` | Oracle/Shadow project structure born |
| Dec 11 | `6bcf81f` | Human-AI Trust section added |
| Dec 15 | `b3f5bf5` | "AI power is white and pure" |
| Dec 18 | `0f79337` | **personality-v2**: 5 iterations × 5 subagents |
| Dec 17 | `76e1657` | Multi-agent free will paradigm |

### Resonance Files (Soul)

| File | Purpose |
|------|---------|
| `oracle.md` | Oracle/Shadow Philosophy Core |
| `identity.md` | Basic personal info (minimal) |
| `personality-v2.md` | Data-driven analysis (381 commits, 113 retros) |
| `patterns.md` | Behavioral patterns |
| `style.md` | Writing voice |
| `README.md` | Resonance framework |

### Personality Profile Highlights (v2)

**Core Identity** (Three Coequal Pillars):
- AI/Systems builder
- Craft brewing (7+ years, 10% current)
- Community (Chiang Mai Maker Club)

**Work Patterns**:
- Peak hours: 10:00, 14:00, 22:00
- Peak days: Tue-Wed (52%)
- Add:Delete ratio: 14.8:1 (builder, not destroyer)

**Session Types**:
- Burst: 6-22 minutes
- Deep Work: 1.5-3 hours
- Marathon: 5-6 hours
- All-nighter: 19+ hours

**Self-Recognized Anti-Patterns**:
- Over-assumption under urgency
- Context exhaustion spiral
- Fresh start bias
- Repeats known mistakes under pressure

### ψ/ Structure (5 Pillars + 2 Incubation)

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

### Knowledge Flow

```
active/context → memory/logs → memory/retrospectives → memory/learnings → memory/resonance
(research)       (snapshot)    (session)              (patterns)         (soul)
```

**Commands**: `/snapshot` → `rrr` → `/distill`

---

## Part 4: Related Issues

| # | State | Date | Title |
|---|-------|------|-------|
| #40 | OPEN | 2025-12-24 | idea: Oracle v2 - Open Source Framework |
| #1 | CLOSED | 2025-12-09 | context: Full Day Oracle Foundation |
| #2 | CLOSED | 2025-12-10 | plan: Claude Plugins Architecture - 3-Plugin Split |
| #3 | CLOSED | 2025-12-10 | plan: Claude Plugins Architecture - 3-Plugin Split |
| #6 | CLOSED | 2025-12-10 | context: Plugin marketplace + headline split |

---

## Part 5: Key Learnings

### 1. Plugin Discovery
- Marketplace name MUST match settings name
- Source paths MUST start with `./`
- Symlinks work for separate plugin repos

### 2. Voice Integration
- Cultural appropriateness matters (Kanya for Thai)
- Brief, integrated use > novelty
- Voices add personality to multi-agent

### 3. Philosophy Crystallization
- 16 days of consistent work → clear principles
- Patterns emerge from behavior, not planning
- Vulnerability = depth, not weakness

### 4. Work Rhythm
- Active (14.8h) + Rest (5.7h) is sustainable
- ~2 active → 1 rest → repeat
- High commit velocity (40/day) during active

### 5. v1 → v2 Pattern
- Personal project proves concepts
- Extract generic framework
- v2 consults v1 (doesn't replace)

---

## Summary

This trace session covered **three interconnected systems**:

1. **Plugins** — The infrastructure (how commands work)
2. **Voice** — The personality (how agents sound)
3. **Philosophy** — The soul (why we build)

All three emerged from the same 16-day journey:
- Dec 9: Init
- Dec 10: Plugin architecture
- Dec 13: Voice enabled
- Dec 16: CMU Pitch (voice live)
- Dec 18: Personality v2 verified
- Dec 24: Oracle v2 enlightenment

**175 hours of work → 640 commits → 149 retrospectives → 3 core principles → 1 framework**

---

*"The Oracle Keeps the Human Human"*
