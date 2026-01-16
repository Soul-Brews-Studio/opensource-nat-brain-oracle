# Data-Aware RAG Development Lessons

**Date**: 2026-01-01
**Category**: Development Pattern
**Source**: Ralph loop session building data-aware-rag

---

## The Pattern: Explainable-First RAG

When building RAG systems, **show don't tell** - make every action visible and explainable.

## Key Lessons Learned

### 1. Debug Mode from Day One

**Problem**: Users ask "why 1,210 vs 256?" when indexing counts differ from raw counts.

**Solution**: Add `--debug` flag to ALL commands from the start.

```bash
# Every command should support this
rag explain --debug ./data/
rag index --debug ./data/
rag search --debug "query"
```

**Implementation**:
```typescript
interface Options {
  debug?: boolean;
}

function debugLog(options: Options, ...args: unknown[]) {
  if (options.debug) {
    console.log('[DEBUG]', ...args);
  }
}
```

### 2. Loader Interface Pattern

**Problem**: Different file formats (JSON, CSV, Markdown, TXT) need different parsing.

**Solution**: Create a standard `DataLoader` interface.

```typescript
interface DataLoader {
  canLoad(path: string): boolean;
  load(path: string): Promise<RawRecord[]>;
}

// Auto-detect format
const ext = extname(filePath);
const loader = getLoader(ext, options);
const records = await loader.load(filePath);
```

**What this enables**:
- Easy to add new formats (PDF, DOCX, etc.)
- Consistent debug logging across all loaders
- Single analysis pipeline for all formats

### 3. Separation: Analyzer vs Indexer

**Problem**: Analysis logic mixed with indexing logic creates confusion.

**Solution**: Clear separation of concerns.

| Component | Responsibility |
|-----------|---------------|
| **Analyzer** | Read files, detect types, count indexable, NO storage |
| **Indexer** | Take analyzed records, store to SQLite + ChromaDB |

**Why this matters**:
- Can run `explain` without side effects
- Can run `index --dry-run` to preview
- Easier to test each component

### 4. React Frontend with Debug Panel

**Problem**: CLI is great for developers, but visual debugging is faster.

**Solution**: Add debug toggle in React UI.

```tsx
const [debugMode, setDebugMode] = useState(false)
const [debugLog, setDebugLog] = useState<string[]>([])

// When search runs
if (debugMode && data.debug) {
  addDebugLog(`[FTS5] ${data.debug.fts_count} results`)
  addDebugLog(`[VECTOR] ${data.debug.vector_count} results`)
}
```

### 5. Hybrid Stack: Diesel + Drizzle + ChromaDB

**Learning**: Using multiple technologies for their strengths works well.

| Tech | Strength | Use For |
|------|----------|---------|
| Diesel (Rust) | Type-safe migrations | Schema definition |
| Drizzle (TypeScript) | Runtime ORM + Studio | Queries + visual browsing |
| ChromaDB | Vector search | Semantic similarity |
| SQLite FTS5 | Keyword search | Exact matching |

**Key insight**: Rust for Chromadb exists (`chromadb` crate v2.3.0), enabling pure Rust RAG if needed.

### 6. Tests Alongside Code

**Pattern**: Write tests as you build, not after.

```bash
# Run during development
bun test --watch

# Test structure mirrors src/
tests/
├── loaders/
│   ├── csv.test.ts    # Mirror src/loaders/csv.ts
│   └── text.test.ts
├── core/
│   └── analyzer.test.ts
└── e2e/
    └── pipeline.test.ts
```

---

## Architecture Decisions

### Why Diesel + Drizzle (not just one)?

| Just Drizzle | Diesel + Drizzle |
|--------------|------------------|
| Simpler setup | Type-safe migrations in Rust |
| TypeScript only | Can add Rust indexer later |
| Push migrations | Versioned SQL migrations |

**Verdict**: Start with Drizzle only, add Diesel when needing Rust perf.

### Why React + Vite (not embedded HTML)?

| Embedded HTML | React + Vite |
|---------------|--------------|
| Zero build step | Hot reload |
| Single file | Component reuse |
| Limited interactivity | Full React ecosystem |

**Verdict**: Start with embedded HTML for MVP, add React when UI grows.

---

## Fixes Made During Session

| Issue | Fix |
|-------|-----|
| Analyzer didn't support CSV | Added CSVLoader with auto-column detection |
| No debug output | Added `--debug` flag to analyzer + explain CLI |
| Markdown not chunked | Added section-based chunking by `##` headers |
| No tests | Added unit tests for loaders and analyzer |

---

## Project Files Created

```
ψ/lab/data-aware-rag/
├── src/
│   ├── loaders/
│   │   ├── csv.ts       # NEW
│   │   ├── text.ts      # NEW
│   │   └── index.ts     # NEW
│   ├── core/
│   │   ├── analyzer.ts  # UPDATED with debug
│   │   └── indexer.ts   # NEW
│   └── cli/
│       └── explain.ts   # UPDATED with --debug
├── frontend/            # NEW React app
│   ├── src/
│   │   ├── App.tsx
│   │   └── components/
│   │       ├── Dashboard.tsx
│   │       ├── SearchBox.tsx
│   │       ├── SourceBreakdown.tsx
│   │       └── DebugPanel.tsx
│   └── package.json
└── tests/               # NEW
    ├── loaders/
    └── core/
```

---

## Quick Reference

```bash
# Analyze with debug
bun run explain --debug ./data/*.json

# Run tests
bun test

# Start frontend
bun run frontend:dev

# Open Drizzle Studio
bun run studio
```

---

**Related**:
- `specs/003-data-aware-rag/spec.md` - Full specification
- `specs/003-generic-markdown-rag/spec.md` - Alternative markdown-focused spec
- `ψ/memory/learnings/2025-12-31_visual-answers-over-text-explanations.md` - Philosophy

---

**Tags**: #rag #debug-mode #explainable #typescript #react #testing
