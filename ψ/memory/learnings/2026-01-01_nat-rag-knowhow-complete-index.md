# Nat's RAG Knowhow: Complete Index & Design Guide

**Date**: 2026-01-01
**Category**: Knowledge Index
**Source**: Analysis of headline-rag, oracle-v2, and Arthur RAG systems

---

## Executive Summary

This document captures all RAG (Retrieval-Augmented Generation) knowledge accumulated from building three production systems:

1. **Headline-RAG** - Python + ChromaDB + Anthropic Claude
2. **Oracle-v2** - TypeScript + SQLite FTS5 + HTTP Server
3. **Arthur RAG** - React frontend + bilingual search integration

**Key Philosophy**: "Visual answers > text explanations"

---

## Part 1: RAG Systems Inventory

### 1.1 Headline-RAG (Python)

| Attribute | Value |
|-----------|-------|
| **Purpose** | Search Northern Thailand news |
| **Language** | Python 3.x |
| **Vector DB** | ChromaDB (persistent) |
| **Embeddings** | all-MiniLM-L6-v2 (ChromaDB default) |
| **API** | FastAPI |
| **LLM** | Anthropic Claude (claude-sonnet-4-20250514) |
| **Frontend** | React + Vite |
| **Data Source** | 7 U-LIB APIs (JSON) |
| **Documents** | 256 indexed |
| **Port** | 8000 |

**Key Files**:
```
/Users/nat/Code/github.com/laris-co/headline-rag/
├── api.py                    # FastAPI server
├── headline_rag/
│   ├── indexer.py           # ChromaDB indexing
│   └── rag.py               # RAG + Claude integration
├── frontend/                 # React UI
└── chroma_db/               # Vector store
```

**API Endpoints**:
| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/` | GET | Health check |
| `/ask` | POST | Search + LLM answer |
| `/search` | POST | Vector search only |
| `/index` | POST | Index new data |
| `/stats` | GET | Collection stats |
| `/api-breakdown` | GET | Per-source counts |

### 1.2 Oracle-v2 (TypeScript)

| Attribute | Value |
|-----------|-------|
| **Purpose** | Knowledge base for AI principles |
| **Language** | TypeScript 5.7 |
| **Vector DB** | ChromaDB (optional) |
| **Text Search** | SQLite FTS5 |
| **API** | Node.js http module |
| **LLM** | None (search only) |
| **Frontend** | Embedded HTML |
| **Data Source** | Markdown files |
| **Documents** | 163 principles + 200+ learnings |
| **Port** | 37778 |

**Key Files**:
```
/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/lab/oracle-v2/
├── src/
│   ├── server.ts            # HTTP server
│   ├── indexer.ts           # FTS5 + ChromaDB indexing
│   └── ui.html              # Web UI
├── oracle.db                 # SQLite database
└── chroma_db/               # Vector store (optional)
```

**API Endpoints**:
| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/` | GET | Arthur chat UI |
| `/oracle` | GET | Oracle knowledge UI |
| `/health` | GET | Health check |
| `/search` | GET | FTS5 + Vector search |
| `/list` | GET | Browse all documents |
| `/consult` | GET | Decision guidance |
| `/reflect` | GET | Random wisdom |
| `/stats` | GET | Database stats |
| `/learn` | POST | Add new learning |

### 1.3 Arthur RAG (Frontend Integration)

| Attribute | Value |
|-----------|-------|
| **Purpose** | Bilingual chat interface |
| **Language** | React + TypeScript |
| **Backend** | Oracle-v2 HTTP |
| **Features** | Thai + English query expansion |
| **Port** | 37778 (same as Oracle) |

---

## Part 2: Architecture Patterns

