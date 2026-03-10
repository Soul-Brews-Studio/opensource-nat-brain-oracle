# TEMPLATE EVOLUTION ANALYSIS: Nat's Repos

## Timestamp: 2025-12-17 21:58 UTC

---

## EXECUTIVE SUMMARY

Nat's repos show THREE DISTINCT TEMPLATE GENERATIONS across the laris-co organization, evolving from early experimentation to sophisticated modular systems:

1. **Gen 1 (Early)**: Simple `CLAUDE.md` only (ccc/nnn/lll/rrr pattern)
2. **Gen 2 (Mid)**: `CLAUDE.md` + `.specify/` (templates + memory structure)
3. **Gen 3 (Latest)**: Modular `CLAUDE.md` + `.claude/` (agents + commands + skills)

---

## REPOSITORY CLASSIFICATION

### Gen 3: LATEST (Modular Hub-and-Spoke)
**Nat-s-Agents** (Main)
- Lines: 292 CLAUDE.md
- Structure: Navigation table + modular linked docs (CLAUDE_safety.md, CLAUDE_workflows.md, etc)
- Folders: `.claude/agents/`, `.claude/commands/`, `.claude/skills/`, `.claude/hooks/`
- Philosophy: Lean hub referencing detailed satellite docs
- Pattern: Focus on "when to read" + priority levels
- Focus: Multi-agent sync, subagent delegation, ψ/ (psi) brain structure
- **Newest addition**: ψ/ five-pillar system (active, inbox, writing, lab, memory)
- Status: LIVING SYSTEM (last update Dec 17)

### Gen 2: MIDDLE (Extended Specification)
**esphome-heating-visualizer** (Oct 2024)
- CLAUDE.md: 592 lines (comprehensive)
- `.specify/`: memory/, scripts/, templates/ (5 template files)
- `.claude/commands/`: 23 command files (maw.* + speckit.*)
- Hybrid approach: Detailed CLAUDE.md + external templates
- Pattern: ccc/nnn/gogogo/lll/rrr + speckit (analyze/checklist/clarify/constitution)
- Status: STABLE (last update Oct 11)

**esphome-fw** (Oct 2024)
- CLAUDE.md: 57 lines (lightweight)
- `.specify/`: memory/, scripts/, templates/ (6 template files)
- `.claude/`: empty shell
- Pattern: Similar to esphome-heating-visualizer but minimal CLAUDE.md
- Status: STABLE

**esphome-radar** (Oct 2024)
- CLAUDE.md: 46 lines (minimal)
- `.specify/`: memory/, scripts/, templates/
- Pattern: Same .specify/ structure as siblings
- Status: STABLE

**esphome-floodboy-4g** (No CLAUDE.md)
- `.specify/`: Only repo with PURE .specify/ (no CLAUDE.md)
- Pattern: Oldest .specify/ user
- Status: ARCHIVED/REFERENCE

### Gen 1: EARLY (Simple Hub)
**multi-agent-workflow-kit** (Oct 2024)
- Lines: 559 CLAUDE.md (comprehensive)
- Structure: TOC + 12 major sections
- `.claude/`: Empty (just .gitignore)
- Pattern: All-in-one CLAUDE.md, no modular split
- Status: PROOF OF CONCEPT

**proof-maw-multi-agent-worktree-kit** (Oct 2024)
- Lines: 559 CLAUDE.md (IDENTICAL to multi-agent-workflow-kit)
- Structure: Clone of multi-agent-workflow-kit
- `.claude/`: Empty shell (just .gitignore)
- Pattern: Prototype multi-agent setup
- Status: PROOF OF CONCEPT

**00_mz_forwarder** (Oct 2024)
- Lines: 766 CLAUDE.md (largest single file)
- Structure: Comprehensive + appendices
- `.claude/`: Empty (just settings.local.json)
- Pattern: All-in-one approach
- Status: STABLE

**00_mz_forwarder** (Experimental)
- Has CLAUDE.md (766 lines)
- Has `.claude/` shell with `settings.local.json` (security config)
- Pattern: Transitioning between eras
- Status: AGING

### LEGACY / MINIMAL
**claude-voice-notify** (68 lines)
- Minimal CLAUDE.md
- Pattern: Single-file guideline
- Status: TINY/UTILITY

**headline-analyzer** (13 lines)
- Minimal stub
- Pattern: Placeholder
- Status: STUB

