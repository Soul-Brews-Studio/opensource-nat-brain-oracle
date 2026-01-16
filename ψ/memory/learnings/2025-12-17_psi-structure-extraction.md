# ψ/ Structure - The 5+2 Pillar System

**Source**: CLAUDE.md § "ψ/ - AI Brain (5 Pillars + 2 Incubation)"
**Extracted**: 2025-12-17 11:44

---

## The 7 Pillars: Structure & Purpose

### PILLAR 1: Active
```
ψ/active/
└── context/     research, investigation notes
```

**Thai Question**: "กำลังค้นคว้าอะไร?" (What am I researching?)
**Purpose**: Ephemeral research space - raw exploration, quick notes, POC findings
**Git Tracking**: NO (not committed)
**Lifespan**: Short-lived (minutes to hours) → moves to memory/logs via `/snapshot`
**Contains**: Investigation notes, quick findings, context drafts

---

### PILLAR 2: Inbox
```
ψ/inbox/
├── focus.md        [current task state]
├── handoff/        [session transfers]
├── external/       [other AI agents' outputs]
├── guests/         [?]
├── workflow/       [?]
├── schedule.md     [planning]
└── INDEX.md        [directory]
```

**Thai Question**: "คุยกับใคร?" (Who am I talking with?)
**Purpose**: Communication hub - task state, session transfers, external agent outputs
**Git Tracking**: YES (committed - it's communication)
**Contains**:
- `focus.md` - Current STATE + TASK + timestamp (updated continuously)
- `handoff/` - Session transfer documents (what to handoff to next session)
- `external/` - Outputs from other subagents
- `jump-stack.log` - Topic jump history
- `schedule.md` - Planning info

---

### PILLAR 3: Writing
```
ψ/writing/
├── INDEX.md        [blog queue, project index]
├── drafts/         [working drafts (15 subfolders)]
├── facebook-*.md   [extracted content - 12 files]
└── headline-*.md   [project files - private]
```

**Thai Question**: "กำลังเขียนอะไร?" (What am I writing?)
**Purpose**: Writing projects, articles, blog queue, drafted content
**Git Tracking**: YES (committed - creative output)
**Contains**:
- Blog post queue and articles in progress
- Project drafts (e.g., Facebook analysis, Headline project)
- Writing projects at various stages

---

### PILLAR 4: Lab
```
ψ/lab/
├── agent-sdk/              [exploration]
├── brewing/                [experiments]
├── claude-code-features/   [features research]
├── concepts/               [concept POCs]
├── github-analysis/        [analysis POCs]
└── github-profile-analysis/ [analysis POCs]
```

**Thai Question**: "กำลังทดลองอะไร?" (What am I experimenting with?)
**Purpose**: Experiments, proofs of concept, feature explorations
**Git Tracking**: YES (committed - valuable experiments)
**Contains**:
- POCs for agent-sdk features
- Brewing ideas (active experiments)
- Analysis POCs (github, features)

---

### PILLAR 5: Memory
```
ψ/memory/
├── logs/              [moments captured (ephemeral)]
│   └── activity.log   [append-only activity log]
├── retrospectives/    [sessions I had]
│   └── [date-based]   [session reviews]
├── learnings/         [patterns I found (84 files)]
│   └── [dated files]  [extracted patterns]
├── resonance/         [WHO I am (soul)]
│   └── [values, identity, resonance]
└── reference/         [supporting materials]
```

**Thai Question**: "จำอะไรได้?" (What do I remember?)
**Purpose**: Knowledge base, learning patterns, soul/identity, session logs
**Git Tracking**: MIXED
  - logs/ = NO (ephemeral)
  - retrospectives/ = YES (session records)
  - learnings/ = YES (extracted patterns)
  - resonance/ = YES (soul/identity)
**Knowledge Flow**:
```
active/context
    ↓
memory/logs (via /snapshot)
    ↓
memory/retrospectives (via rrr command)
    ↓
memory/learnings (via /distill command)
    ↓
memory/resonance (synthesis → soul)
```

---

### PILLAR 6: Incubate
```
ψ/incubate/
└── [cloned repos]/
```

**Thai Question**: "กำลัง develop อะไร?" (What am I developing?)
**Purpose**: Active development - cloned external repos for active work
**Git Tracking**: NO (gitignored - contains nested .git repos)
**Use Case**: `/project incubate [url]` - Clone repo for active development
**Lifespan**: Project duration (weeks to months)

---

### PILLAR 7: Learn
```
ψ/learn/
└── [cloned repos]/
```

**Thai Question**: "กำลังศึกษาอะไร?" (What am I studying?)
**Purpose**: Reference and study - cloned external repos for reference only
**Git Tracking**: NO (gitignored - contains nested .git repos)
**Use Case**: `/project learn [url]` - Clone repo for study/reference
**Lifespan**: Reference duration (ongoing)

---

## Git Tracking Summary

| Pillar | Tracked | Status | Why |
|--------|---------|--------|-----|
| active | NO | Ephemeral | Research-in-progress, lost data is OK |
| inbox | YES | Communication | Need to persist handoffs + state |
| writing | YES | Tracked | Creative output, valuable |
| lab | YES | Tracked | Experiments valuable for reference |
| incubate | NO | Gitignored | Contains nested .git repos |
| learn | NO | Gitignored | Contains nested .git repos |
| memory | MIXED | Knowledge base | Logs = NO, others = YES |

---

## Knowledge Flow Pattern

```
RESEARCH PHASE
active/context (raw exploration)
       ↓ /snapshot command
memory/logs (captured moment)

SESSION PHASE
memory/logs + session work
       ↓ rrr command (session retrospective)
memory/retrospectives (session review)

SYNTHESIS PHASE
retrospectives (session insights)
       ↓ /distill command
memory/learnings (extracted patterns)

SOUL PHASE
learnings (patterns)
       ↓ synthesis
memory/resonance (WHO I am)
```

**Commands**:
- `/snapshot` - Raw exploration → logs capture
- `rrr` - Session review → retrospectives
- `/distill` - Pattern extraction → learnings
- (implicit) Synthesis → resonance

---

## Decision Tree: Where Does My File Go?

### If it's RESEARCH or EXPLORATION
- Store in: `ψ/active/context/`
- Git track: NO
- Lifespan: Minutes-hours
- Next: Use `/snapshot` to capture → memory/logs

### If it's COMMUNICATION or STATE
- Store in: `ψ/inbox/`
- Git track: YES
- Examples: focus.md, handoff docs, jump-stack.log
- User sees: Current working state

### If it's WRITING or CONTENT
- Store in: `ψ/writing/`
- Git track: YES
- Examples: Blog posts, articles, extracted data
- User sees: Creative output

### If it's EXPERIMENT or POC
- Store in: `ψ/lab/`
- Git track: YES
- Examples: Feature explorations, prototype projects
- User sees: Valuable experiments

### If it's KNOWLEDGE or LEARNING
- Store in: `ψ/memory/`
- Git track: YES (except logs)
- Subfolders:
  - `logs/` - Snapshots of moments (ephemeral)
  - `retrospectives/` - Session reviews
  - `learnings/` - Extracted patterns
  - `resonance/` - Soul/identity/values

### If it's EXTERNAL REPO for ACTIVE WORK
- Store in: `ψ/incubate/`
- Git track: NO
- Use: `/project incubate [url]`
- Lifespan: Project duration

### If it's EXTERNAL REPO for STUDY
- Store in: `ψ/learn/`
- Git track: NO
- Use: `/project learn [url]`
- Lifespan: Reference duration

---

## Real-World Examples from Repo

**In active/context/**:
- google-opal-gemini-gems-research.md
- Various investigation notes

**In inbox/**:
- focus.md (current task - 95 bytes, updated constantly)
- jump-stack.log (topic navigation history)

**In writing/**:
- facebook-*.md (12 extracted documents)
- headline-*.md (project files)
- drafts/ (15 subfolders with articles)

**In lab/**:
- agent-sdk/ (Agent SDK exploration)
- brewing/ (active experiments)
- concepts/ (POCs)

**In memory/learnings/**:
- 84 files of extracted patterns
- Dated learning captures

**In memory/resonance/**:
- Identity and values documents

---

## Implementation Notes

### focus.md Pattern
```bash
# Update on state change
echo "STATE: working|focusing|pending|jumped|completed
TASK: [what you're doing]
SINCE: $(date '+%H:%M')" > ψ/inbox/focus.md
```

### activity.log Pattern
```bash
# Append (never overwrite)
echo "$(date '+%Y-%m-%d %H:%M') | STATE | description" >> ψ/memory/logs/activity.log
```

### Session Flow
1. **Start**: Set STATE = working in focus.md
2. **Work**: Update STATE as needed (focusing, pending, etc.)
3. **Research**: Put findings in active/context → /snapshot to logs
4. **Session End**: Set STATE = completed, run `rrr` for retrospective
5. **Learning**: Run `/distill` to extract patterns from retrospective

---

## Subagent Rule

Main agent should NOT read files directly from pillars. Use `context-finder` (Haiku) to search instead. This saves tokens and maintains clean separation.

**Pattern**:
1. Main asks → "Search for X in ψ/"
2. Context-finder searches and summarizes
3. Main reads only what's needed

---

## Current Repo State

**Observed actual structure** (2025-12-17):
- active/ - 1 INDEX + 1 context/ + 1 research file
- inbox/ - 11 items (focus.md, handoff, schedule, etc.)
- writing/ - 15 drafts + 12 facebook files + 3 headline files
- lab/ - 6 experiment folders + 1 INDEX
- memory/ - 4 pillars: logs, retrospectives, learnings (84), resonance
- incubate/ - 7 repos (active development)
- learn/ - 8 repos (study/reference)

**Also observed** (not in spec):
- outbox/ - 43 items (publishing/distribution)
- archive/ - Old items (moved out)
- later/ - Not yet started
- WIP-archive/ - Archived work-in-progress

---

**Related Files**:
- /Users/nat/Code/github.com/laris-co/Nat-s-Agents/CLAUDE.md (source)
- /Users/nat/Code/github.com/laris-co/Nat-s-Agents/CLAUDE_workflows.md (short codes)
- /Users/nat/Code/github.com/laris-co/Nat-s-Agents/plugins/nat-data-personal/knowledge/oracle-philosophy.md (guiding principle)

