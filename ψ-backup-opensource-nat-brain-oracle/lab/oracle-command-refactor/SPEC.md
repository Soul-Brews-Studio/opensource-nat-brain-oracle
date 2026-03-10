# Oracle Command Refactor Spec

**Project**: Fear-Management Framework → Command Engineering
**Location**: `ψ/lab/oracle-command-refactor/`
**Created**: 2025-12-29

---

## Core Insight

> "All documentation is fear management that became wisdom"

Every command in this system was born from a fear. Understanding the fear enables better design.

---

## The 6 Core Commands

| Command | Fear | What It Solves |
|---------|------|----------------|
| `/jot` | Fear of forgetting | Quick capture before context evaporates |
| `/snapshot` | Fear of lost patterns | Extract lesson before wisdom fades |
| `rrr` | Fear of context loss | Full session audit trail |
| `/jump` | Fear of context switching | Explicit topic management with stack |
| `/tracks` | Fear of invisible work | Time-decay visibility into all work |
| `nnn` | Fear of overconfidence | Plan before code, prevent assumptions |

---

## Command Audit

### 1. /jot

**Fear**: Forgetting something important between sessions

**Current Implementation**:
- Bash-only append to `ψ/inbox/jot.md`
- No read required (token efficient)
- 2-5 lines max

**Fear Alignment Score**: ⭐⭐⭐⭐⭐
- Fast (no friction)
- No ceremony
- Captures fleeting thoughts

**Refactor Opportunities**:
- [ ] None — already minimal and effective

---

### 2. /snapshot

**Fear**: Pattern/lesson fading before extraction

**Current Implementation**:
- Derives title from context
- Creates `ψ/memory/learnings/YYYY-MM-DD_slug.md`
- Simple template

**Fear Alignment Score**: ⭐⭐⭐⭐
- Good flow: rrr → snapshot
- Template is lean

**Refactor Opportunities**:
- [ ] Consider auto-trigger after rrr (prompt: "Extract lesson?")
- [ ] Link back to source retrospective

---

### 3. rrr (Session Retrospective)

**Fear**: Context loss across sessions

**Current Implementation**:
- Multi-step with subagents
- Repo health → gather data → draft → review → commit
- Human confirmation required
- Lesson learned required

**Fear Alignment Score**: ⭐⭐⭐⭐
- Comprehensive
- Forces reflection (AI Diary)

**Refactor Opportunities**:
- [ ] Step 2 and 3 currently use subagent for draft — but learnings say "Opus writes, Haiku gathers"
- [ ] Consider stricter separation: Haiku ONLY gathers, Opus writes ALL content
- [ ] Simplify: 227 lines is complex for a fear-management tool

---

### 4. /jump

**Fear**: Context doesn't transfer when switching topics

**Current Implementation**:
- Multi-track system with stack
- `jump.sh` script handles logic
- Time-decay status (Hot → Dormant)

**Fear Alignment Score**: ⭐⭐⭐⭐⭐
- Explicit acknowledgment of topic switch
- Stack allows "jump back"
- Visibility into what was abandoned

**Refactor Opportunities**:
- [ ] None — design matches fear well
- [ ] Consider: auto-archive dormant tracks?

---

### 5. /tracks

**Fear**: Invisible work — not knowing what's in progress

**Current Implementation**:
- Shows all tracks with time-decay
- `tracks.sh` script
- Emoji-based status (🔥🟢🟡🔴⚪)

**Fear Alignment Score**: ⭐⭐⭐⭐⭐
- Direct answer to "what am I working on?"
- Time-decay surfaces forgotten work

**Refactor Opportunities**:
- [ ] Add GitHub issue sync? (tracks + issues = unified view)
- [ ] Consider archival workflow for dormant

---

### 6. nnn (Next Task Planning)

**Fear**: Overconfidence — coding without understanding

**Current Implementation**:
- Analysis only, no coding
- Context gathering → subagent analysis → GitHub issue
- Leads to `gogogo`

**Fear Alignment Score**: ⭐⭐⭐⭐
- Forces planning before implementation
- Creates artifact (GitHub issue)

**Refactor Opportunities**:
- [ ] Step 2 uses subagents for analysis — good
- [ ] Consider: link to related learnings automatically?
- [ ] "Test locally first" rule not embedded in nnn (from pattern #5)

---

## Framework Patterns

### Pattern 1: Fear → System Mapping

Each fear needs:
1. **Detection**: When does this fear manifest?
2. **Intervention**: What does the command do?
3. **Artifact**: What persists after command runs?
4. **Recovery**: How to recover if fear realized anyway?

| Command | Detection | Intervention | Artifact | Recovery |
|---------|-----------|--------------|----------|----------|
| /jot | "Oh I should note this" | Quick append | jot.md | Review later |
| /snapshot | After rrr | Pattern extraction | learnings/*.md | Re-extract |
| rrr | Session end | Full retrospective | retrospectives/*.md | N/A |
| /jump | Topic switch needed | Explicit stack push | track file | /jump back |
| /tracks | "What am I doing?" | Time-decay view | INDEX.md | Manual review |
| nnn | Before implementation | Forced planning | GitHub issue | Re-plan |

### Pattern 2: Subagent Division

From learnings:
> "Opus writes, Haiku gathers"

| Phase | Model | Why |
|-------|-------|-----|
| Data gathering | Haiku | Stateless, cheap, parallel |
| Writing/synthesis | Opus | Needs full context, nuance |
| Review/approve | Opus | Quality gate |

**Commands using subagents**: rrr, nnn, /snapshot (implicitly)

---

## Refactor Priorities

### P1 - Critical (Contradicts Learnings)

1. **rrr Step 2**: Currently "subagent writes draft" — should be "subagent gathers, Opus writes"
   - File: `.claude/commands/rrr.md` line 57-62
   - Change: Haiku returns structured data, Opus writes prose

### P2 - Enhancement (Improves Fear Alignment)

2. **nnn**: Embed "test locally first" rule
   - Pattern #5: "Overconfidence without testing"
   - Add step before `gogogo`: "Verify locally before implement"

3. **tracks + issues unification**: Single view of all work
   - Tracks = local work-in-progress
   - Issues = formal tasks
   - Unified view reduces "invisible work" fear

### P3 - Nice to Have

4. **/snapshot auto-prompt**: After rrr, prompt "Extract lesson?"
5. **Dormant track archival**: Auto-archive after 30d

---

## Success Criteria

- [ ] All 6 commands explicitly map to fear they solve
- [ ] Subagent usage follows "Haiku gathers, Opus writes" pattern
- [ ] No command > 100 lines (simplicity)
- [ ] Each command produces clear artifact

---

## Related Files

- `ψ/memory/retrospectives/2025-12/29/08.48_ccdc-server-memory-fix-pattern-archaeology.md` — source of framework
- `ψ/memory/learnings/2025-12-13_subagent-delegation-pattern.md` — subagent rules
- `CLAUDE.md` — golden rules

---

*Spec created: 2025-12-29 09:XX*
