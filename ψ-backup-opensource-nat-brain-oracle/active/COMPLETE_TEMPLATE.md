# Context-Finder: COMPLETE OUTPUT TEMPLATE

## DEFAULT MODE EXAMPLE (Full Output)

```
## Context Summary
🔵 FOCUSED (2h 15m) | Last change 5m ago

---

## Files in Motion

| Score | File | Changed | Status |
|-------|------|---------|--------|
| 6+ ⭐ | .claude/settings.json | 5m | M (staged) |
| 4-5 | ψ/WIP.md | 12m | M |
| 2-3 | ψ/memory/slugs.yaml | 25m | M |

*Legend: Recency (3/2/1) + Type (3/2/1) + Impact (2/1) = Score*

Other files (2): ψ/learn/oracle-v2/ (untracked), .gitignore (M)

---

## Git State
- **Staged**: .claude/settings.json
- **Modified**: ψ/WIP.md, ψ/memory/slugs.yaml
- **Untracked**: 2 items
- **Branch**: main

---

## Recent Activity

### Last 5 Commits
| When | Commit | Message |
|------|--------|---------|
| 5m | fa78aa7 | fix: make timestamp hook clean one-liner |
| 15m | 267983a | rrr: claude-plugins learn + fb api |
| 2h | f8c4170 | rrr: siit workshop done, flight delayed |
| 4h | f203f12 | learn: gogogo must complete full gh cycle |
| 6h | 2475a12 | docs: add /trace command documentation |

### Active Issues (context: prefix)
| # | Title | Age |
|---|-------|-----|
| #42 | context: focus.md sync prevention | 2d |
| #38 | context: agent status board | 5d |

### Latest Retrospectives
| Date | Title |
|------|-------|
| 2025-12-20 | MAW wait command & conflict prevention |
| 2025-12-19 | Dashboard iteration 15 trial results |
| 2025-12-18 | Multi-agent sync patterns + weyermann |

---

## What's Hot
Focus shifting to settings config (6+ score). Last session wrapped 
MAW demo with conflict fixes. Main branch is clean and ready for 
next work. Next target: /trace command completion per gogogo task.

---
🕐 END: 10:16:59 (1766805419) | Claude Haiku (context-finder)
```

---

## SEARCH MODE EXAMPLE

Query: `/context-finder focus.md`

```
## Search: "focus.md"

### Commits (3 matches)
- `fa78aa7` (5m ago) fix: make timestamp hook clean one-liner
- `267983a` (15m ago) rrr: claude-plugins learn + fb api
- `2475a12` (6h ago) docs: add /trace command documentation

### Issues (1 match)
- #42 (2d) context: focus.md sync prevention

### Files (2 matches)
- ψ/inbox/focus.md
- ψ/memory/logs/activity.log

### Retrospectives (1 match)
- 2025-12-20 MAW wait command & conflict prevention
  *Excerpt: "Exclude from worktrees: .git/worktrees/N/info/exclude"*

---
🕐 END: 10:17:03 (1766805423) | Claude Haiku (context-finder)
```

---

## LINE-BY-LINE BREAKDOWN

### Section 1: Status Header (2 lines)
```
## Context Summary
🔵 FOCUSED (2h 15m) | Last change 5m ago
```
Purpose: Immediate state orientation
Emoji count: 1 (status indicator only)

### Section 2: Files in Motion (5-8 lines)
```
| Score | File | Changed | Status |
|-------|------|---------|--------|
| 6+ ⭐ | .claude/settings.json | 5m | M (staged) |
| 4-5 | ψ/WIP.md | 12m | M |
| 2-3 | ψ/memory/slugs.yaml | 25m | M |

*Legend: Recency (3/2/1) + Type (3/2/1) + Impact (2/1) = Score*

Other files (2): ...
```
Purpose: Show what changed, ranked by impact
Emoji count: 1 (⭐ for high scores)
Key: Score column FIRST, only top 4-5 shown

