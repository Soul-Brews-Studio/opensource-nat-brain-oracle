---
title: ## ChromaDB + pnpm: Use chroma-mcp Instead of Direct Client
tags: [chromadb, pnpm, mcp, embeddings, chroma-mcp, claude-mem]
created: 2026-01-03
source: Oracle v2 indexer refactoring session
---

# ## ChromaDB + pnpm: Use chroma-mcp Instead of Direct Client

## ChromaDB + pnpm: Use chroma-mcp Instead of Direct Client

**Problem**: The `chromadb` npm package requires `chromadb-default-embed` for embeddings, but pnpm's strict module resolution breaks the dynamic import (`await import("chromadb-default-embed")`). Neither `shamefully-hoist=true` nor symlinks fix this.

**Solution**: Use `chroma-mcp` - a Python MCP server that handles embeddings server-side.

**Pattern**:
```
JS code → MCP Client → chroma-mcp (Python) → ChromaDB
```

**Implementation**:
1. Remove `chromadb` and `chromadb-default-embed` from npm dependencies
2. Create `ChromaMcpClient` class using `@modelcontextprotocol/sdk`
3. Launch chroma-mcp via: `uvx --python 3.12 chroma-mcp --client-type persistent --data-dir /path`
4. Use MCP tools: `chroma_create_collection`, `chroma_add_documents`, `chroma_query_documents`

**Key insight**: Learned from claude-mem - they solved the same problem the same way.

---
*Added via Oracle Learn*
