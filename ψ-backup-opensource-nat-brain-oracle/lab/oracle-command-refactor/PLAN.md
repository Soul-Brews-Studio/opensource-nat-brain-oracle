# Refactor Plan

**Project**: Oracle Command Refactor
**Based on**: SPEC.md analysis

---

## P1 - Critical Fixes

### 1.1 rrr Subagent Separation

**Problem**: rrr Step 2 asks subagent to "write draft" — violates "Opus writes, Haiku gathers"

**Current** (`.claude/commands/rrr.md:57-62`):
```
### Step 2: Draft Retrospective (Subagent)
**Use general-purpose subagent** (Haiku) to write draft:
```

**Fix**:
```
### Step 2: Gather Structured Data (Subagent)
**Use context-finder subagent** (Haiku) to return structured data:
- Commits with timestamps
- Files changed with categories
- Session duration estimate
- Related retrospectives for format reference

**Return format**: Structured JSON/markdown, NOT prose
```

Then Step 3 (Opus) writes ALL prose including AI Diary.

**Files to change**:
- `.claude/commands/rrr.md`

---

## P2 - Enhancements

### 2.1 nnn: Add "Test First" Step

**Problem**: Pattern #5 "Overconfidence without testing" not embedded

**Add before gogogo**:
```markdown
### Step 3b: Local Verification Reminder

Before implementation, consider:
- Can this be tested locally first?
- What's the smallest verifiable step?
- Add to issue: "Test: [what to verify]"
```

**Files to change**:
- `.claude/commands/nnn.md`

### 2.2 Unified Work View

**Status**: ✅ ALREADY SOLVED

`/pending` already unifies:
- Tracks (from INDEX.md)
- GitHub issues (via `gh issue list`)
- TODOs in code

No refactor needed. Just document the fear it solves:
> Fear of invisible work → `/pending` + `/tracks`

---

## P3 - Nice to Have

### 3.1 Auto-prompt /snapshot after rrr

**Current**: rrr creates lesson learned (Step 6)
**Consider**: Is this duplicating /snapshot? Or complementary?

**Investigation needed** — may already be solved by Step 6.

### 3.2 Dormant Track Archival

**Current**: Tracks go ⚪ (dormant) after 30d
**Consider**: Auto-archive command or prompt

---

## Implementation Order

1. [ ] **P1.1** - Fix rrr subagent separation
2. [ ] **P2.1** - Add test-first step to nnn
3. [ ] Investigate /pending for unified view
4. [ ] Decide on P3 items

---

## Estimated Effort

| Task | Effort | Risk |
|------|--------|------|
| P1.1 rrr fix | Small | Low (clarification only) |
| P2.1 nnn test step | Small | Low |
| P2.2 /pending audit | Investigation | None |

---

## Success Metrics

After refactor:
- [ ] rrr follows "Haiku gathers, Opus writes" strictly
- [ ] nnn includes testing checkpoint
- [ ] All commands < 100 lines
- [ ] Fear → Command mapping is explicit

---

*Plan created: 2025-12-29*
