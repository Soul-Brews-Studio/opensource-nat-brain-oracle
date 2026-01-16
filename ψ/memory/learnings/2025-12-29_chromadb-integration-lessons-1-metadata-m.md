---
title: ## ChromaDB Integration Lessons
tags: [chromadb, vector-database, indexing, mcp]
created: 2025-12-29
source: Ralph Loop - Oracle v2 Implementation
---

# ## ChromaDB Integration Lessons

## ChromaDB Integration Lessons

### 1. Metadata Must Be Primitives
ChromaDB metadata values must be strings, integers, floats, or booleans - NOT arrays.

**Wrong**: `{ concepts: ["git", "safety"] }`
**Right**: `{ concepts: "git,safety" }`

### 2. Batch Large Inserts
For 4000+ documents, batch in chunks of 100 to avoid timeouts.

### 3. Clean Before Reindex
FTS5 INSERT OR REPLACE does not work as expected. Always DELETE first.

### 4. ChromaClient Connects to Server
`new ChromaClient()` connects to default server at localhost:8000, NOT local file.

### 5. Use Upsert for Idempotency
Use `collection.upsert()` instead of `add()` to handle duplicate IDs gracefully.

---
*Added via Oracle Learn*
