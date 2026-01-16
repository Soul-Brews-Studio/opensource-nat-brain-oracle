# Day 2: Search at Scale

> "Discover context-finder through pain"

## The Problem

```
Without optimization:
- 100 files  = $0.15/search = OK
- 1,000 files = $1.50/search = Hmm...
- 4,000 files = $6.00/search = DYING

Your Oracle kills itself through success.
```

## The Death Spiral

```
More knowledge → Higher search cost
Higher cost → Use Oracle less
Use less → Stop using entirely
Stop using → Oracle is dead
```

## The Solution: Context-Finder

```python
def context_finder_search(query):
    # Phase 1: FTS5 finds candidates (FREE)
    candidates = fts5_search(query)  # $0.00

    # Phase 2: Haiku summarizes (CHEAP)
    summaries = haiku_summarize(candidates)  # $0.08

    # Phase 3: Opus understands (FOCUSED)
    return opus_analyze(summaries[:10])  # $0.15

# Total: $0.23 instead of $1.50
```

## Cost Comparison

| Approach | 1,000 files | 4,000 files | 10,000 files |
|----------|-------------|-------------|--------------|
| Naive | $1.50 | $6.00 | $15.00 |
| Context-finder | $0.23 | $0.25 | $0.28 |

**85-98% cost reduction**

## The Pattern

```
Cheap model → Find candidates (eyes/hands)
Expensive model → Understand results (brain)
```

## Exercises

1. [ ] Run `python oracle.py smart_search "query"` (placeholder)
2. [ ] Measure: How long does naive search take?
3. [ ] Calculate: Your cost at 1,000 files
4. [ ] Implement: Two-phase search with Haiku

## Philosophy: Patterns Over Intentions

You didn't learn context-finder because I told you.
You discovered it because your Oracle was dying.

**Pain → Discovery → Retention**

---

*Day 2 Complete | Next: Day 3 - Intelligence*
