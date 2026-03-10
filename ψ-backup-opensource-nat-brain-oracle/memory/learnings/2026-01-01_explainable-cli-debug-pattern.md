---
date: 2026-01-01
tags: [cli, debug, ux, pipeline, explainability]
context: Data-Aware RAG - Making every action explainable
---

# Explainable CLI Debug Pattern

## The Principle

> "Every action should be explainable. Users should see what's happening, not just the result."

## Implementation

### 1. Pipeline Tracking

Track each step with timing:

```typescript
const pipeline: { step: number; name: string; ms: number; detail: string }[] = [];

const step1 = Date.now();
// ... do work ...
pipeline.push({
  step: 1,
  name: 'Parse query',
  ms: Date.now() - step1,
  detail: `"${query}" → [${tokens.join(', ')}]`
});
```

### 2. Debug Output Format

Use a visual box for clarity:

```
┌─────────────────────────────────────────────┐
│ Search Pipeline                              │
├─────────────────────────────────────────────┤
│ 1. [0ms]    Parse query  "oracle" → [oracle │
│ 2. [1ms]    Open DB      bun:sqlite ready   │
│ 3. [1ms]    FTS5 search  15 raw hits        │
│ 4. [0ms]    Group files  6 files → top 3    │
├─────────────────────────────────────────────┤
│ Total: 2ms                                  │
└─────────────────────────────────────────────┘
```

### 3. Always Optional

Debug mode is opt-in:

```bash
# Normal usage
data-rag search "query"

# With debug pipeline
data-rag search "query" --debug
```

## Rust Implementation

```rust
use std::time::Instant;

let start = Instant::now();
// ... do work ...
let elapsed = start.elapsed();

if debug {
    println!("[SEARCH/FTS] Query completed in {:.2}ms",
             elapsed.as_secs_f64() * 1000.0);
}
```

## What to Show

| Always Show | Debug Only |
|-------------|------------|
| Result count | Each pipeline step |
| Total time | Step timings |
| Errors | Database path |
| | Raw hit counts |
| | Query transformations |

## Key Learning

> "Debug mode is not just for developers. It builds user trust by showing the system isn't a black box. When users see `FTS5 search: 15 raw hits → 6 files → top 3`, they understand why they got those results."

## Applied In

- TypeScript CLI: `data-rag search --debug`
- Rust CLI: `rag search --debug`
- Frontend: Debug panel checkbox