**0xkm** (large repo)
- Has `.claude/` but not examined
- Pattern: Unknown

**obsidian-vault** (Oct 2024)
- Has `.claude/` but not examined
- Pattern: Unknown

---

## EVOLUTION TIMELINE

```
Oct 2024 (Early)
├── proof-maw-multi-agent-worktree-kit [Gen 1: 559 lines, all-in-one]
├── multi-agent-workflow-kit           [Gen 1: 559 lines, all-in-one]
├── 00_mz_forwarder                    [Gen 1: 766 lines, largest]
└── esphome-* (first three)
    ├── esphome-heating-visualizer     [Gen 2: 592 lines + .specify/]
    ├── esphome-fw                     [Gen 2: 57 lines + .specify/]
    ├── esphome-radar                  [Gen 2: 46 lines + .specify/]
    └── esphome-floodboy-4g            [Gen 2: .specify/ only]

Dec 2024 (Refinement)
├── Nat-s-Agents evolves from Gen 2 → Gen 3 (modular hub)
└── Experimenting with:
    ├── CLAUDE_*.md split files
    ├── .claude/agents/, .claude/commands/, .claude/skills/
    └── ψ/ brain structure (5 pillars)

Dec 2025 (CURRENT)
└── Nat-s-Agents         [Gen 3: 292 lines (lean), modular + ψ/]
```

---

## KEY INSIGHTS: EVOLUTION PATTERN

### Observation 1: SIZE COMPRESSION
- Gen 1 (all-in-one): 559-766 lines in single file
- Gen 2 (hybrid): 46-592 lines + `.specify/` templates
- Gen 3 (modular): 292 lines + multiple CLAUDE_*.md files

**Pattern**: As complexity grows, split into specialized files

### Observation 2: TEMPLATE STORAGE
- Gen 1: No dedicated templates (embedded in CLAUDE.md or elsewhere)
- Gen 2: `.specify/templates/` (5-7 MD files per repo)
- Gen 3: No `.specify/` in Nat-s-Agents (why? ψ/ replaces it?)

**Question**: Did ψ/ memory/ replace `.specify/templates/`?

### Observation 3: COMMAND STORAGE
- Gen 1: No `.claude/commands/` directory
- Gen 2: `.specify/` + `.claude/commands/` (23 command files in heating-viz)
- Gen 3: `.claude/commands/` + `.claude/agents/` + `.claude/skills/`

**Pattern**: Moving toward role-based organization (agents/commands/skills)

### Observation 4: SAFETY RULES
- Gen 1 (multi-agent-kit): Embedded in CLAUDE.md
- Gen 2 (esphome-*): Embedded in CLAUDE.md
- Gen 3 (Nat-s-Agents): SEPARATED into `CLAUDE_safety.md`

**Pattern**: Most critical docs get their own file

### Observation 5: PHILOSOPHY DOCUMENTS
- Gen 1: None explicit
- Gen 2: None explicit
- Gen 3: Oracle philosophy embedded in main + reference to `plugins/nat-data-personal/`

**Pattern**: Personal AI philosophy becoming explicit

---

## STRUCTURAL COMPARISON

### Gen 1 Structure (all-in-one)
```
repo/
└── CLAUDE.md [559-766 lines]
    ├── Table of Contents
    ├── Executive Summary
    ├── Quick Start Guide
    ├── Project Context
    ├── Critical Safety Rules
    ├── Development Environment
    ├── Development Workflows
    ├── Context Management & Short Codes (ccc/nnn/lll/rrr)
    ├── Technical Reference
    ├── Development Practices
    ├── Lessons Learned
    ├── Troubleshooting
    └── Appendices
```

### Gen 2 Structure (hybrid)
```
repo/
├── CLAUDE.md [46-592 lines]
│   ├── (same TOC as Gen 1)
├── .specify/ [NEW!]
│   ├── templates/
│   │   ├── agent-file-template.md
│   │   ├── checklist-template.md
│   │   ├── plan-template.md
│   │   ├── spec-template.md
│   │   └── tasks-template.md
│   ├── scripts/
│   └── memory/
└── .claude/ [shell]
    └── commands/ [23 files]
        ├── maw.agents-create.md
        ├── maw.codex.md
        ├── maw.sync.md
        ├── speckit.analyze.md
        ├── speckit.checklist.md
        ├── speckit.clarify.md
        └── ... (18 more)
```

