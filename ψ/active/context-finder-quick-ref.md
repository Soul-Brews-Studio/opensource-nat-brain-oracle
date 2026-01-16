# Context-Finder Output Format - Quick Reference Card

## Structure (5 Sections)

```
1. Status Header
   🔵 FOCUSED (2h) | Last change 5m ago

2. Files in Motion
   | Score | File | Changed | Status |
   [top 4-5 files by score]

3. Git State
   - Staged: [files]
   - Modified: [files]
   - Untracked: [count]
   - Branch: [name]

4. Recent Activity
   ### Last 5 Commits
   [table with When | Commit | Message]
   
   ### Active Issues
   [table with # | Title | Age]
   
   ### Latest Retrospectives
   [table with Date | Title]

5. What's Hot
   [2-3 sentence narrative]
```

## Scoring Formula

```
Score = Recency + Type + Impact

Recency:
  < 1 hour    = +3
  < 4 hours   = +2
  < 24 hours  = +1

Type:
  Code (.ts,.js,.go,.py,.html,.css) = +3
  Agent/command (.claude/*)          = +2
  Docs (.md, outside ψ/)             = +1
  Logs/retros (ψ/*)                  = +0

Impact:
  Core (CLAUDE.md, package.json)     = +2
  Config files                       = +1

Result: Show top 4-5 files, rest hidden in "Other (N items)"
```

## Emoji Rules

GOOD emoji:
- 🔵 FOCUSED / 🟡 SCATTERED / ⚪ IDLE (status)
- ⭐ for score 6+ (visual weight)
- 🕐 for timestamps (section markers)

BAD emoji:
- 🔴🟠🟡⚪ in every file row (noisy)
- Emoji for file types
- Emoji for status badges (use: M=Modified, A=Added)

## Timestamp Format

DO:
- "5m ago" (human, relative)
- "2h" (concise)
- "2025-12-20" (retro dates)

DON'T:
- "1766805419" (epoch alone)
- "2025-12-20T14:30:00Z" (ISO in tables)
- "14:30" (no context, seems random)

## Output Rules

1. File table sorted by score (descending)
2. All tables use consistent layout
3. Show only top 5 commits (not 10)
4. Show only top 3 retros
5. Filter issues to "context:" prefix only
6. Total length: 50-70 lines (max 80)
7. Scoring legend shown once (under Files table)
8. Status header + What's Hot (narrative bookends)

## SEARCH MODE Changes

When called with query:
- Remove scoring
- Group by source: Commits | Issues | Files | Retrospectives
- Show match count per source
- Include excerpts for retros
- Example: "### Commits (3 matches)"

## Validation Checklist

Before outputting:
- [ ] File table sorted by score descending
- [ ] Only top 4-5 files shown
- [ ] Timestamps are human-readable
- [ ] No section exceeds 15 lines
- [ ] Total: 50-70 lines
- [ ] Scoring legend visible (once)
- [ ] What's Hot section explains narrative
- [ ] Emoji count: status (3) + weight (1) = 4 max
- [ ] Timestamp at bottom: 🕐 END: HH:MM:SS

## Example: Files in Motion (with scoring)

```
| Score | File | Changed | Status |
|-------|------|---------|--------|
| 6+ ⭐ | .claude/settings.json | 5m | M (staged) |
| 4-5 | ψ/WIP.md | 12m | M |
| 2-3 | ψ/memory/slugs.yaml | 25m | M |

*Legend: Recency (3/2/1) + Type (3/2/1) + Impact (2/1) = Score*
```

## Example: Git State (clean bullets)

```
**Git State**
- Staged: .claude/settings.json
- Modified: ψ/WIP.md, ψ/memory/slugs.yaml
- Untracked: 2 items
- Branch: main
```

(No table, just bullets = cleaner)

