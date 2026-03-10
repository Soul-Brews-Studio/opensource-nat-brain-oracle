---
title: ## Ralph Loop Pattern for Long-Running Tasks
tags: [ralph-loop, speckit, subagents, workflow, iteration]
created: 2025-12-29
source: Ralph Loop Session - Oracle v2 Implementation
---

# ## Ralph Loop Pattern for Long-Running Tasks

## Ralph Loop Pattern for Long-Running Tasks

The Ralph Loop creates a self-referential iteration cycle:

1. **Same prompt feeds back** - Forces continuation until truly complete
2. **Work visible in files** - Each iteration sees previous progress
3. **Natural completion** - Stop when promise fulfilled

### When to Use
- Complex multi-phase implementations
- Research that requires depth
- Tasks needing multiple tool calls

### Key Insight
Ralph Loop + Speckit + Subagents = Powerful combination:
- Speckit creates structure (spec → plan → tasks)
- Subagents handle bulk work (Haiku for heavy lifting)
- Ralph Loop ensures completion (iterate until done)

This session: 66 minutes, 28 tasks, 4479 documents indexed.

---
*Added via Oracle Learn*
