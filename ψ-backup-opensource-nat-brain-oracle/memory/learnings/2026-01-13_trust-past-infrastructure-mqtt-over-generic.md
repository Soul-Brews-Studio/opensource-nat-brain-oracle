---
title: "Trust Past Infrastructure: MQTT Extension > Generic MCP"
tags: [lesson-learned, mqtt, claude-in-chrome, browser-automation, infrastructure, compound-tools]
created: 2026-01-13
source: Session 2026-01-13 /watch debugging
---

# Trust Past Infrastructure: MQTT Extension > Generic MCP

## The Pattern

When you've built specialized infrastructure (like MQTT extensions), **use it** instead of falling back to generic solutions.

## What Happened

| Approach | Time | Result |
|----------|------|--------|
| claude-in-chrome MCP (generic) | 15+ min | Failed, slow, refs changing |
| MQTT extension (specialized) | 2 min | Worked immediately |

## Why Generic Felt Safe

- Built into the system
- Always available
- Well documented
- "Should just work"

## Why Specialized Was Better

- Already invested time building it
- Designed for this exact use case
- Direct DOM access (no DevTools overhead)
- Stable selectors (not dynamic refs)

## The Compound Effect

```
Session 1: Build extension
Session 2: Add MQTT
Session 3: Add model selector
Session 4: Forget it exists, struggle with MCP
Session 5: Remember, use it, succeed instantly
```

**Past work compounds** - but only if you remember to use it.

## Action Items

1. **Check Oracle first** - Search for existing solutions before building new
2. **Trust specialized tools** - They exist for a reason
3. **Trace before debug** - 5 min tracing saves 20 min debugging

## Quick Decision Framework

```
Have we built a tool for this?
  YES → Use it (even if rusty)
  NO → Is there a generic solution?
    YES → Use generic
    NO → Build specialized
```

---

*"The best code is the code you already wrote."*
