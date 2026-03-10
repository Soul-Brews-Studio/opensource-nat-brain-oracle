---
title: ## Nat-s-Agents vs Thai Community Setup Comparison (Corrected)
tags: [setup-comparison, ralph-wiggum, maw, hooks, best-practices]
created: 2026-01-04
source: Session Jan 4, 2026 - Setup comparison corrected
---

# ## Nat-s-Agents vs Thai Community Setup Comparison (Corrected)

## Nat-s-Agents vs Thai Community Setup Comparison (Corrected)

### What We BOTH Have
| Feature | Community | Nat-s-Agents |
|---------|-----------|--------------|
| Parallel agents | 5 terminals | MAW (5 agents) |
| CLAUDE.md | Shared team | Modular split |
| Slash commands | /commit-push-pr | /rrr, /trace, /recap |
| Subagents | Simplify code | context-finder, coder |
| ralph-wiggum | ✅ Long tasks | ✅ plugins/ralph-local/ |
| Hooks | PostToolUse | SessionStart, UserPromptSubmit |

### Our Unique Advantages
1. **Oracle philosophy** - Nothing deleted, patterns over intentions
2. **Modular CLAUDE.md** - Split into safety, workflows, subagents (lazy load)
3. **Haiku for subagents** - Token efficiency
4. **MAW orchestration** - maw peek, maw sync, maw hey
5. **ψ/ structure** - 5 pillars (active, inbox, writing, lab, memory)

### What We Could Add
1. PostToolUse hook for code formatting (CI linter issues)
2. /permissions pre-authorization (vs dangerously-skip)
3. @claude PR review tagging → CLAUDE.md updates

---
*Added via Oracle Learn*
