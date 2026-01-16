---
title: ## MISSION-02 Scoring Criteria (Parser Bug Hunt)
tags: [mission-02, squad-challenge, scoring, parser-bug, grading]
created: 2026-01-08
source: MISSION-02 Squad Challenge
---

# ## MISSION-02 Scoring Criteria (Parser Bug Hunt)

## MISSION-02 Scoring Criteria (Parser Bug Hunt)

### Answer Key (DO NOT SHARE PUBLICLY)

**4 Broken Files**:
1. `skill-alpha/references/api.md` - `description: [API reference...]`
2. `skill-beta/SKILL.md` - `description: [TODO: Add...]`
3. `skill-beta/operations/helpers.md` - `description: [helper, functions, utilities]`
4. `skill-delta/examples/usage.md` - `description: [Example usage...]`

**Root Cause**: YAML interprets `[...]` as array syntax. Parser calls `.split()` on array → crash.

### Scoring Rubric

| Criteria | Points | How to Score |
|----------|--------|--------------|
| Found file 1 | 10 | Exact path match |
| Found file 2 | 10 | Exact path match |
| Found file 3 | 10 | Exact path match |
| Found file 4 | 10 | Exact path match |
| Root cause: brackets | 10 | Mentions `[...]` or array |
| Root cause: YAML | 10 | Mentions YAML parsing |
| Documented timeline | 10 | Has timestamps |
| Documented steps | 10 | Clear methodology |
| Used isolation first | 5 | Removed all then restored |
| Used binary search | 5 | Batched restoration |
| Time under 15 min | 10 | Bonus |
| **Total** | **100** | |

### Partial Credit

- Found 3/4 files: 30 points
- Found 2/4 files: 20 points
- Found 1/4 files: 10 points
- Vague root cause: 5 points (instead of 20)
- No timestamps but has steps: 5 points (instead of 10)

### Example Perfect Submission

```
Files: skill-alpha/references/api.md, skill-beta/SKILL.md, 
       skill-beta/operations/helpers.md, skill-delta/examples/usage.md

Root cause: YAML parses [text] as array, .split() fails on array

Steps:
0:00 - Moved all skills to backup → works
0:02 - Restored skill-alpha, skill-beta → crashes
0:03 - Removed skill-beta → still crashes
0:04 - Checked skill-alpha/SKILL.md → OK
0:05 - Checked skill-alpha/references/api.md → Found [API...] bracket!
... (continues with clear timeline)

Time: 8 minutes
```

Score: 100/100

---
*Added via Oracle Learn*
