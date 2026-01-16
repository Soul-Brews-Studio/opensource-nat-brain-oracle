---
title: Split Trace Queries Reveal Hidden Connections
tags: [trace, oracle, search, pattern, discovery]
created: 2026-01-14
source: rrr session 15.00_trace-poster-learn-deep-session
---

# Split Trace Queries Reveal Hidden Connections

## Pattern

When searching for multi-concept topics, **split the query** into individual concepts and search separately, then synthesize results.

## Discovery

Single query "philosophy beer oracle" returned 10 results, but the key insight ("AI cannot drink beer with your friend") was buried in lower-ranked results.

Split into three queries:
1. `oracle keeps human human` → Found FREEDOM learning directly
2. `beer brewing` → Found Nat's life arc (burnout → beer era → balance)
3. `philosophy consciousness` → Found soul/unity philosophy

**Result**: 3x richer context, discovered the explicit beer-philosophy connection that combined query missed.

## Why It Works

| Combined Query | Split Queries |
|----------------|---------------|
| Ranks by overall relevance | Each query optimizes for specific concept |
| May miss nuanced connections | Finds concept-specific documents |
| Single ranking algorithm | Multiple angles of discovery |

## When to Use

- Tracing multi-concept topics (e.g., "authentication security performance")
- Philosophy/abstract queries where concepts overlap
- When combined search returns < 5 highly relevant results

## Anti-Pattern

❌ Split every query (overkill for simple searches)
❌ Split into too many fragments (loses coherence)

## Example

```
# Instead of:
oracle_search("philosophy beer oracle")

# Do:
oracle_search("oracle keeps human human")
oracle_search("beer brewing life")
oracle_search("philosophy consciousness")
# Then synthesize results
```

---

*Learning captured: 2026-01-14 15:00*
