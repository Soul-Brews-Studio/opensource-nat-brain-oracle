# /incubation System - Complete File Map

## File Location Tree

```
Nat-s-Agents/
│
├── .claude/
│   ├── commands/
│   │   ├── idea.md ..................... /idea command (reviews concepts)
│   │   ├── [incubate.md] ............... /incubate (NOT YET CREATED)
│   │   ├── snapshot.md ................. /snapshot (quick capture)
│   │   ├── rrr.md ...................... Create retrospective
│   │   └── (other commands)
│   │
│   └── agents/
│       ├── note-taker.md ............... Writes feelings/info/ideas to files
│       ├── context-finder.md ........... Search git/issues
│       └── (other agents)
│
├── ideas/
│   ├── INDEX.md ........................ Master index of all ideas
│   ├── 2025-12-09_voice-bridge.md ..... Active incubation project
│   ├── 2025-12-09_cellar.md ........... Active incubation project
│   ├── claude-voice-notify.md ......... GRADUATED status
│   └── 2025-12-09_claude-voice-notify.md  Original notes
│
├── ψ/lab/concepts/
│   ├── INDEX.md ........................ Concepts index
│   ├── 001-cross-repo-forward.md ...... GitHub Issue as bridge
│   ├── 002-content-type-commands.md ... /feeling, /info, /idea, /jump, /incubate
│   └── 003-[future].md
│
├── ψ/memory/retrospectives/
│   ├── 2025-12-12_project-incubation-patterns.md
│   │   └── Full pattern analysis + decisions
│   │
│   └── 2025-12/12/07.00-overnight-agents-concepts.md
│       └── Decision history + key insights
│
└── ψ/memory/logs/
    ├── feelings/
    │   ├── INDEX.md
    │   └── YYYY-MM-DD_HH-MM_[slug].md
    │
    └── info/
        ├── INDEX.md
        └── YYYY-MM-DD_HH-MM_[slug].md
```

---

## Key Files: Content & Purpose

### 1. CONCEPT: 002-content-type-commands.md

**Location**: `ψ/lab/concepts/002-content-type-commands.md`

**Contains**:
- Definition of 5 commands (/feeling, /info, /idea, /jump, /incubate)
- Status for each command (💡 idea, 🔬 testing, ✅ done)
- Example usage
- Implementation checklist

**Key Line**:
```
| `/incubate` | 🥚 | Ready to move to new repo | GitHub Issue |
```

**Status**: 💡 Idea (not yet implemented)

---

### 2. AGENT: note-taker.md

**Location**: `.claude/agents/note-taker.md`

**What it does**:
- Input: Type (feeling/info/idea) + Content + Context
- Action: Creates file, updates INDEX.md
- Output: File path + confirmation

**Storage Mapping**:
- **feeling** → `ψ/memory/logs/feelings/YYYY-MM-DD_HH-MM_[slug].md`
- **info** → `ψ/memory/logs/info/YYYY-MM-DD_HH-MM_[slug].md`
- **idea** → `ψ/lab/concepts/NNN-[slug].md`

**File Format** (idea example):
```markdown
# Concept: {Title}

**Status**: 💡 Idea
**Created**: YYYY-MM-DD

## Idea

{Content}

## Context

{Context if provided}
```

**INDEX Update**: Appends new row with date, slug, summary, status

---

### 3. COMMAND: idea.md

**Location**: `.claude/commands/idea.md`

**Usage**:
```
/idea                    → List all concepts
/idea [concept]          → Log new idea
```

**Mode 1: No Arguments**
- Reads `ψ/lab/concepts/INDEX.md`
- Shows all concepts with status
- Stats (total, by status)

**Mode 2: With Arguments**
- Calls note-taker agent
- Creates new concept file
- Updates INDEX

---

### 4. IDEA: 2025-12-09_voice-bridge.md

**Location**: `ideas/2025-12-09_voice-bridge.md`

**Content**:
- Status: Idea (active design)
- What it does: STT → Terminal injection
- Tech Stack: Tauri + Whisper/Vosk + SQLite
- Why needed: Local voice capture (no AI cost)
- Next steps: Research + prototype
- Decision: Separate repo or incubate here?

**Related Projects**:
- claude-voice-notify (notifications)
- cellar (storage partner)

---

### 5. IDEA: 2025-12-09_cellar.md

**Location**: `ideas/2025-12-09_cellar.md`

**Content**:
- Status: Idea (active design)
- What it does: System tray app + SQLite
- Name origin: "Cellar" = store good things underground
- Use cases: Logger / Task tracker / Unified brain
- Tech Stack: Flutter + sqflite
- Next steps: Choose primary use case
- Decision: Separate repo or incubate here?

**Related Projects**:
- voice-bridge (could feed data)
- claude-voice-notify (notification side)

---

### 6. REPORT: 2025-12-12_project-incubation-patterns.md

**Location**: `ψ/memory/retrospectives/2025-12-12_project-incubation-patterns.md`

**Content**:
- Overview of all 3 projects (voice-notify, voice-bridge, cellar)
- Incubation philosophy & patterns
- Ideas folder structure
- Decisions pending for each project
- Commands in development
- Timeline summary
- Related tools reference

**Key Section**: "Incubation Philosophy"
```
1. Date-prefixed markdown: YYYY-MM-DD_name.md
2. Tracked in ideas/INDEX.md
3. Decision point: "Separate repo or incubate?"
4. When graduated: Symlinks back to main repo
5. Main repo references new repo via GitHub URLs
```

---

### 7. RETRO: 07.00-overnight-agents-concepts.md

