# Skills Auto-Trigger Pattern

**Date**: 2026-01-07

## What We Learned

- **Skills auto-trigger on phrases**, commands require explicit `/invoke`
- Both can coexist for the same functionality
- Skills = natural conversation flow, Commands = explicit control

### Trigger Design

| Element | Purpose |
|---------|---------|
| Name | Short identifier |
| Trigger phrases | Natural language that activates skill |
| Implementation | What to do when triggered |

### Good Trigger Phrases

```markdown
# trace.md triggers:
- "where is [project]?"
- "find [project]"
- "trace [topic]"
- "ตามหา [project]"

# oracle-query.md triggers:
- "ask oracle about [topic]"
- "consult oracle on [decision]"
- "ถาม oracle"
```

## How Things Connect

```
User says natural phrase
       ↓
Skill auto-triggers (if match)
       ↓
OR user explicitly invokes /command
       ↓
Same functionality, different entry points
```

### When to Use Which

| Use Skill | Use Command |
|-----------|-------------|
| Natural conversation | Need specific options |
| Quick lookup | Deep search (--deep flag) |
| Auto-triggered | Explicit control |

## Real Examples Created

| Skill | Triggers | Command Equivalent |
|-------|----------|-------------------|
| `trace.md` | "where is X?" | `/trace X` |
| `context-finder.md` | "what did we do?" | `/context-finder` |
| `oracle-query.md` | "ask oracle" | `/ask-oracle` |
| `schedule-calendar.md` | "show schedule" | `/schedule` |

## Tags

`skills` `commands` `auto-trigger` `pattern` `claude-code`
