# Parallel Subagent Vault Pattern

**Date**: 2025-12-14 02:55
**Context**: Building Obsidian vault from 7 APIs (1,243 records) using parallel subagents
**Source**: Agent 1 lesson learned (headline-analyzer incubation)

## The Pattern

```
1. EXPLORE   → Sample data, understand schema
2. SCAFFOLD  → Create directory structure (main agent)
3. DELEGATE  → Spawn parallel subagents (no overlapping writes)
4. AGGREGATE → Main agent creates indexes/connections
5. VERIFY    → Count files, spot-check quality
```

## What Worked Well

1. **Parallel Subagent Processing**
   - Each subagent handled one API independently
   - No blocking, fast execution (~190 seconds for 433 files)
   - Clear responsibility separation

2. **Vault Structure Before Content**
   - Created skeleton first: `mkdir -p ψ/{messages,senders,groups,daily,sources}`
   - Subagents write directly without conflicts

3. **Pre-indexed Content**
   - INDEX files map sender names → file counts
   - Thai vs English content understanding

## Challenges & Solutions

| Challenge | Solution |
|-----------|----------|
| Concurrent writes to shared files | Use source-prefixed filenames |
| Thai filenames in git | ASCII slugs for files, Thai in content |
| Global context after subagents | Main agent creates INDEX.md manually |

## Key Insight

> **Subagents excel at embarrassingly parallel work (one file → many outputs). Main agent owns cross-cutting concerns (indexes, deduplication, quality).**

## Anti-pattern

```
❌ Spawn subagents → let them all write to same files → conflicts
```

## Correct Pattern

```
✅ Main creates structure → subagents write to non-overlapping files → main aggregates
```

## Results

| Metric | Value |
|--------|-------|
| Files created | 433 |
| Processing time | ~190 seconds |
| APIs processed | 7 (parallel) |
| Messages indexed | 298 |
| Senders indexed | 72 |

## Related

- `2025-12-14_headline-knowledge-graph-system.md`
- `2025-12-13_subagent-delegation-pattern.md`

## Tags

#subagents #parallel #obsidian #vault #pattern