### Gen 3 Structure (modular)
```
repo/
├── CLAUDE.md [292 lines, LEAN HUB]
│   ├── Navigation (TABLE: which file, when to read, priority)
│   ├── Golden Rules (9 bullets)
│   ├── Multi-Agent Sync (IMPORTANT!)
│   ├── Subagent Delegation (Context Efficiency)
│   ├── Session Activity (Focus + Activity Log)
│   ├── File Access Rules
│   ├── Oracle Philosophy
│   ├── Short Codes (rrr, /snapshot, /distill, etc)
│   └── Subagents Quick Reference
│
├── CLAUDE_safety.md [NEW! Critical + actionable]
│   ├── PR workflow
│   ├── Git operations
│   └── Force flags rules
│
├── CLAUDE_workflows.md [NEW! Process docs]
│   ├── Short code definitions
│   └── Context management
│
├── CLAUDE_subagents.md [NEW! Agent registry]
│   ├── Agent table (model, purpose)
│   └── Detailed descriptions
│
├── CLAUDE_lessons.md [NEW! Learnings]
│
├── CLAUDE_templates.md [NEW! Templates]
│   ├── Retrospective template
│   ├── Commit format
│   └── Issue templates
│
├── .claude/ [RICH ECOSYSTEM]
│   ├── agents/ [18 subdirs]
│   │   └── agent-name/
│   │       └── (agent-specific config)
│   │
│   ├── commands/ [41 files!]
│   │   └── command-name.md
│   │
│   ├── skills/ [6+ files]
│   │
│   ├── hooks/ [git hooks]
│   │
│   ├── scripts/ [automation]
│   │
│   └── settings.json
│       settings.local.json
│
└── ψ/ [NEW! AI Brain, 5 Pillars]
    ├── active/
    ├── inbox/
    ├── writing/
    ├── lab/
    ├── memory/
    ├── incubate/ [cloned repos]
    └── learn/ [cloned repos]
```

---

## TEMPLATE TYPES ACROSS GENERATIONS

### CLAUDE.md CONTENT EVOLUTION

| Topic | Gen 1 | Gen 2 | Gen 3 |
|-------|-------|-------|-------|
| **Safety Rules** | Embedded | Embedded | CLAUDE_safety.md (separated) |
| **Workflows** | Embedded | Embedded | CLAUDE_workflows.md (separated) |
| **Subagents** | None | None | CLAUDE_subagents.md (registry) |
| **Lessons** | "Lessons Learned" section | "Lessons Learned" section | CLAUDE_lessons.md (file) |
| **Templates** | None | .specify/templates/ | CLAUDE_templates.md (file) |
| **Philosophy** | Implicit | Implicit | Explicit (Oracle Philosophy) |
| **Multi-Agent** | Not addressed | Not addressed | Detailed (sync pattern) |
| **ψ/ Brain** | Not present | Not present | NEW (5-pillar system) |
| **Focus State** | Not tracked | Not tracked | ψ/inbox/focus.md (tracked) |

---

## KEY TEMPLATE FILES IDENTIFIED

### Gen 3 (Nat-s-Agents) Templates:
1. **Retrospective Template** - Session reflection format
2. **Commit Format** - Git commit message structure
3. **Issue Templates** - GitHub issue creation
4. **Agent File Template** - Agent directory/file structure
5. **Checklist Template** - Task tracking
6. **Plan Template** - Implementation planning
7. **Spec Template** - Technical specification
8. **Tasks Template** - Detailed task breakdown

### Gen 2 (esphome-*) Templates (in `.specify/templates/`):
- agent-file-template.md
- checklist-template.md
- plan-template.md
- spec-template.md
- tasks-template.md

### Gen 1: No explicit templates (use CLAUDE.md sections as templates)

---

## CRITICAL DIFFERENCES

### CLAUDE.md Philosophy

| Aspect | Gen 1 | Gen 2 | Gen 3 |
|--------|-------|-------|-------|
| **Intended Size** | Comprehensive (500-700 lines) | Comprehensive (50-600 lines) | Lean (292 lines) |
| **Primary Purpose** | Complete reference | Complete reference | Navigation hub only |
| **Delegation** | All knowledge in file | All knowledge in file | Links to satellite docs |
| **Modularity** | Monolithic | Monolithic | Highly modular |
| **First Read** | Entire doc | Entire doc | CLAUDE.md + relevant satellites |
| **Update Frequency** | Medium | Medium | HIGH (ψ/ logs + CLAUDE.md changes) |
| **Subagent Aware** | No | No | YES (delegation patterns!) |
| **Multi-Worktree** | No | No | YES (git -C patterns!) |

