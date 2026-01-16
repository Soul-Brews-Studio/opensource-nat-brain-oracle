# Root Documentation Cleanup Analysis

**Date**: 2025-12-23  
**Scope**: 13 root .md files  
**Total Lines**: 3,586  

---

## CANONICAL vs DEPRECATED (with Evidence)

### TIER 1: CANONICAL DOCS (Keep / Maintain)

#### 1. CLAUDE.md (292 lines)
**Status**: CANONICAL  
**Last Modified**: 2025-12-17 14:30 (6 days ago)  
**Purpose**: Hub document with modular navigation to other CLAUDE_* files  
**Evidence**:
- Explicitly states "Modular Documentation: This is the lean hub"
- Links to all CLAUDE_* files with priority ratings
- Required reading "Every session start" per CLAUDE.md itself
- Referenced by other docs as canonical source
- Most recent update: Added multi-agent sync rules
**Cleanup Action**: KEEP - This is the entry point

#### 2. CLAUDE_safety.md (62 lines)
**Status**: CANONICAL  
**Last Modified**: 2025-12-10 22:31 (13 days ago)  
**Purpose**: Critical safety rules for git/file operations  
**Evidence**:
- Referenced from CLAUDE.md with 🔴 "Required" priority
- Covers force flags, push rules, temp files, logging
- No deprecation markers, actively referenced
**Cleanup Action**: KEEP - Safety critical

#### 3. CLAUDE_workflows.md (187 lines)
**Status**: CANONICAL  
**Last Modified**: 2025-12-14 02:20 (9 days ago)  
**Purpose**: Short codes (rrr, /snapshot, /jump), context management  
**Evidence**:
- Referenced from CLAUDE.md with 🟡 "As needed" priority
- Defines active workflow patterns
- Archive pattern (ψ/WIP-archive) documented here
**Cleanup Action**: KEEP - Active workflows

#### 4. CLAUDE_subagents.md (165 lines)
**Status**: CANONICAL  
**Last Modified**: 2025-12-17 14:20 (6 days ago)  
**Purpose**: All 11 subagent definitions  
**Evidence**:
- Referenced from CLAUDE.md with 🟡 "Before spawning agents" priority
- Recently updated (agent-status added 2025-12-17)
- Contains current thresholds (file size, etc.)
**Cleanup Action**: KEEP - Active reference

#### 5. CLAUDE_lessons.md (59 lines)
**Status**: CANONICAL  
**Last Modified**: 2025-12-12 08:47 (11 days ago)  
**Purpose**: Patterns learned, anti-patterns  
**Evidence**:
- Referenced from CLAUDE.md with 🟢 "Reference" priority
- No redundancy with learnings/ folder (which goes deeper)
- Condensed key lessons
**Cleanup Action**: KEEP - Decision reference

#### 6. CLAUDE_templates.md (335 lines)
**Status**: CANONICAL  
**Last Modified**: 2025-12-10 22:35 (13 days ago)  
**Purpose**: Retrospective template, commit format, issue templates  
**Evidence**:
- Referenced from CLAUDE.md with 🟢 "Reference" priority
- Actively used for session structure (rrr command)
- Defined commit message format
**Cleanup Action**: KEEP - Operational standard

#### 7. TEAM_SYSTEM_MANIFEST.md (287 lines)
**Status**: CANONICAL  
**Last Modified**: 2025-12-18 11:35 (5 days ago)  
**Purpose**: Team logging system (BM + Ampere integration)  
**Evidence**:
- Most recently modified root doc
- Status: "Production Ready v1.0"
- Contains: Script location, team namespace commands, usage examples
- Self-contained system for team interaction
**Cleanup Action**: KEEP - Active system

---

### TIER 2: SUPPORTING DOCS (Keep / Reference)

#### 8. QUICKSTART.md (320 lines)
**Status**: CANONICAL (Secondary)  
**Last Modified**: 2025-12-16 18:10 (7 days ago)  
**Purpose**: 15-minute onboarding for new users  
**Evidence**:
- Explicit purpose: "Get you working... in 15 minutes"
- Distinct from CLAUDE.md (quick start vs comprehensive reference)
- TL;DR format + demo (CMU pitch)
- No redundancy: CLAUDE.md → QUICKSTART.md is intentional flow
**Cleanup Action**: KEEP - Onboarding/discovery

#### 9. ARCHITECTURE.md (766 lines)
**Status**: CANONICAL (Technical)  
**Last Modified**: 2025-12-16 17:56 (7 days ago)  
**Purpose**: System design, agent flow, philosophy  
**Evidence**:
- Most comprehensive doc (766 lines)
- Recently updated (Dec 16)
- Covers: Agent architecture, Oracle philosophy, ψ/ structure, learnings flow
- References CLAUDE.md as "Core instructions"
- Knowledge architecture documented here (compounds, patterns, etc.)
**Cleanup Action**: KEEP - Technical reference

#### 10. MARKDOWN_CATALOG.md (498 lines)
**Status**: CANONICAL (Meta-documentation)  
**Last Modified**: 2025-12-11 09:39 (12 days ago)  
**Purpose**: Index of all 106 markdown files across repo  
**Evidence**:
- Generated document (snapshot of state)
- Helps navigate the sprawl
- Last update: "Round 3: Final Structure"
- No active maintenance, but useful reference
**Note**: Could be auto-generated via script, but currently hand-maintained
**Cleanup Action**: KEEP - But mark as "Reference only, may be outdated"