### Section 3: Git State (5-6 lines)
```
## Git State
- **Staged**: .claude/settings.json
- **Modified**: ψ/WIP.md, ψ/memory/slugs.yaml
- **Untracked**: 2 items
- **Branch**: main
```
Purpose: Clear git status at a glance
Emoji count: 0 (bullets only)
Key: Use bullets NOT table (faster to scan)

### Section 4: Recent Activity (18-25 lines)
```
### Last 5 Commits
[5 rows x 3 columns]

### Active Issues
[2 rows x 3 columns]

### Latest Retrospectives
[3 rows x 2 columns]
```
Purpose: Show context breadth
Emoji count: 0 (pure data)
Key: Three focused tables, not one big one

### Section 5: What's Hot (3-4 lines)
```
## What's Hot
Focus shifting to settings config (6+ score). Last session wrapped 
MAW demo with conflict fixes. Main branch is clean and ready for 
next work. Next target: /trace command completion per gogogo task.
```
Purpose: Narrative summary, explain connections
Emoji count: 0 (prose)
Key: 2-3 sentences connecting files, commits, retros

### Timestamp Footer (1 line)
```
🕐 END: 10:16:59 (1766805419) | Claude Haiku (context-finder)
```
Emoji count: 1 (🕐 for timestamp)

---

## TOTAL EMOJI COUNT: 3-4
- 1 status (🔵 FOCUSED / 🟡 SCATTERED / ⚪ IDLE)
- 1 weight (⭐ for score 6+, optional)
- 1 timestamp end (🕐)

**vs BEFORE**: 16+ emoji in file table alone = 75% reduction

---

## TOTAL LENGTH: 60 lines (typical)

Breakdown:
- Header: 2 lines
- Files: 8 lines
- Git State: 5 lines
- Recent Activity: 24 lines (5+2+3 commits/issues/retros = 10 rows)
- What's Hot: 4 lines
- Blank lines: ~15
- Footer: 1 line
= ~59 lines

---

## VALIDATION AGAINST CRITERIA

| Criterion | Status | Evidence |
|-----------|--------|----------|
| Sections | 5 | Header, Files, Git, Activity, Hot |
| Tables vs Bullets | Mixed | Git=bullets, others=tables, Hot=prose |
| Emoji usage | Minimal | 3-4 total (GOOD) vs 16+ (BAD) |
| Length | 50-70 | 59 lines typical |
| Scanability | High | Score column first, status header |
| Narrative | Present | "What's Hot" section |
| Consistency | High | 3 table layouts max |
| Clarity | High | Clear hierarchy + bookends |

---

## IMPLEMENTATION RULES (COPY THIS)

1. **File table header**: Score | File | Changed | Status
2. **Files sorted**: Descending by score
3. **Files shown**: Top 4-5 only, rest in "Other (N items)"
4. **Git state**: Use bullets (not table)
5. **Commits shown**: 5 (not 10)
6. **Issues filtered**: "context:" prefix only
7. **Retros shown**: 3 (not all)
8. **Scoring legend**: Shown once, under Files
9. **Status header**: Shows emoji + duration + last change
10. **What's Hot**: 2-3 sentence narrative
11. **Total length**: 50-70 lines (max 80)
12. **Emoji total**: 3-4 (status, weight, timestamp)
13. **Timestamps**: Human-readable format (5m, 2h, 2025-12-20)
14. **Footer**: Always include 🕐 END timestamp + attribution

---

## QUICK IMPLEMENTATION CHECKLIST

Before outputting, verify:
- [ ] File table sorted by score (descending)
- [ ] Only top 4-5 files shown
- [ ] All timestamps are human-readable
- [ ] No section exceeds 15 lines
- [ ] Total output: 50-70 lines
- [ ] Scoring legend visible (appears once)
- [ ] What's Hot section explains narrative
- [ ] Git state uses bullets (not table)
- [ ] Emoji count: 3-4 total (status, weight, timestamp)
- [ ] Footer has 🕐 END timestamp + attribution

