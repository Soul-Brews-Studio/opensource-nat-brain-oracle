---
date: 2026-01-01
tags: [fts5, bm25, search, ui, modal, scroll, react, chartjs, data-aware-rag]
context: Data-Aware RAG frontend enhancement - Complete session
---

# Data-Aware RAG v2 - Frontend Fixes Complete

## The Problem

Two UI issues discovered during frontend testing:

1. **FTS5 scores showing as negative percentages** (-993%, -991%)
   - Users saw confusing negative scores like "-900%"
   - Made search results look broken

2. **Modal scroll issue**
   - When scrolling inside the popup modal, the background page scrolled instead
   - Modal content was not independently scrollable

## Root Causes

### FTS5 BM25 Scoring

FTS5 uses BM25 (Best Match 25) scoring algorithm:
- **More negative = better match** (counterintuitive!)
- Typical range: -50 to 0
- Score of -10 is BETTER than -5

```typescript
// WRONG: Assuming 0-1 range
const score = result.score * 100; // -993%!

// RIGHT: Convert negative BM25 to positive relevance
if (source === 'fts') {
  const relevance = Math.min(100, Math.abs(score) * 2);
  return `${relevance.toFixed(0)}%`;
}
```

### Modal Scroll Lock

CSS flexbox/grid children with `overflow: auto` need `min-height: 0` to shrink and enable scroll:

```css
/* Wrong: Content won't scroll */
.modal-body-grid {
  flex: 1;
  overflow: hidden;
}

/* Right: Allow shrink for scroll */
.modal-body-grid {
  flex: 1;
  min-height: 0; /* KEY! */
  overflow: hidden;
}

.modal-main-content {
  overflow-y: auto;
  min-height: 0; /* Also needed */
}
```

Also need to lock body scroll when modal opens:

```css
body.modal-open {
  overflow: hidden;
}
```

```typescript
// Toggle on open/close
document.body.classList.add('modal-open');
document.body.classList.remove('modal-open');
```

## The Solution

### Score Formatting Function

```typescript
function formatScore(score: number, source: string): string {
  if (source === 'fts') {
    // FTS5 BM25: more negative = better, convert to 0-100%
    const relevance = Math.min(100, Math.abs(score) * 2);
    return `${relevance.toFixed(0)}%`;
  } else if (source === 'vector') {
    // Cosine similarity: 0-1, higher = better
    return `${(score * 100).toFixed(0)}%`;
  } else {
    // Hybrid RRF score
    return score.toFixed(2);
  }
}
```

### Modal CSS Pattern

```css
.modal-overlay {
  position: fixed;
  overflow: hidden; /* Prevent background scroll */
}

.modal-content {
  display: flex;
  flex-direction: column;
  max-height: 90vh;
}

.modal-body {
  flex: 1;
  min-height: 0; /* CRITICAL for flex scroll */
  overflow-y: auto;
}
```

## Key Learnings

1. **Different search backends have different score semantics**
   - FTS5: negative (more negative = better)
   - Vector: 0-1 (higher = better)
   - Hybrid RRF: arbitrary positive numbers

2. **CSS flexbox scroll trap**
   - Children of flex containers need `min-height: 0` to shrink
   - Without it, `overflow: auto` won't create scrollbar

3. **Modal scroll lock**
   - Add `overflow: hidden` to body when modal opens
   - Remove it when modal closes
   - Handle all close paths: button, overlay click, ESC key

## Files Changed

- `frontend/src/components/SearchResults.tsx` - Score formatting
- `frontend/src/components/Explorer.tsx` - Modal with markdown + related docs
- `frontend/src/index.css` - Modal scroll styles
- `frontend/src/components/Charts.tsx` - Chart.js controller registration

---

## Bonus Fix: Chart.js Controllers

### Problem
Charts page was completely blank with error: `"bar" is not a registered controller`

### Root Cause
Chart.js v4+ requires explicit registration of controllers, not just elements and scales.

```typescript
// WRONG: Only registers elements
Chart.register(
  CategoryScale,
  LinearScale,
  BarElement,    // Element, not controller!
  LineElement,
  // ...
)

// RIGHT: Must also register controllers
Chart.register(
  // ... elements ...
  BarController,      // Controller for 'bar' type
  LineController,     // Controller for 'line' type
  DoughnutController, // Controller for 'doughnut' type
)
```

### Fix
Import and register the controllers:

```typescript
import {
  // ... existing imports ...
  BarController,
  LineController,
  DoughnutController,
} from 'chart.js'

Chart.register(
  // ... existing registrations ...
  BarController,
  LineController,
  DoughnutController
)
```

## Key Statement

> "Different search backends speak different score languages. FTS5's 'more negative is better' is counterintuitive but mathematically sound - always normalize scores for human display."

> "Chart.js v4+ tree-shaking requires explicit controller registration. The error 'X is not a registered controller' means you imported elements but forgot the controllers."

---

## Enhancement: Unified Modal UX (T052)

### Problem
SearchResults modal was basic (old style) while Explorer modal had full markdown + related docs. Inconsistent UX.

### Solution
Upgraded SearchResults to match Explorer:

```typescript
// Same pattern as Explorer
interface FullPreview {
  result: SearchResult
  fullContent: FullFileResponse | null
  related: RelatedDocument[]
  loading: boolean
  relatedLoading: boolean
  method?: string
}

// Fetch full content + related in parallel
const [fullContent, relatedResponse] = await Promise.all([
  fetchFullFile(sourceFile).catch(() => null),
  fetchRelated(result.id, 5).catch(() => ({ source_id: result.id, related: [], method: 'none' })),
])
```

### Result
- Both Dashboard search and Explorer browse use same enhanced modal
- Markdown rendering, full content, related docs sidebar
- Consistent UX across the app

---

## Session Summary

| Task | Fix | Impact |
|------|-----|--------|
| T046 | Markdown modal | Documents render beautifully |
| T047 | Full file API | Can see complete documents |
| T048 | Related docs API | Discovery of similar content |
| T049 | FTS5 score fix | -993% → 20% (readable) |
| T050 | Modal scroll lock | No background scroll |
| T051 | Chart.js controllers | Charts page works |
| T052 | SearchResults modal | Unified UX |

**Total: 52/52 tasks complete for Data-Aware RAG v2**
