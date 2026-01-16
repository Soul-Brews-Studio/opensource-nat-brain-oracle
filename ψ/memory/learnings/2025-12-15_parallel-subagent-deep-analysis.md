# Parallel Subagent Deep Analysis Pattern

**Date**: 2025-12-15

## What We Learned

- **10 parallel agents** can analyze large datasets faster than sequential
- Spawn in single message = true parallelism
- Haiku for data gathering, Opus for synthesis
- Each agent returns structured report → main agent merges

## Pattern

```
Main Agent (Opus)
    ├── Agent 1 (Haiku) → Messages analysis
    ├── Agent 2 (Haiku) → Posts analysis
    ├── Agent 3 (Haiku) → Reactions analysis
    ├── ...
    └── Agent 10 (Haiku) → Events analysis
        ↓
    Collect all results
        ↓
    Main synthesizes final report
```

## Key Insight

> "Main agent orchestrates, subagents do heavy lifting"

- 68,975 rows analyzed in ~3 minutes
- Each agent focused on one domain
- No context bleed between agents
- Main agent keeps full picture

## When to Use

| Scenario | Use Parallel Agents? |
|----------|---------------------|
| Large dataset analysis | ✅ Yes |
| Multi-file search | ✅ Yes |
| Single file edit | ❌ No |
| Sequential dependencies | ❌ No |

## How Things Connect

- `/update` command uses 7 parallel agents
- FB Explorer analysis used 10 parallel agents
- Both follow same pattern: spawn → collect → synthesize

## Tags

`subagents` `parallel` `haiku` `data-analysis` `pattern`
