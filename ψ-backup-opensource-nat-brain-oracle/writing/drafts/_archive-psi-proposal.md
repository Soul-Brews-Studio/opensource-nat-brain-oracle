# Proposal: ψ-Folder Organization

> **Author**: Claude Opus 4.5
> **Date**: 2025-12-11
> **Status**: Draft for Review

---

## Executive Summary

The ψ-* folders form the **knowledge layer** of Nat's Agents. This proposal reorganizes them into a clear **lifecycle flow** with explicit persistence rules.

**Key Changes**:
1. Track `ψ-learnings/` and `ψ-retrospectives/` in git (permanent knowledge)
2. Keep `ψ-context/`, `ψ-drafts/`, `ψ-logs/` gitignored (ephemeral)
3. Rename/consolidate `ψ-prompts/` (unused) and `ψ-reference/` (special case)
4. Define clear promotion paths between folders

---

## Current State Analysis

| Folder | Files | Size | Git | Purpose |
|--------|-------|------|-----|---------|
| ψ-context | 110 | 1.1M | Ignored | Active investigation |
| ψ-drafts | 3 | 32K | Ignored | Output drafts |
| ψ-learnings | 10 | 60K | Ignored | Distilled patterns |
| ψ-logs | 20 | 84K | Ignored | Quick snapshots |
| ψ-prompts | 1 | 4K | Ignored | Reserved (unused) |
| ψ-reference | 886 | 120M | Ignored | SDK learning lab |
| ψ-retrospectives | 37 | 424K | Ignored | Session reflections |

**Problems Identified**:
1. **All gitignored** - Valuable learnings could be lost
2. **No clear lifecycle** - When does context become learning?
3. **ψ-prompts unused** - Dead folder
4. **ψ-reference bloated** - 120M mostly node_modules

---

## Proposed Structure

### Tier 1: Ephemeral (Gitignored)

```
ψ-context/          # Working memory (delete anytime)
├── [topic]/        # Investigation folders
└── *.md            # Scratch files

ψ-drafts/           # Outputs in progress
└── *.md            # Blog posts, slides, proposals

ψ-logs/             # Quick captures
└── YYYY-MM/        # Date-organized snapshots
    └── DD_HH.MM_slug.md
```

**Rule**: These are session-specific. Can be deleted after session ends.

---

### Tier 2: Preserved (Git Tracked)

```
ψ-learnings/        # Distilled wisdom (PERMANENT)
├── 000-naming-philosophy.md
├── 001-delegate-reading.md
├── ...
└── README.md

ψ-retrospectives/   # Session history (PERMANENT)
└── YYYY-MM/
    └── DD/
        └── HH.MM-slug.md
```

**Rule**: These are institutional memory. Never delete, always commit.

---

### Tier 3: Reference (Special)

```
ψ-reference/        # External knowledge
├── [topic]/
│   ├── INDEX.md        # Our notes (tracked)
│   ├── TIMELINE.md     # Our analysis (tracked)
│   └── repo/           # Cloned repo (gitignored)
└── node_modules/       # Dependencies (gitignored)
```

**Rule**: Our documentation tracked, external repos gitignored.

---

### Tier 4: Remove/Consolidate

| Current | Action | Reason |
|---------|--------|--------|
| ψ-prompts/ | **Remove** | Unused, only 1 file |
| - | Move content to `ψ-context/prompts/` if needed |

---

## Knowledge Flow

```
┌─────────────────────────────────────────────────────────────┐
│                     EPHEMERAL (gitignored)                  │
│                                                             │
│   ψ-context/  ──────►  ψ-logs/  ──────►  ψ-drafts/         │
│   (research)           (snapshots)       (outputs)          │
│                                                             │
└─────────────────────────┬───────────────────────────────────┘
                          │
                          │ /distill (promotion)
                          ▼
┌─────────────────────────────────────────────────────────────┐
│                    PRESERVED (git tracked)                  │
│                                                             │
│   ψ-learnings/  ◄────────────────  ψ-retrospectives/       │
│   (patterns)                        (sessions)              │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Promotion Rules

| From | To | Trigger | Command |
|------|----|---------|---------|
| ψ-context | ψ-logs | Quick capture | `/snapshot` |
| ψ-logs | ψ-retrospectives | Session end | `rrr` |
| ψ-retrospectives | ψ-learnings | Pattern emerges | `/distill` |
| ψ-drafts | (external) | Finalize | Manual export |

---

## Git Configuration

### .gitignore (proposed)

```gitignore
# Tier 1: Ephemeral (always ignored)
ψ-context/
ψ-drafts/
ψ-logs/

