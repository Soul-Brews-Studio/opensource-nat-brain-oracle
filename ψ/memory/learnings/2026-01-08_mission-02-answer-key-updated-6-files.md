---
title: ## MISSION-02 Answer Key (Updated - 6 files)
tags: [mission-02, answer-key, parser-bug, 6-files]
created: 2026-01-08
source: MISSION-02 Answer Key v2
---

# ## MISSION-02 Answer Key (Updated - 6 files)

## MISSION-02 Answer Key (Updated - 6 files)

### Broken Files (6 total)

**Skills (4)**:
1. `skill-alpha/references/api.md` - `description: [API reference...]`
2. `skill-beta/SKILL.md` - `description: [TODO: Add...]`
3. `skill-beta/operations/helpers.md` - `description: [helper, functions, utilities]`
4. `skill-delta/examples/usage.md` - `description: [Example usage...]`

**Commands (2)**:
5. `challenge-commands/status.md` - `description: [Check system status and health]`
6. `challenge-commands/rollback.md` - `description: [TODO: Rollback to previous version]`

### Valid Files (6 total)
- skill-alpha/SKILL.md
- skill-beta/operations/workflow.md
- skill-gamma/SKILL.md
- skill-delta/SKILL.md
- challenge-commands/deploy.md
- challenge-commands/backup.md

### Root Cause
YAML interprets `[...]` as array. Parser calls `.split()` on array → crash.

---
*Added via Oracle Learn*
