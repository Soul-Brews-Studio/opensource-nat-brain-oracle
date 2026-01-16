# Learning: Embedding Provider Comparison

**Date**: 2026-01-02
**Context**: Data-Aware RAG vector search setup

## Two Approaches Tested

### 1. ChromaDB Default (384d)
```bash
# Package
bun add chromadb-default-embed  # 41 packages, uses ONNX

# Usage
EMBEDDING_PROVIDER=chromadb
CHROMA_COLLECTION=documents_384
```

- Uses MiniLM-L6-v2 via ONNX runtime
- 384 dimensions
- Runs in-process (no external server)
- Faster embedding generation

### 2. Ollama nomic-embed-text (768d)
```bash
# Setup
ollama pull nomic-embed-text  # 274 MB

# Usage
EMBEDDING_PROVIDER=ollama
OLLAMA_BASE_URL=http://localhost:11434
CHROMA_COLLECTION=documents  # or documents_768
```

- Uses nomic-embed-text model
- 768 dimensions
- Requires Ollama server running
- Slower (API calls per text)

## Test Results

Query: "oracle philosophy"

| Provider | Top Result | Score Type |
|----------|------------|------------|
| Ollama 768d | `ch01-oracle-philosophy.md` | Distance (lower=better) |
| ChromaDB 384d | `handoff-mcp/README.md` | Similarity (higher=better) |

**Ollama found the exact file**, ChromaDB found a related mention.

## Key Lessons

### 1. Dimension Matters
- 768d captures more semantic nuance than 384d
- For important searches, higher dimensions are worth the speed tradeoff

### 2. Can't Mix Dimensions
```
Error: Collection expecting embedding with dimension of 768, got 384
```
Use separate collections: `documents_768`, `documents_384`

### 3. Trade-offs

| Factor | ChromaDB Default | Ollama |
|--------|------------------|--------|
| Quality | Good | Better |
| Speed | ~10ms/batch | ~2-5s/batch |
| Setup | Just `bun add` | Need Ollama server |
| Resources | In-process | Separate server |

## Recommendation

- **Development/Testing**: ChromaDB default (fast)
- **Production/Quality**: Ollama nomic-embed-text (accurate)

## Environment Variables

```bash
# ChromaDB Default (384d)
EMBEDDING_PROVIDER=chromadb
CHROMA_COLLECTION=documents_384

# Ollama (768d)
EMBEDDING_PROVIDER=ollama
OLLAMA_BASE_URL=http://localhost:11434
CHROMA_COLLECTION=documents_768

# Shared
CHROMA_URL=http://localhost:8000
EMBEDDING_BATCH_SIZE=10
```
