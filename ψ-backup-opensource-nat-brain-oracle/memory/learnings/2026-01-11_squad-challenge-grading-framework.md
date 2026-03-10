---
title: Squad Challenge Grading Framework
tags: [grading, framework, squad-challenge, oracle, rubric, scoring]
created: 2026-01-11
source: Oracle Grading Sessions
---

# Squad Challenge Grading Framework

## Core Principles

1. **Results Matter** — Did they solve the problem? (methodology is flexible)
2. **Documentation Required** — Timestamps, steps, reasoning
3. **Blog is REQUIRED** — "เรียนฟรี แต่ช่วยกันส่งต่อความรู้"
4. **Creative Approaches Welcome** — Alternative solutions get credit
5. **Provisional Until Published** — All scores pending blog link

---

## Standard Rubric (100 points)

| Category | Points | Description |
|----------|--------|-------------|
| **Core Task** | 30-40 | Completed main objective |
| **Understanding** | 20 | Root cause / why it works |
| **Documentation** | 20 | Timestamps + methodology |
| **Extras** | 10-20 | Bonus challenges completed |
| **Blog** | 10 | Published on Medium |

---

## Mission-Specific Rubrics

### MISSION-01: Voice Integration

| Criteria | Points |
|----------|--------|
| Voice Tray working | 30 |
| Different voices per agent | 20 |
| Config shown | 10 |
| Steps documented | 10 |
| Extra challenges | 20 |
| Blog post | 10 |

**Extra Challenges**:
- ⭐ Voice Speed tuning
- ⭐⭐ Thai Voice (Edge TTS)
- ⭐⭐⭐ MQTT Setup
- ⭐⭐⭐⭐⭐ Linux/Windows Support

---

### MISSION-02: Parser Bug Hunt

| Criteria | Points |
|----------|--------|
| Found all 6 files | 30 |
| Root cause: brackets | 10 |
| Root cause: YAML | 10 |
| Timestamps | 10 |
| Steps documented | 10 |
| Methodology | 10 |
| Speed bonus | 10 |
| Blog post | 10 |

**Note**: Speed bonus requires timestamp proof

---

## Grading Process

```bash
# 1. Get answer key from Oracle
oracle_search("mission-XX scoring")

# 2. Fetch submissions
gh issue view 1 --repo Soul-Brews-Studio/[repo] --comments
gh pr list --repo Soul-Brews-Studio/[repo] --state all

# 3. Score each submission
# 4. Post individual feedback comments
# 5. Create grading report issue
# 6. Log to Oracle
# 7. Commit to Nat-s-Agents
```

---

## Partial Credit Rules

| Scenario | Adjustment |
|----------|------------|
| Missing timestamps | -5 to -10 pts |
| Brief methodology | -5 pts |
| Speed claim without proof | Half points |
| Creative alternative | +5 bonus possible |
| Draft but not published | 5/10 for blog |
| Vague root cause | 5/20 instead of 20/20 |

---

## Comment Format

```markdown
# 🔮 The Oracle Speaks — Grading

> *"The Oracle Keeps the Human Human"*
> **Graded**: YYYY-MM-DD HH:MM GMT+7

---

## 📊 Score: XX/100 ⭐⭐⭐

| Criteria | Points |
|----------|--------|
| ... | ... |

---

## 🌟 Highlights

- ...

## 📝 Areas for Improvement

- ...

---

## 🎯 Final Verdict

> **[EXCELLENT/GOOD/SOLID] SUBMISSION!**
>
> ...

---

*🔮 The Oracle remembers every journey.*
```

---

## Report Issue Format

**Title**: `🔮 MISSION-XX Grading Report (YYYY-MM-DD)`

**Content**:
1. Summary table (all scores)
2. Detailed breakdown per submission
3. Answer key reference
4. Extra challenges matrix
5. Pending actions (blog links needed)
6. Oracle philosophy footer

---

## Grading Sessions Completed

| Date | Mission | Submissions | Report |
|------|---------|-------------|--------|
| 2026-01-11 | MISSION-02 | 4 | [#5](https://github.com/Soul-Brews-Studio/mission-02-parser-debug/issues/5) |
| 2026-01-11 | MISSION-01 | 4 | [#2](https://github.com/Soul-Brews-Studio/oracle-voice-tray/issues/2) |

---

## Oracle Query Cheatsheet

```bash
# Get answer key
oracle_search("mission-01 ground truth")
oracle_search("mission-02 scoring")

# Get grading framework
oracle_search("grading framework")

# Get templates
oracle_search("squad challenge template")
```

---

*Framework created: 2026-01-11*
*Part of "Level Up with AI" — Squad Team*
