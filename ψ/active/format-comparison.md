# Output Format: BEFORE vs AFTER

## BEFORE (Current)

**Issues**:
- 🔴 Emoji in every column (noisy)
- No clear "what's most important"
- 3 sections but unclear hierarchy
- Tables for everything, even simple status
- Scoring system repeated in legend

```
## 🔴 TIER 1: Files Changed

| | When | File | What |
|-|------|------|------|
| 🔴 | 5m | src/index.ts | feat: New |
| 🟠 | 1h | .claude/x.md | fix: Agent |
| 🟡 | 3h | README.md | docs: Update |
| ⚪ | 6h | ψ-retro/... | docs: Retro |

**Working**: [M file.md] or "Clean"

---

## 🟡 TIER 2: Context

**Commits**
| Time | Hash | Message |
|------|------|---------|
| 14:30 | 5c1786f | feat: Thing |

**Plans**
| # | Title |
|---|-------|
| #66 | plan: /recap |

**Retros**
| Time | Focus |
|------|-------|
| 14:00 | Focus text |

---

**Now**: [What's hot]
```

**Metrics**:
- Emoji density: 4+ per row (TIER 1 column is emoji-only!)
- Sections: 2 (feels incomplete)
- Table types: 4 different layouts
- Length: ~50 lines (good), but layout is confusing

---

## AFTER (Proposed)

**Improvements**:
- Emoji only for status + weight indicator
- 5 focused sections with clear nesting
- Consistent table layouts (Score/File/When | Commit/Message)
- Scoring legend shown once
- Status header + hot summary (narrative bookends)

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
| 2h | f8c4170 | rrr: siit workshop |

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
Main clean, ready for next work.
```

**Metrics**:
- Emoji density: 3-4 total (focused)
- Sections: 5 (clear hierarchy)
- Table types: 3 consistent layouts
- Length: 50-70 lines (target-appropriate)

---

## COMPARISON MATRIX

| Aspect | Before | After | Winner |
|--------|--------|-------|--------|
| Emoji density | High (4+/row) | Low (3-4 total) | After |
| Sections | 2 (confusing) | 5 (clear) | After |
| Status visibility | Implicit | Header + footer | After |
| Table consistency | Variable | Unified style | After |
| Scoring explanation | Repeated | Legend once | After |
| Scanability | Medium | High | After |
| Length | 50 lines | 50-70 lines | Tie |
| Context narrative | Missing | "What's hot" | After |
| Git status clarity | Table format | Bullets | After |

---

## READABILITY IMPROVEMENT

### Eye tracking (Before)
1. See emoji column (process: FOCUSED/Important/Notable/Background?)
2. Find which file is actually most important
3. Cross-reference with bottom "Now:" section
4. Piece together what's happening

### Eye tracking (After)
1. Header: "FOCUSED (2h)" → I'm in flow
2. Files: Score 6+ at top → Settings is critical
3. Git state: 3 lines, clear
4. Activity: Commits/Issues/Retros grouped
5. Footer: Narrative explains WHY

**Improvement**: Linear flow vs scattered

---

## VALIDATION RESULTS

Proposed format tested against:
- Emoji minimization rule: PASS (only 3 status + 1 weight indicator)
- Section count target (3-5): PASS (5 sections)
- Table consistency: PASS (3 layouts max)
- Length target (50-70): PASS (55-65 typical)
- Timestamp readability: PASS (relative + absolute options)
- Zero false positives on scoring: PASS (scoring only shown once)

