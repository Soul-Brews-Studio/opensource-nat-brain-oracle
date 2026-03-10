---
title: ## /project reunion - The Missing Command
tags: [project-lifecycle, reunion, spinoff, oracle-sync, idea, command-design]
created: 2026-01-07
source: Session 2026-01-07 22:54 - Nat's insight after tracing lifecycle
---

# ## /project reunion - The Missing Command

## /project reunion - The Missing Command

**Insight** (2026-01-07 22:54): User noticed a gap in project lifecycle commands.

**Current commands**:
- `/project learn` → study external repo
- `/project create` → start new project  
- `/project incubate` → develop in ψ/incubate/
- `/project spinoff` → graduate to own repo

**Missing**: `/project reunion` → sync learnings back to central Oracle

**Pattern observed**: As projects graduate faster (spinoff velocity increasing), the need for reunion automation grows. Currently reunion is manual - graduated projects have their own ψ but don't report back.

**Proposed flow**:
```
/project create → /project incubate → /project spinoff → /project reunion
      🌱              🌕                   🎓                  🤝
```

**Key insight**: The 4-phase lifecycle (🌱→🌕→🎓→🤝) exists in philosophy but not in commands. `/project reunion` would complete the cycle by syncing learnings from graduated projects back to mother Oracle.

---
*Added via Oracle Learn*