# Tier 3: Reference (selective)
ψ-reference/**/repo/
ψ-reference/**/node_modules/

# Remove from ignore (now tracked)
# ψ-learnings/      <- REMOVE THIS LINE
# ψ-retrospectives/ <- REMOVE THIS LINE
```

### What Gets Committed

| Folder | Commit? | Reason |
|--------|---------|--------|
| ψ-learnings/ | YES | Institutional wisdom |
| ψ-retrospectives/ | YES | Session history |
| ψ-reference/*.md | YES | Our analysis |
| ψ-reference/repo/ | NO | External clone |
| ψ-context/ | NO | Ephemeral |
| ψ-drafts/ | NO | Work in progress |
| ψ-logs/ | NO | Temporary captures |

---

## Migration Plan

### Phase 1: Clean Up (Now)

1. Delete `ψ-prompts/` or move content to `ψ-context/prompts/`
2. Clean `ψ-reference/` - remove node_modules if not needed
3. Review `ψ-context/` - anything worth promoting?

### Phase 2: Track Permanent (This Week)

1. Update `.gitignore` - remove ψ-learnings and ψ-retrospectives
2. `git add ψ-learnings/ ψ-retrospectives/`
3. Commit: "chore: track permanent ψ-knowledge folders"

### Phase 3: Document (This Week)

1. Add README.md to each ψ-folder explaining purpose
2. Update CLAUDE.md with new rules
3. Create `/promote` command for tier transitions

---

## Folder Purposes (Final)

| Folder | Tier | Git | Lifecycle | Purpose |
|--------|------|-----|-----------|---------|
| **ψ-context/** | 1 | No | Hours-Days | Working memory, active investigation |
| **ψ-drafts/** | 1 | No | Hours-Days | Output drafts before export |
| **ψ-logs/** | 1 | No | Days | Quick snapshots, debug notes |
| **ψ-learnings/** | 2 | **Yes** | Permanent | Distilled patterns, lessons |
| **ψ-retrospectives/** | 2 | **Yes** | Permanent | Session history, decisions |
| **ψ-reference/** | 3 | Partial | Permanent | External docs + our analysis |

---

## Questions for Review

1. **Track retrospectives?**
   - Pro: Session history preserved
   - Con: 37+ files, grows fast

2. **Track learnings?**
   - Pro: Patterns are valuable
   - Con: Already 10 files, will grow

3. **Delete ψ-prompts/?**
   - Only 1 file, unused
   - Could consolidate into ψ-context/

4. **Clean ψ-reference/?**
   - 120M is large
   - Keep only INDEX.md + TIMELINE.md?

---

## Recommendation

**Minimum viable change**:
1. Track `ψ-learnings/` (10 files, 60K) - high value, low cost
2. Keep `ψ-retrospectives/` gitignored for now - high volume
3. Delete `ψ-prompts/` - unused
4. Document the flow in CLAUDE.md

**Full change** (if approved):
1. Track both learnings AND retrospectives
2. Implement promotion commands
3. Auto-archive old context files

---

## Decision Matrix

| Option | Effort | Value | Risk |
|--------|--------|-------|------|
| A: Track learnings only | Low | Medium | Low |
| B: Track learnings + retros | Medium | High | Medium |
| C: Full restructure | High | High | Medium |
| D: Keep as-is | None | None | Data loss |

**Recommended**: Option A or B

---

*Draft by Claude Opus 4.5 - awaiting human review*
