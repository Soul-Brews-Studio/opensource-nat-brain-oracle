---
title: ## Test → See → Implement Pattern
tags: [testing, implementation, browser-automation, proof, screenshots, verification, workflow]
created: 2025-12-31
source: headline-rag React frontend development 2025-12-31
---

# ## Test → See → Implement Pattern

## Test → See → Implement Pattern

When building features, ALWAYS follow this cycle:

### 1. IMPLEMENT
- Write the code (backend, frontend, etc.)
- Create files, configure dependencies

### 2. TEST
- Use browser automation (dev-browser skill)
- Make REAL API calls with actual data
- Click buttons, fill forms, submit queries

### 3. SEE
- Take SCREENSHOTS as proof
- Show the actual UI with real responses
- Display data: counts, sources, content samples

### Anti-Pattern (WRONG)
```
✗ Create files → Show code → Say "it should work"
✗ Mock responses → Assume success
✗ Just describe what would happen
```

### Correct Pattern (RIGHT)
```
✓ Create files → Start servers → Browser automation
✓ Real API calls → Wait for Claude response
✓ Screenshot showing: question + answer + sources
✓ Query database → Show actual indexed data
```

### Example from headline-rag
1. Created FastAPI + React frontend
2. Started both servers
3. Browser: typed Thai question "มีข่าว PM2.5 อะไรบ้าง?"
4. Waited for Claude RAG response
5. Screenshot showing: 5-point answer + source badges (haze 83%)
6. Queried ChromaDB: 199 docs across 5 APIs

The proof is in the screenshot, not the code.

---
*Added via Oracle Learn*
