# Visual Answers Over Text Explanations

**Date**: 2025-12-31
**Category**: Pattern
**Source**: Session retrospective (headline-data-pipeline-visualizer)

## The Rule/Pattern

When a user asks "why" about data discrepancies, build a visualization instead of writing an explanation. Show, don't tell.

## Why It Matters

Text explanations of data require mental processing. A visual comparison is **instantly understood**. When Nat asked "why 1,210 vs 256?" a table didn't land — but a dashboard with bars, percentages, and color-coded categories made it obvious in 2 seconds.

This is especially critical for:
- Data pipeline debugging
- Coverage analysis
- Before/after comparisons

## Example

```
❌ TEXT ANSWER:
"1,210 records total, but only 256 indexed because 929 are images
which can't be embedded as vectors. Only text messages (281) are
indexable, and some are filtered during indexing."

✅ VISUAL ANSWER:
┌─────────────────────────────────────────────┐
│  1,210 Raw  │  256 Indexed  │  21.2% Coverage │
├─────────────────────────────────────────────┤
│  haze    ████████████████████████░░░░░ 92   │
│  ujic    ██░░░░░░░░░░░░░░░░░░░░░░░░░░░ 8    │
│  others  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ 0    │
└─────────────────────────────────────────────┘
```

## Application

1. When asked "why" about numbers → build a dashboard
2. When explaining data flow → create visual comparison
3. When debugging coverage → show raw vs processed side-by-side
4. Use embedded HTML in FastAPI for quick prototyping (no build step)

---

**Related**: `ψ/memory/retrospectives/2025-12/31/19.44_headline-data-pipeline-visualizer.md`
