---
title: ChromaDB Python 3.14 Compatibility Issue
tags: [chromadb, python, compatibility, troubleshooting]
created: 2025-12-29
source: Ralph Loop Session
---

# ChromaDB Python 3.14 Compatibility Issue

ChromaDB Python 3.14 Compatibility Issue

**Problem**: ChromaDB installed via `uv pip` with Python 3.14 fails with pydantic import error:
```
pydantic.errors.PydanticImportError: `BaseSettings` has been moved to the `pydantic-settings` package
```

**Root Cause**: Python 3.14 is too new, causes dependency conflicts with pydantic v2.

**Solution**:
1. Move old venv: `mv .venv /tmp/trash_$(date +%Y%m%d_%H%M%S)_.venv`
2. Create fresh venv with Python 3.12: `/opt/homebrew/bin/python3.12 -m venv .venv`
3. Install chromadb: `.venv/bin/pip install chromadb`
4. Start server: `.venv/bin/chroma run --path ./chroma_data --port 8000`

**Key Insight**: Always use stable Python version (3.12) for ChromaDB, not bleeding edge (3.14).

---
*Added via Oracle Learn*