### Folder Structure Philosophy

| Aspect | Gen 1 | Gen 2 | Gen 3 |
|--------|-------|-------|-------|
| **Settings** | None | Not tracked | .claude/settings.json |
| **Commands** | None | .claude/commands/ (23 files) | .claude/commands/ (41 files) |
| **Templates** | None | .specify/templates/ | ψ/writing/ + CLAUDE_templates.md |
| **Memory** | None | .specify/memory/ | ψ/memory/ (tracked) |
| **Brain** | None | None | ψ/ (5 pillars, gitignored) |
| **Scripts** | None | .specify/scripts/ | .claude/scripts/ |
| **Hooks** | None | None | .claude/hooks/ |
| **Agents** | None | None | .claude/agents/ (18 subagents!) |

---

## QUESTIONS FOR NAT

1. **Why no `.specify/` in Nat-s-Agents?**
   - Did `ψ/memory/` + `CLAUDE_templates.md` replace it?
   - Or is it intentional separation (specs for teams, ψ/ for personal)?

2. **Why is Nat-s-Agents CLAUDE.md only 292 lines?**
   - Is this the "target state" for all repos?
   - Should Gen 2 repos (esphome-*) be refactored to Gen 3?

3. **The ψ/ structure (5 pillars) - is this portable?**
   - Can it be templated for other repos?
   - Or is it personal-only (Nat-s-Agents specific)?

4. **Command files explosion (23 → 41)?**
   - What new commands were added to Nat-s-Agents?
   - Are they agent-specific or universal?

5. **Subagent delegation pattern - is this new?**
   - This seems like a major innovation in Gen 3
   - Should it be backported to Gen 2 repos?

---

## RECOMMENDATIONS

### For Immediate Clarity:
1. Document which repos are **templates** vs **living systems**
   - Gen 1: Proof of concepts (can archive?)
   - Gen 2: Stable subprojects (esphome-*)
   - Gen 3: Active main system (Nat-s-Agents)

2. Create migration guide: Gen 2 → Gen 3
   - `.specify/` → `ψ/` + `CLAUDE_*.md`
   - Consolidate `.claude/commands/` organization
   - Add `.claude/agents/` for subagent support

3. Standardize on folder structure
   - All repos should have:
     - `CLAUDE.md` (hub)
     - `.claude/commands/` (documented)
     - `.claude/hooks/` (safety)
     - Either `.specify/` (team) OR `ψ/` (personal)

### For Future:
4. Consider `.claude/` as standard across all org repos
   - Already exists in 11/20 laris-co repos
   - `.specify/` exists in only 4 (esphome + floodboy)
   - `.claude/` is the winning pattern

5. ψ/ might not be universal
   - Seems tailored to Nat's personal workflow
   - Don't force it on team repos
   - Keep `.specify/` for team/project-specific needs

---

## SUMMARY TABLE

| Repo | Gen | CLAUDE.md Lines | Has .claude/ | Has .specify/ | Status | Last Updated |
|------|-----|---|---|---|---|---|
| Nat-s-Agents | 3 | 292 | YES (rich) | NO | LIVING | Dec 17 |
| esphome-heating-viz | 2 | 592 | YES (minimal) | YES | STABLE | Oct 11 |
| multi-agent-workflow-kit | 1 | 559 | EMPTY | NO | POC | Oct 10 |
| proof-maw-* | 1 | 559 | EMPTY | NO | POC | Oct 10 |
| 00_mz_forwarder | 1 | 766 | EMPTY | NO | STABLE | Oct 28 |
| esphome-fw | 2 | 57 | EMPTY | YES | STABLE | Oct 11 |
| esphome-radar | 2 | 46 | EMPTY | YES | STABLE | Oct 10 |
| esphome-floodboy-4g | 2 | NONE | NONE | YES | STABLE | Oct 10 |
| claude-voice-notify | 1 | 68 | NONE | NO | UTILITY | Oct 10 |
| headline-analyzer | 1 | 13 | NONE | NO | STUB | Oct 10 |

