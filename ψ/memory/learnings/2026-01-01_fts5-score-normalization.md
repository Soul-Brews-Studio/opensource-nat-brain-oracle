# FTS5 BM25 Score Normalization

**Date**: 2026-01-01
**Context**: Data-Aware RAG v3 - fixing confusing score display
**Impact**: Search results now show intuitive 0-100% scores

## The Problem

FTS5 BM25 scores are **negative** values where:
- Closer to 0 = better match
- More negative = worse match

Displaying raw scores like `-2.76` or multiplying by 100 (`-276%`) confuses users.

## The Solution

Normalize scores relative to the result set:

```typescript
function normalizeScores(results: SearchResult[]): Map<string, number> {
  const scores = new Map<string, number>()
  if (results.length === 0) return scores

  // BM25: closer to 0 is better
  const rawScores = results.map(r => r.score)
  const bestScore = Math.max(...rawScores)   // Closest to 0
  const worstScore = Math.min(...rawScores)  // Most negative

  for (const result of results) {
    let normalized: number
    if (bestScore === worstScore) {
      normalized = 100
    } else {
      // Linear scale: best → 100%, worst → 10%
      const range = bestScore - worstScore
      const position = (result.score - worstScore) / range
      normalized = 10 + (position * 90)
    }
    scores.set(result.id, Math.round(normalized))
  }

  return scores
}
```

## Key Insights

1. **Relative scoring** - Best in result set = 100%, not based on absolute threshold
2. **Floor at 10%** - Worst result still shows as 10%, not 0% (all results matched)
3. **Tooltip shows raw** - Hover reveals actual BM25 for debugging
4. **useMemo optimization** - Only recalculate when results change

## Before vs After

| Raw BM25 | Old Display | New Display |
|----------|-------------|-------------|
| -2.69 | -269% | 100% |
| -2.76 | -276% | 73% |
| -3.50 | -350% | 10% |

## Files Modified

- `frontend/src/components/SearchResults.tsx`

## Key Statement

> BM25 scores are implementation details. Users care about "how good is this match?" - show them 0-100% relative ranking.