---

### TIER 3: DEPRECATED / ARCHIVE (Recommend Removal or Consolidation)

#### 11. MAW-AGENTS.md (51 lines)
**Status**: DEPRECATED  
**Last Modified**: No recent commits found (not in last 30 commits)  
**Purpose**: "MAW" (Multi-Agent Workbench) - appears to be old iteration docs  
**Evidence**:
- No git history shown (predates recent commits)
- Content appears to be notes about agent structure
- MAW-AGENTS.md is shorter than any CLAUDE_* file
- Content likely consolidated into CLAUDE_subagents.md
**Cleanup Action**: MOVE TO ARCHIVE (check content first)

#### 12. MAW-COMPLETE-SYSTEM.md (295 lines)
**Status**: DEPRECATED  
**Last Modified**: No recent commits found (not in last 30 commits)  
**Purpose**: "MAW Complete System - All 10 Iterations Consolidated"  
**Evidence**:
- No git history in recent commits
- Contains iteration notes (1-10) about agent signal patterns
- Content appears to be historical documentation of development process
- Knowledge likely captured in CLAUDE.md + current best practices
**Cleanup Action**: MOVE TO ARCHIVE (valuable for history, not active reference)

#### 13. workflow-evolution-story.md (269 lines)
**Status**: DEPRECATED / ARCHIVE  
**Last Modified**: 2025-12-17 11:46 (6 days ago) commit: "docs: complete philosophy feeding iteration 2 (maw deep dive)"  
**Purpose**: Historical narrative of workflow evolution  
**Evidence**:
- Labeled as "evolution story" in filename
- Describes past iterations ("deep dive into MAW")
- Not referenced from any other file
- Knowledge should be in CLAUDE_workflows.md or ARCHITECTURE.md
**Cleanup Action**: MOVE TO ARCHIVE / Consider: Keep only if useful for onboarding history

---

## RECOMMENDATIONS

### ACTION PLAN

**REMOVE (Move to `archive/` folder)**:
1. `MAW-AGENTS.md` - Consolidate into CLAUDE_subagents.md
2. `MAW-COMPLETE-SYSTEM.md` - Historical, move to archive/
3. `workflow-evolution-story.md` - Historical, move to archive/ or reference in ARCHITECTURE.md

**KEEP IN ROOT**:
- CLAUDE.md (Hub)
- CLAUDE_safety.md (Safety critical)
- CLAUDE_workflows.md (Active reference)
- CLAUDE_subagents.md (Active reference)
- CLAUDE_lessons.md (Quick patterns)
- CLAUDE_templates.md (Operational standard)
- TEAM_SYSTEM_MANIFEST.md (Active system)
- QUICKSTART.md (Onboarding)
- ARCHITECTURE.md (Technical reference)
- MARKDOWN_CATALOG.md (Meta index)

**Resulting: 10 files (3,319 lines) vs 13 files (3,586 lines)**  
**Reduction: -267 lines, cleaner root**

### EVIDENCE FOR DEPRECATION

| File | Reason | Certainty |
|------|--------|-----------|
| MAW-AGENTS.md | No commits in 30 days, short, likely consolidated | HIGH |
| MAW-COMPLETE-SYSTEM.md | Iteration docs (old process), no recent commits | HIGH |
| workflow-evolution-story.md | Labeled "story", historical MAW deep dive | MEDIUM |

**Note on Uncertainty**: `workflow-evolution-story.md` has recent commit (Dec 17) but it's about past iterations. User should decide if narrative value justifies keeping.

---

## STRUCTURAL ISSUES IDENTIFIED

1. **MAW- prefix files**: Suggest abandoned "Multi-Agent Workbench" project naming. Should be archived to reduce confusion.
2. **Naming inconsistency**: 
   - `CLAUDE_*.md` = Modular instruction docs (clear hierarchy)
   - `MAW-*.md` = Old iteration docs (should be in history folder)
   - `workflow-evolution-story.md` = Narrative doc (should link from ARCHITECTURE.md instead)

3. **Discovery problem**: New user might read 3 different docs:
   - QUICKSTART.md (entry)
   - CLAUDE.md (reference)
   - ARCHITECTURE.md (deep dive)
   - workflow-evolution-story.md (confuses with history)

**Solution**: Make CLAUDE.md even more explicit: "See QUICKSTART.md for 15-min onboarding, ARCHITECTURE.md for system design, archived/* for iteration history"

---

## FILE METRICS SUMMARY

| Category | Files | Lines | Status |
|----------|-------|-------|--------|
| CLAUDE_* (Instructions) | 6 | 1,015 | CANONICAL |
| QUICKSTART + ARCHITECTURE | 2 | 1,086 | CANONICAL |
| MARKDOWN_CATALOG (Meta) | 1 | 498 | SUPPORTING |
| TEAM_SYSTEM_MANIFEST | 1 | 287 | CANONICAL |
| **DEPRECATED (MAW-*)** | **3** | **615** | ARCHIVE |
| **TOTAL** | **13** | **3,586** | |
