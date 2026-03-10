# Context-Finder Output Format Specification v2

## Design Philosophy

- **Scannable first**: Headers, tables, numbers
- **Scored for signal**: Files ranked by impact
- **Timestamp-aware**: "5m ago" better than "14:30"
- **Action-ready**: Tell me what changed and why I should care

## SECTION BREAKDOWN

### Section 1: Status Header (1 line)
```
Context Summary | 🔵 FOCUSED (2h) | Last change 5m ago
```

**Content**:
- Status emoji: 🔵 FOCUSED, 🟡 SCATTERED, ⚪ IDLE
- Duration active
- Last change timestamp (human readable)

**Why**: Immediately orient user (are we in flow or jumping around?)

---

### Section 2: Files in Motion (Table + Legend)
```
| Score | File | Changed | Status |
|-------|------|---------|--------|
| 6+ ⭐ | .claude/settings.json | 5m | Modified (staged) |
| 4-5 | ψ/WIP.md | 12m | Modified |
| 2-3 | ψ/memory/slugs.yaml | 25m | Modified |

**Legend**: Recency (3/2/1) + Type (3/2/1) + Impact (2/1) = Score
- Recency: <1h(+3), <4h(+2), <24h(+1)
- Type: Code(+3), Agent(+2), Docs(+1), Logs(0)
- Impact: Core(+2), Config(+1)
```

**Why**: 
- Score column first (user scans left to right)
- Show top 4-5 files only
- Rest in "Other files (N items)"
- Scoring system visible once, not repeated

**Emoji**: Only in score column as visual "weight" (⭐ for 6+)

---

### Section 3: Git State (Bullets)
```
**Git Status**
- Staged: .claude/settings.json
- Modified: ψ/WIP.md, ψ/memory/slugs.yaml
- Untracked: 2 items (ψ/learn/oracle-v2/)
- Branch: main
```

**Why**: 
- Clean, scannable list
- No table overhead for simple status
- Shows everything in 4 lines

---

### Section 4: Recent Context (3 focused tables)

#### A. Last 5 Commits
```
| When | Commit | Message |
|------|--------|---------|
| 5m | fa78aa7 | fix: timestamp hook clean |
| 15m | 267983a | rrr: claude-plugins + fb |
| 2h | f8c4170 | rrr: siit workshop done |
| 4h | f203f12 | learn: gogogo full cycle |
| 6h | 2475a12 | docs: /trace command |
```

#### B. Open Issues (context: prefix only)
```
| # | Title | Age |
|---|-------|-----|
| #42 | context: focus.md sync | 2d |
| #38 | context: agent status | 5d |
```
*If none exist: "No active context issues"*

#### C. Latest 3 Retrospectives
```
| Date | Title |
|------|-------|
| 2025-12-20 | MAW wait command & conflicts |
| 2025-12-19 | Dashboard iteration 15 |
| 2025-12-18 | Multi-agent sync patterns |
```

**Why**: 
- Each is focused (one table, clear purpose)
- Timestamps in "When" or "Age" (human readable)
- Three tables = shows breadth without overwhelming

---

### Section 5: What's Hot (2-3 sentences)
```
**What's hot**: Focus on settings config. Last session was MAW demo 
with conflict fixes. Main branch is clean, next target is /trace 
command completion.
```

**Why**: 
- Narrative summary (context)
- Connects dots between files, commits, retros
- Gives "why I should care" signal

---

## TOTAL LENGTH: 50-70 lines

### Example Full Output

```
## Context Summary
🔵 FOCUSED (2h) | Last change 5m ago

---

## Files in Motion

| Score | File | Changed | Status |
|-------|------|---------|--------|
| 6+ ⭐ | .claude/settings.json | 5m | M (staged) |
| 4-5 | ψ/WIP.md | 12m | M |
| 2-3 | ψ/memory/slugs.yaml | 25m | M |

*Legend: Recency (3/2/1) + Type (3/2/1) + Impact (2/1) = Score*

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
| 5m | fa78aa7 | fix: timestamp hook clean |
| 15m | 267983a | rrr: claude-plugins |
| 2h | f8c4170 | rrr: siit workshop done |

### Active Issues
| # | Title | Age |
|---|-------|-----|
| #42 | context: focus.md sync | 2d |

### Latest Retrospectives
| Date | Title |
|------|-------|
| 2025-12-20 | MAW wait & conflicts |
| 2025-12-19 | Dashboard iteration 15 |

---

## What's Hot
Focus on settings. Last session: MAW demo + conflict prevention. 
Main branch is clean, ready for next work.
```

---

## SEARCH MODE (with query)

When called with `/context-finder [query]`:

```
## Search: "focus.md"

### Commits (3 matches)
- `f203f12` (4h ago) "learn: gogogo full gh flow cycle"
- `2475a12` (6h ago) "docs: add /trace command"

### Issues (1 match)
- #42 (2d ago) "context: focus.md sync prevention"

### Files (2 matches)
- ψ/inbox/focus.md
- ψ/memory/logs/activity.log

### Retrospectives (1 match)
- 2025-12-20 "MAW wait command & conflict prevention"
  *Excerpt: "Exclude from worktrees: .git/worktrees/N/info/exclude"*
```

**Changes from DEFAULT**:
- Remove scoring
- Group by source type
- Show match count
- Include excerpt for retros

---

## NO EMOJI OVERLOAD RULE

✅ Use emoji for:
- Status (🔵 FOCUSED, 🟡 SCATTERED, ⚪ IDLE)
- Score weight (⭐ for 6+)
- Timestamp (🕐 for start/end)

❌ Don't use emoji for:
- Every table column
- File types
- Status badges (use "M" for Modified, "A" for Added)

---

## TIMESTAMP RULES

✅ Good:
- "5m ago" (relative, human-readable)
- "2025-12-20" (retro dates, clear)
- "🕐 10:16:59 (1766805419)" (epoch for logs)

❌ Bad:
- "1766805419" alone (not human-readable)
- ISO datetime in tables (too long)

---

## VALIDATION CHECKLIST

Before outputting:
- [ ] File table sorted by score descending
- [ ] All timestamps human-readable or with context
- [ ] No single section exceeds 15 lines
- [ ] Total output 50-70 lines (max 80)
- [ ] Legend visible if scoring used
- [ ] "What's hot" explains the narrative
- [ ] Timestamp at bottom: `🕐 END: HH:MM:SS | Claude Haiku (context-finder)`

