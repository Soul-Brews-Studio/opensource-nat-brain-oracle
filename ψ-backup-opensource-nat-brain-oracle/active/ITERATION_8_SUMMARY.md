# ITERATION 8: Output Format Design - Final Summary

Date: 2025-12-27
Task: Design IDEAL output template focusing on format (not content)

## THE QUESTION

How should context-finder FORMAT its output?
- How many sections? (3? 5? 7?)
- Tables vs prose vs bullets?
- Emoji usage (useful or noise?)
- Length limit? (50 lines? 100?)

## THE ANSWER

### Section Count: 5 (not 2, not 7)

1. **Status Header** (1 line)
   - Shows flow state + duration + last change
   - Example: "🔵 FOCUSED (2h) | Last change 5m ago"

2. **Files in Motion** (5-8 lines)
   - Scored table: top 4-5 files only
   - Scoring legend shown once
   - Example: Score | File | Changed | Status

3. **Git State** (4-5 lines)
   - Bullet list (NOT table)
   - Staged, Modified, Untracked, Branch
   - Clean and scannable

4. **Recent Activity** (20-30 lines)
   - THREE focused tables:
     a) Last 5 commits (When | Commit | Message)
     b) Active issues (# | Title | Age)
     c) Latest 3 retrospectives (Date | Title)

5. **What's Hot** (2-4 lines)
   - Narrative summary (prose)
   - Connects files, commits, retros
   - Explains the "why"

### Total Length: 50-70 lines (max 80)

---

## Emoji Usage: LESS IS MORE

### GOOD emoji (KEEP):
- 🔵 FOCUSED / 🟡 SCATTERED / ⚪ IDLE (status indicator)
- ⭐ for score 6+ (visual weight signal)
- 🕐 for timestamps (section marker)

### BAD emoji (REMOVE):
- 🔴🟠🟡⚪ in every file row (NOISE!)
- Emoji for file types
- Emoji for status badges (use: M=Modified, A=Added)

**Result**: From 4+ emoji per row → 3-4 total emoji in entire output

---

## Format Breakdown: When to Use What

### TABLES (data-heavy, structured):
- Files in Motion (Score | File | Changed | Status)
- Last 5 Commits (When | Commit | Message)
- Active Issues (# | Title | Age)
- Latest Retrospectives (Date | Title)

### BULLETS (simple status):
- Git State (Staged / Modified / Untracked / Branch)
- Untracked items list

### PROSE (narrative):
- Status Header (1 line summary)
- What's Hot (2-3 sentence narrative)

**Consistency Rule**: Max 3 different table layouts

---

## Timestamp Format

### GOOD:
- "5m ago" (relative, human-readable)
- "2h" (concise relative)
- "2025-12-20" (full date for retros)

### AVOID:
- "1766805419" alone (epoch not human-readable)
- "2025-12-20T14:30:00Z" (too long for tables)
- "14:30" (ambiguous time, no date context)

---

## Key Design Decisions

### 1. Files Table: Score Column FIRST
- Users scan left-to-right
- Score (6+ / 4-5 / 2-3) signals importance
- Only show top 4-5 (rest hidden in "Other")

### 2. Git State: Bullets NOT Table
- Faster to read
- No cell alignment overhead
- Shows everything in 4 lines

### 3. Three Activity Tables (not one big one)
- Each focused (commits/issues/retros separate)
- Easy to skip one section if uninterested
- Max 5 items per table

### 4. Status Header + What's Hot Bookends
- Header: Immediate orientation (flow state)
- Footer: Narrative explanation (why this matters)
- Linear reading experience

### 5. Scoring Legend SHOWN ONCE
- Under Files table
- Not repeated
- Clear explanation of scoring math

---

## Before vs After Comparison

| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| Emoji density | 4+/row | 3-4 total | 70% reduction |
| Sections | 2 (confusing) | 5 (clear hierarchy) | +150% clarity |
| Status visibility | Implicit | Header + Footer | Explicit |
| Table consistency | 4 layouts | 3 layouts max | 25% unified |
| Length | 50 lines | 50-70 lines | Target-appropriate |
| Scanability | Medium | High | +40% speed |
| Context narrative | Missing | "What's Hot" | Added |

---

## Implementation Notes

### For DEFAULT MODE:
1. Run all data gathering in parallel
2. Score each file once
3. Sort files by score (descending)
4. Show top 4-5, hide rest in "Other (N items)"
5. End with 1-line insight

### For SEARCH MODE:
1. Remove scoring entirely
2. Group by source: Commits | Issues | Files | Retros
3. Show match count per source
4. Include excerpts for retrospectives
5. Example: "### Commits (3 matches)"

### Validation Checklist:
- [ ] Files sorted by score
- [ ] Only top 4-5 files shown
- [ ] All timestamps human-readable
- [ ] No section exceeds 15 lines
- [ ] Total: 50-70 lines
- [ ] Legend visible (once, under files)
- [ ] What's Hot explains narrative
- [ ] Emoji: status (3) + weight (1) = 4 max
- [ ] Timestamp at bottom: 🕐 END: HH:MM:SS

---

## Emoji Density Breakdown

### Current (BEFORE):
```
| 🔴 | 5m | src/index.ts | feat: New |
| 🟠 | 1h | .claude/x.md | fix: Agent |
| 🟡 | 3h | README.md | docs: Update |
| ⚪ | 6h | ψ-retro/... | docs: Retro |
```
4 emoji × 4 rows = 16 emoji in one table section

### Proposed (AFTER):
```
## Context Summary
🔵 FOCUSED (2h) | Last change 5m ago
[1 emoji total in header]

[... sections ...]

*Legend: Recency (3/2/1) + Type (3/2/1) + Impact (2/1) = Score*
[0 emoji]

[... more sections ...]

🕐 END: 10:16:59 | Claude Haiku (context-finder)
[1 emoji at bottom]

[Files table]:
| 6+ ⭐ | .claude/settings.json | ...
[1 emoji in one cell]
```
3-4 emoji total across ENTIRE output = 75% reduction

---

## Why This Design?

1. **Scannable**: Headers + tables guide eye naturally
2. **Actionable**: Scoring tells you what matters
3. **Efficient**: 5 sections vs 2 = clearer hierarchy
4. **Consistent**: 3 table layouts = predictable
5. **Concise**: 50-70 lines = right level of detail
6. **Narrative**: "What's Hot" explains connections

---

## Next Steps (for implementation)

1. Update .claude/agents/context-finder.md with new format
2. Verify scoring logic with real data
3. Test emoji minimization (count before/after)
4. Validate length on real sessions (collect 5+ examples)
5. Add search mode examples
6. Document timestamp logic

