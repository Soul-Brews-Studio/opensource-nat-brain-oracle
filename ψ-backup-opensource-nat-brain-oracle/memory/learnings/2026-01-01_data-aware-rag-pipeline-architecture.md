---
title: "Data-Aware RAG Pipeline Architecture"
date: 2026-01-01
concepts: [dagster, rust, typescript, rag, pipeline, duckdb, chromadb]
---

# Data-Aware RAG Pipeline Architecture

## The Core Insight

**Explainable-First RAG**: Before indexing anything, understand what you have. Show the user what will be indexed, what will be skipped, and why.

## Architecture Decisions

### 1. Dual Language Stack

| Layer | Language | Why |
|-------|----------|-----|
| Data Pipeline | Python (Dagster) | Best orchestration ecosystem |
| CLI Tools | Rust | Type-safe, fast, single binary |
| Backend API | TypeScript (Bun) | Fast dev, good DX |
| Frontend | React + Vite | Modern, fast HMR |

**Lesson**: Don't force one language everywhere. Use the right tool for each job.

### 2. Asset-Based Pipeline (Dagster)

Instead of task-based (do X, then Y), we use asset-based:

```
discovered_files → data_analysis → raw_records → chunked_content
                                                        ↓
                                              ┌─────────┴─────────┐
                                              ↓                   ↓
                                         duckdb_index      chromadb_index
```

**Benefits**:
- Each asset is independently testable
- Clear data lineage
- Easy to re-run specific stages
- Full observability in Dagster UI

**Pattern**: Define what data products you want, not what tasks to run.

### 3. Hybrid Storage (DuckDB + ChromaDB)

| Store | Purpose | Query Type |
|-------|---------|------------|
| DuckDB | Structured data, SQL, FTS5 | Keyword search, analytics |
| ChromaDB | Vector embeddings | Semantic similarity |

**Hybrid Search Pattern**:
```python
# Combine with RRF (Reciprocal Rank Fusion)
for id, rank in fts_results:
    combined[id] += 1 / (k + rank)
for id, rank in vector_results:
    combined[id] += 1 / (k + rank)
```

### 4. Debug Mode Everywhere

Every command has `--debug` flag that shows:
- What files are being processed
- How content is classified
- Why records are skipped
- What gets indexed where

```bash
rag explain ./data --debug
# [MARKDOWN] file.md: 3 sections
#   → 3/3 indexable
# [JSON] data.json: 10 items
#   → 8/10 indexable (2 skipped: image content)
```

### 5. Loader Pattern

All file types use the same interface:

```python
def load_file(path: Path, debug: bool = False) -> list[RawRecord]:
    """Load a file, return records."""
    ...
```

Adding new format = just add new loader function.

### 6. Pydantic for Types

```python
class RawRecord(BaseModel):
    id: str
    content: str | None
    content_type: ContentType
    source_file: str
    source_type: SourceType
    metadata: dict = {}

    def is_indexable(self) -> bool:
        ...

    def skip_reason(self) -> str:
        ...
```

**Benefits**:
- Validation at boundaries
- Serialization for free
- Self-documenting API

## What We Fixed

### 1. Dagster ConfigurableResource

**Problem**: Using `@dataclass` with `ConfigurableResource` breaks Pydantic.

**Fix**: Just inherit from `ConfigurableResource`, don't use `@dataclass`:
```python
class DuckDBResource(dg.ConfigurableResource):
    database_path: str = "data/rag.duckdb"
```

### 2. ChromaDB API

**Problem**: Assumed `chromadb::v2` module in Rust.

**Fix**: Use correct imports:
```rust
use chromadb::ChromaClient;
use chromadb::collection::QueryOptions;
```

### 3. Markdown Section Parsing

**Problem**: Section title borrowed after content moved.

**Fix**: Clone the title before moving content:
```rust
let section_title = first_line.trim().to_string();  // Clone!
```

## Test Results

```
tests/test_loaders.py - 16 tests
tests/test_types.py - 13 tests
tests/test_assets.py - 10 tests
========================
39 passed, 0 failed
```

## Commands

```bash
# Dagster pipeline
cd pipeline && dagster dev -m rag_pipeline

# Rust CLI
./cli-rust/target/release/rag explain ./data --debug

# TypeScript CLI
bun run explain ./data/**/*.md

# Run tests
cd pipeline && uv run pytest tests/ -v
```

## Project Structure

```
ψ/lab/data-aware-rag/
├── cli-rust/           # Rust CLI (performance)
├── pipeline/           # Dagster pipeline (orchestration)
│   ├── rag_pipeline/   # Assets, loaders, resources
│   └── tests/          # 39 tests
├── frontend/           # React + Vite (UI)
├── src/                # TypeScript (API server)
└── drizzle/            # DB migrations
```

---

**Key Takeaway**: Build observability into the system from day one. Users need to understand what the RAG is doing before trusting its results.