### 2.1 Core RAG Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    UNIVERSAL RAG PATTERN                     │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌─────────┐     ┌─────────┐     ┌─────────┐               │
│  │  DATA   │────▶│ INDEXER │────▶│  STORE  │               │
│  │ Sources │     │ (Parse) │     │ (DB)    │               │
│  └─────────┘     └─────────┘     └─────────┘               │
│       │                               │                     │
│       │ JSON/Markdown/API             │ ChromaDB/FTS5       │
│       ▼                               ▼                     │
│  ┌─────────┐     ┌─────────┐     ┌─────────┐               │
│  │  QUERY  │────▶│ SEARCH  │────▶│ RESULTS │               │
│  │ (User)  │     │ (Engine)│     │ (Ranked)│               │
│  └─────────┘     └─────────┘     └─────────┘               │
│       │                               │                     │
│       │ Optional                      │ Sources + Scores    │
│       ▼                               ▼                     │
│  ┌─────────┐     ┌─────────┐     ┌─────────┐               │
│  │   LLM   │◀────│ CONTEXT │────▶│ ANSWER  │               │
│  │ (Claude)│     │ Builder │     │ (Final) │               │
│  └─────────┘     └─────────┘     └─────────┘               │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 2.2 Hybrid Search Architecture (Oracle v2)

```
┌───────────────────────────────────────────────────┐
│              HYBRID SEARCH FLOW                   │
├───────────────────────────────────────────────────┤
│                                                   │
│  User Query: "safety in git operations"          │
│       │                                           │
│       ├──────────┬──────────────┐                │
│       │          │              │                │
│       ▼          ▼              ▼                │
│  ┌────────┐  ┌────────┐   ┌─────────┐           │
│  │ FTS5   │  │ChromaDB│   │Bilingual│           │
│  │Keyword │  │ Vector │   │Expansion│           │
│  │ Match  │  │Semantic│   │(Thai/EN)│           │
│  └────────┘  └────────┘   └─────────┘           │
│       │          │              │                │
│       ▼          ▼              ▼                │
│  Score: 0.8  Score: 0.6   Expanded: "ความปลอดภัย"│
│       │          │              │                │
│       └──────────┴──────────────┘                │
│                  │                               │
│                  ▼                               │
│         ┌───────────────┐                        │
│         │ Score Combine │                        │
│         │ Deduplicate   │                        │
│         │ Rank          │                        │
│         └───────────────┘                        │
│                  │                               │
│                  ▼                               │
│         Final Results (scored, ranked)          │
│                                                   │
└───────────────────────────────────────────────────┘
```

### 2.3 Search Type Comparison

| Feature | FTS5 (Keyword) | ChromaDB (Vector) | Hybrid |
|---------|---------------|-------------------|--------|
| **Speed** | Very fast | Fast | Medium |
| **Setup** | Easy (no deps) | Requires embed model | Complex |
| **Thai text** | Poor | Good | Good |
| **Synonyms** | No | Yes | Yes |
| **Exact match** | Excellent | Poor | Excellent |
| **Dependencies** | SQLite only | Python + model | Both |
| **Use case** | Known terms | Conceptual queries | Production |

---

## Part 3: Technical Learnings

### 3.1 ChromaDB Integration Lessons

1. **Metadata Must Be Primitives**
   ```python
   # WRONG
   metadata = {"concepts": ["git", "safety"]}

   # RIGHT
   metadata = {"concepts": "git,safety"}
   ```

2. **Batch Large Inserts**
   - For 4000+ documents, batch in chunks of 100
   - Prevents timeout and memory issues

3. **Use Upsert for Idempotency**
   ```python
   # Use upsert instead of add
   collection.upsert(
       documents=docs,
       metadatas=metas,
       ids=ids
   )
   ```

4. **Python Version Compatibility**
   - ChromaDB incompatible with Python 3.14
   - Use Python 3.12 or 3.13

5. **Path Resolution**
   - Always use absolute paths for ChromaDB
   - Relative paths fail when called from different directories

### 3.2 FTS5 (SQLite) Lessons

1. **Special Characters**
   ```typescript
   // Sanitize before FTS5 query
   const safeQuery = query
     .replace(/[?*+\-()^~"':]/g, ' ')
     .replace(/\s+/g, ' ')
     .trim();
   ```

