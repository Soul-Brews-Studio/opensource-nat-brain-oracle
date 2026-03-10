# ChromaDB Requires Python 3.12 (Not 3.14)

**Date**: 2025-12-30
**Category**: Discovery
**Source**: Session retrospective - Oracle v2 hybrid search

## The Rule

Use Python 3.12 for ChromaDB, not bleeding-edge versions (3.14). Pydantic v2 compatibility issues break ChromaDB with newer Python.

## Why It Matters

ChromaDB fails to import with Python 3.14 due to pydantic changes:
```
pydantic.errors.PydanticImportError: `BaseSettings` has been moved to `pydantic-settings`
```

This blocks vector search entirely - no embeddings, no semantic queries.

## Example

```bash
# ❌ WRONG - Python 3.14 breaks ChromaDB
python3.14 -m venv .venv
.venv/bin/pip install chromadb
# ERROR: pydantic BaseSettings import error

# ✅ CORRECT - Python 3.12 works
mv .venv /tmp/trash_$(date +%Y%m%d_%H%M%S)_.venv
/opt/homebrew/bin/python3.12 -m venv .venv
.venv/bin/pip install chromadb
.venv/bin/chroma run --path ./chroma_data --port 8000
# SUCCESS: ChromaDB server running
```

## Prevention/Application

1. Always check Python version before installing ChromaDB
2. Use `python3.12` explicitly, not `python3` (which may point to 3.14)
3. If ChromaDB fails with pydantic errors, recreate venv with older Python
4. Check `/opt/homebrew/bin/python3.*` for available versions

## Verification

```bash
.venv/bin/python -c "import chromadb; print(chromadb.__version__)"
# Should print: 1.4.0 (or similar)

curl http://localhost:8000/api/v2/heartbeat
# Should return: {"nanosecond heartbeat":...}
```

---

**Related**:
- [Oracle v2 Hybrid Search Retrospective](../retrospectives/2025-12/30/06.59_oracle-v2-hybrid-search-complete.md)
- [specs/002-hybrid-vector-search/](../../specs/002-hybrid-vector-search/)
