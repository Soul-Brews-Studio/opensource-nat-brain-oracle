---
title: Ralph loop hook keeps firing even after loop is deactivated (active: false). The
tags: [ralph-loop, hook, bug, stale-feedback]
created: 2025-12-30
source: Session observation 2025-12-30
---

# Ralph loop hook keeps firing even after loop is deactivated (active: false). The

Ralph loop hook keeps firing even after loop is deactivated (active: false). The hook should check the loop state file before sending feedback. Observed 100+ stale "Stop hook feedback" messages in a single session after task completion.

---
*Added via Oracle Learn*