2. **Thai Text Limitation**
   - FTS5 doesn't tokenize Thai well
   - Solution: Bilingual keyword expansion

3. **Clean Before Reindex**
   - `INSERT OR REPLACE` doesn't work as expected
   - Always `DELETE` then `INSERT`

### 3.3 API Design Patterns

**Standard RAG API**:
```
POST /search
{
  "query": "string",
  "n_results": 10,
  "filters": { "type": "principle" }
}

Response:
{
  "results": [
    {
      "content": "...",
      "score": 0.85,
      "source": "fts|vector|hybrid",
      "metadata": {...}
    }
  ],
  "total": 42,
  "query": "original query"
}
```

### 3.4 LLM Integration Pattern

```python
# System prompt for RAG answers
system_prompt = """คุณเป็น AI ที่ตอบคำถามจาก context ที่ให้มาเท่านั้น
ถ้าไม่มีข้อมูลให้บอกตรงๆ
อ้างอิงแหล่งข้อมูลด้วยหมายเลข [1], [2] เป็นต้น"""

# Context building
context = "\n\n".join([
    f"[{i}] ({src['api']}) {src['content'][:500]}"
    for i, src in enumerate(sources, 1)
])

# Claude call
message = anthropic.messages.create(
    model="claude-sonnet-4-20250514",
    max_tokens=1024,
    system=system_prompt,
    messages=[{"role": "user", "content": f"Context:\n{context}\n\nQuestion: {question}"}]
)
```

---

## Part 4: Code Artifacts

### 4.1 Minimal RAG Indexer (Python)

```python
import chromadb
from pathlib import Path
import json

class SimpleIndexer:
    def __init__(self, db_path="./chroma_db"):
        self.client = chromadb.PersistentClient(path=db_path)
        self.collection = self.client.get_or_create_collection("documents")

    def index_json(self, json_path: Path) -> int:
        with open(json_path) as f:
            data = json.load(f)

        documents, metadatas, ids = [], [], []
        for i, item in enumerate(data):
            text = item.get("text") or item.get("content")
            if not text or len(text.strip()) < 10:
                continue

            documents.append(text)
            metadatas.append({
                "source": str(json_path),
                "type": item.get("type", "text")
            })
            ids.append(f"{json_path.stem}_{i}")

        if documents:
            self.collection.upsert(
                documents=documents,
                metadatas=metadatas,
                ids=ids
            )
        return len(documents)
```

### 4.2 Minimal RAG Search (Python)

```python
class SimpleRAG:
    def __init__(self, db_path="./chroma_db"):
        client = chromadb.PersistentClient(path=db_path)
        self.collection = client.get_collection("documents")

    def search(self, query: str, n_results: int = 5):
        results = self.collection.query(
            query_texts=[query],
            n_results=n_results
        )
        return [
            {
                "content": doc,
                "metadata": meta,
                "score": 1 - dist
            }
            for doc, meta, dist in zip(
                results["documents"][0],
                results["metadatas"][0],
                results["distances"][0]
            )
        ]
```

### 4.3 FastAPI RAG Server Template

```python
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

app = FastAPI(title="My RAG API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000", "http://localhost:5173"],
    allow_methods=["*"],
    allow_headers=["*"],
)

class Query(BaseModel):
    question: str
    n_results: int = 5

@app.post("/search")
async def search(req: Query):
    rag = get_rag()  # Lazy load
    return {"results": rag.search(req.question, req.n_results)}

@app.get("/stats")
async def stats():
    return {"count": get_rag().collection.count()}
```

---

## Part 5: Philosophy & Principles

### 5.1 Oracle RAG Philosophy

1. **Nothing is Deleted** - Append-only, timestamps = truth
2. **Patterns Over Intentions** - Observe behavior, not promises
3. **External Brain, Not Command** - Mirror, don't decide

### 5.2 Headline RAG Philosophy

