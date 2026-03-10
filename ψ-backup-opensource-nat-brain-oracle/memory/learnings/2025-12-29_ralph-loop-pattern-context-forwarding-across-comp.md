---
title: Ralph Loop Pattern: Context Forwarding Across Compacts
tags: [ralph-loop, context-forwarding, speckit, auto-compact]
created: 2025-12-29
source: Ralph Loop Session
---

# Ralph Loop Pattern: Context Forwarding Across Compacts

Ralph Loop Pattern: Context Forwarding Across Compacts

When user enables auto-compact with ralph-loop, the AI should:

1. **Detect Current State**: Read statusline.json, check speckit tasks.md, review recent commits
2. **Continue Work**: Pick up where previous session left off
3. **Track Progress**: Update tasks.md as work completes
4. **Commit Incrementally**: Small commits preserve progress
5. **Prepare for Next Iteration**: Leave clear state for next ralph-loop cycle

Key files for context:
- `ψ/active/statusline.json` - token usage, session info
- `specs/*/tasks.md` - speckit task tracking
- `ψ/memory/retrospectives/` - session history

Pattern used successfully in Oracle v2 hybrid search implementation (23/28 tasks complete).

---
*Added via Oracle Learn*