**Location**: `ψ/memory/retrospectives/2025-12/12/07.00-overnight-agents-concepts.md`

**Content**:
- 11 commits breakdown
- Key decisions:
  - ψ/lab/concepts/ for unproven ideas (vs memory/learnings)
  - note-taker uses Opus (not Haiku)
  - Trimmed commands (removed /random, /explore)
  - /low-context concept for smart selection
- Overnight session highlights
- AI diary & honest feedback
- Files reference table

**Key Insight**:
> "Oracle keeps the human human - AI proposes, human decides"

---

### 8. IDEAS INDEX: INDEX.md

**Location**: `ideas/INDEX.md`

**Content**:
- Master list of all ideas in incubation
- Sections: Active Ideas, Graduated, Archived
- Table with: File, Status, Last Update

**Current State**:
- Active: voice-bridge (still in idea stage)
- Graduated: (none yet, voice-notify moved to separate repo)
- Archived: (none yet)

**Format Example**:
```markdown
| File | Status | Last Update |
|------|--------|-------------|
| 2025-12-09_voice-bridge.md | Idea | 2025-12-09 12:20 |
```

---

## Data Flow Diagram

```
USER INTERACTION
  │
  ├─ /feeling (emotion) ────┐
  ├─ /info (raw data) ──────┤─→ note-taker agent
  ├─ /idea (concept) ───────┤
  └─ /incubate (graduate) ──┘

note-taker
  │
  ├─ Feeling ────→ ψ/memory/logs/feelings/ + INDEX
  ├─ Info ───────→ ψ/memory/logs/info/ + INDEX
  ├─ Idea ───────→ ψ/lab/concepts/ + INDEX
  └─ [Incubate route - TBD]

ψ/lab/concepts/
  │
  ├─ /idea command (list/review)
  │
  └─ Future: /incubate command
      └─ Creates GitHub Issue
      └─ Marks idea as "ready for graduation"
      └─ Can move to separate repo with symlinks

GRADUATION PATTERN (voice-notify example)
  │
  ├─ 2025-12-09: Idea created in ideas/
  ├─ 2025-12-09: Moved to ideas/2025-12-09_voice-notify.md
  ├─ 2025-12-09: Created separate repo (claude-voice-notify)
  ├─ 2025-12-09: Symlinks created in Nat-s-Agents/scripts/
  └─ 2025-12-12: Documented in retrospective
```

---

## Implementation Checklist

### Phase 1: Create /incubate Command (PENDING)

- [ ] Create `.claude/commands/incubate.md`
- [ ] Define command syntax & usage
- [ ] Link to GitHub Issue creation
- [ ] Add to this documentation

**File Template**:
```markdown
---
description: Signal that an idea is ready for separate repo
allowed-tools:
  - Bash
  - Task
---

# /incubate - Mark Idea for Graduation

Usage: /incubate [project-name] --repo [github-repo]

(Details to be filled in)
```

---

### Phase 2: Test with Real Projects

- [ ] Test with voice-bridge
  - [ ] Create separate repo
  - [ ] Move idea file
  - [ ] Create symlinks
  - [ ] Update ideas/INDEX.md

- [ ] Test with cellar
  - [ ] Create separate repo
  - [ ] Move idea file
  - [ ] Create symlinks
  - [ ] Update ideas/INDEX.md

---

### Phase 3: Refine Workflow

- [ ] Document graduation checklist
- [ ] Create symlink strategy guide
- [ ] Track graduated projects in retrospectives
- [ ] Add /incubate to CLAUDE.md
- [ ] Update all related documentation

---

## File Sizes Reference

```
002-content-type-commands.md ........... ~0.8 KB (concept definition)
note-taker.md ......................... ~3.4 KB (agent implementation)
idea.md .............................. ~1.5 KB (command definition)
2025-12-09_voice-bridge.md ........... ~2.8 KB (idea details)
2025-12-09_cellar.md ................. ~4.2 KB (idea details)
2025-12-12_project-incubation-patterns.md ... ~12 KB (full report)
07.00-overnight-agents-concepts.md ..... ~8.5 KB (session retrospective)
ideas/INDEX.md ........................ ~0.5 KB (index only)
```

---

## Command Status Summary

| Command | File | Status | Location |
|---------|------|--------|----------|
| `/idea` | idea.md | ✅ Implemented | `.claude/commands/` |
| `/incubate` | [TBD].md | 🥚 Concept | `ψ/lab/concepts/002` |
| `/feeling` | [TBD].md | 🥚 Concept | `ψ/lab/concepts/002` |
| `/info` | fyi.md | ✅ Similar | `.claude/commands/` |
| `/jump` | jump.md | ✅ Implemented | `.claude/commands/` |

---

## Search Tips

Find all incubation files:
```bash
# Find all idea files
find ideas/ -name "*.md"

# Find all concepts
find ψ/lab/concepts/ -name "*.md"

# Find incubation mentions
grep -r "incubat" ψ/ .claude/ --include="*.md"

# Find graduated projects
grep -r "GRADUATED\|MIGRATED" . --include="*.md"
```

---

## Next Action

**FOR IMMEDIATE IMPLEMENTATION**:

1. Create `.claude/commands/incubate.md` based on template
2. Define the exact workflow:
   - Syntax: `/incubate [name] --repo [org/repo]`
   - Creates GitHub Issue in target repo
   - Updates ideas/INDEX.md
   - Creates symlinks (optional automation)

3. Test with voice-bridge:
   ```bash
   /incubate voice-bridge --repo nazt/voice-bridge
   ```

**Timeline**: Can be done after workshop SIIT (Dec 12)