1. **Domain-Specific** - Northern Thailand news focus
2. **Bilingual Support** - Thai + English seamlessly
3. **Source Attribution** - Always cite with [1], [2], etc.
4. **Real-time Freshness** - Data currency matters

### 5.3 Design Principles for Generic RAG

| Principle | Description |
|-----------|-------------|
| **Pluggable Loaders** | Support JSON, Markdown, APIs |
| **Configurable Store** | ChromaDB, FTS5, or hybrid |
| **Standard API** | `/search`, `/ask`, `/stats`, `/index` |
| **Optional LLM** | Search-only or with answer generation |
| **Metadata Preservation** | Source tracking for attribution |
| **Graceful Degradation** | FTS5 fallback when ChromaDB fails |

---

## Part 6: Key Learnings Index

| Date | Learning | File |
|------|----------|------|
| 2025-12-29 | Hybrid search combining FTS5 + ChromaDB | `2025-12-29_oracle-v2-mcp-complete-hybrid-search-combining-ft.md` |
| 2025-12-29 | ChromaDB metadata must be primitives | `2025-12-29_chromadb-integration-lessons-1-metadata-m.md` |
| 2025-12-29 | ChromaDB Python 3.14 incompatibility | `2025-12-29_chromadb-python-314-compatibility-issue-proble.md` |
| 2025-12-31 | Visual answers > text explanations | `2025-12-31_visual-answers-over-text-explanations.md` |
| 2025-12-31 | Test-See-Implement pattern | `2025-12-31_test-see-implement-pattern-when-building-f.md` |
| 2025-12-31 | Arthur RAG testing workflow | `2025-12-31_arthur-rag-testing-workflow-the-complete-pict.md` |
| 2025-12-31 | Thai query improvements needed | `2025-12-31_arthur-rag-query-improvements-needed-probl.md` |

---

## Part 7: Retrospectives Index

| Date | Session | Focus |
|------|---------|-------|
| 2025-12-29 | Oracle v2 Hybrid Search | FTS5 + ChromaDB integration |
| 2025-12-30 | Arthur Voice UI Sprint | RAG + voice interface |
| 2025-12-31 | Headline RAG React Frontend | Complete E2E flow |
| 2025-12-31 | Headline Data Pipeline Visualizer | DuckDB + ChromaDB comparison |

---

## Part 8: Specifications Index

| Spec | Purpose | Status |
|------|---------|--------|
| `001-oracle-mcp` | Oracle MCP foundation | Complete |
| `002-hybrid-vector-search` | FTS5 + ChromaDB hybrid | Complete |
| `047-oracle-list` | Browse without search | Complete |
| `049-jarvis-oracle-integration` | Voice + RAG | Complete |
| `050-arthur-oracle-ui` | Chat UI for Oracle | Complete |
| `001-headline-duckdb-pipeline` | Data pipeline | Complete |
| `002-headline-data-visualizer` | Data visualization | Complete |

---

## Part 9: Next Steps & Improvements

### Identified Issues

1. **Thai Query Extraction** - FTS5 doesn't tokenize Thai well
2. **API Name Mismatch** - ChromaDB short names vs DuckDB full names
3. **Bilingual Dictionary** - Need expansion for better coverage

### Recommended Improvements

1. Add comprehensive RAG logging to console
2. Implement better Thai tokenization
3. Create unified API name mapping
4. Build generic RAG framework from patterns

---

## Quick Reference Card

```
HEADLINE-RAG          ORACLE-RAG           GENERIC-RAG
─────────────────────────────────────────────────────
Python + ChromaDB     TypeScript + FTS5    Configurable
FastAPI               http module          FastAPI
Claude LLM            No LLM               Optional LLM
React frontend        Embedded HTML        Your choice
Port 8000             Port 37778           Configurable
/ask, /search         /search, /consult    /ask, /search
```

---

**Last Updated**: 2026-01-01
**Author**: Nat + AI collaboration
**Tags**: #rag #chromadb #fts5 #knowledge-index #architecture
