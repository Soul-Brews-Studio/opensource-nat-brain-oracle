---
date: 2026-01-01
tags: [vector-search, chromadb, fallback, graceful-degradation, hybrid-search]
context: Data-Aware RAG - Adding vector search with graceful fallback
---

# Graceful Vector Search Fallback Pattern

## The Problem

Vector search requires an external service (ChromaDB). Users may not have it running, but the CLI should still be useful.

## The Solution

Implement **graceful degradation** with clear feedback:

### 1. Mode-Specific Behavior

```typescript
// Vector mode: fail with helpful message
if (mode === 'vector') {
  console.log('⚠️ ChromaDB not available. Start with: docker run -p 8000:8000 chromadb/chroma');
  return;
}

// Hybrid mode: continue with FTS only
// For hybrid, continue with just FTS results
```

### 2. Show Error in Pipeline (Debug Mode)

```
┌─────────────────────────────────────────────┐
│ Search Pipeline                              │
├─────────────────────────────────────────────┤
│ 1. [0ms]    Parse query  "oracle" → [oracle │
│ 2. [1ms]    Open DB      bun:sqlite ready   │
│ 3. [1ms]    FTS5 search  6 hits             │
│ 4. [7ms]    ChromaDB     ERROR: connection  │  ← Shows error but continues
│ 5. [1ms]    Group files  3 files → top 3    │
├─────────────────────────────────────────────┤
│ Total: 10ms                                 │
└─────────────────────────────────────────────┘
```

### 3. Return Partial Results

```typescript
try {
  // Try vector search
  const vectorResults = await chromaSearch(query);
  // RRF merge if successful
} catch (e) {
  // Log error in pipeline
  pipeline.push({ step: N, name: 'ChromaDB', detail: `ERROR: ${e.message}` });

  // For hybrid: continue with FTS only
  // For vector: return early with helpful message
}
```

## Key Principles

| Principle | Implementation |
|-----------|----------------|
| Fail helpfully | Show how to fix (docker command) |
| Degrade gracefully | Hybrid falls back to FTS |
| Be transparent | Show error in debug pipeline |
| Never crash | Catch all ChromaDB errors |

## Applied In

- `data-rag search --mode vector` - Fails with helpful message
- `data-rag search --mode hybrid` - Falls back to FTS only
- Debug mode shows which step failed

## The Insight

> "A CLI that works partially is better than one that crashes completely. Users can still be productive while they fix the missing dependency."
