---
title: ## Ralph Wiggum Plugin for Claude Code
tags: [claude-code, ralph-wiggum, autonomous-agent, plugin, while-loop, max-iterations]
created: 2026-01-13
source: /watch skill - YouTube transcript 2026-01-13
---

# ## Ralph Wiggum Plugin for Claude Code

## Ralph Wiggum Plugin for Claude Code

**What**: Plugin that transforms Claude Code into an autonomous agent using "while loop" logic.

**Key Features**:
- Constantly checks against success criteria until ALL goals are met
- Best for massive features or "one-shotting" entire applications
- NOT for small tasks - use standard workflow instead

**Critical Settings**:
- `max_iterations`: Set cap (e.g., 30) to prevent infinite loops and cost overruns
- Success criteria: Define guardrails like "no linter errors", "updated documentation"

**Prompt Structure**:
```
/ralph_loop
Requirements: [detailed feature list]
Success Criteria: [guardrails]
Max Iterations: 30
```

**Pro Tips**:
- Use multiple terminal windows (Ghosty) to multitask while it works
- Terminals save memory vs VS Code
- Warning: High usage on lower-tier plans

**Source**: Alex Finn YouTube (30K views)

---
*Added via Oracle Learn*
