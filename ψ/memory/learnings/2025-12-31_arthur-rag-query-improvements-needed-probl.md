---
title: ## Arthur RAG Query Improvements Needed
tags: [arthur, rag, search, thai, improvement, logging, ui]
created: 2025-12-31
source: Oracle Learn
---

# ## Arthur RAG Query Improvements Needed

## Arthur RAG Query Improvements Needed

### Problem Found
When asking "นัทเป็นคนยังไง" (Thai), Arthur didn't find the info.
When asking "Who is Nat?" (English), Arthur found it and gave detailed response.

### Root Cause
- Thai text search may not work well with FTS5
- RAG query extraction from Thai questions needs improvement

### Improvements Needed
1. **Consult Logs** - Log every RAG query + results for debugging
2. **Display UI** - Show what Oracle returned in Arthur UI
3. **Bilingual Search** - Search both Thai and English terms
4. **Query Extraction** - Better extraction from Thai questions

### User Request
- Want to see RAG consultation logs
- Want UI to display what Oracle found

---
*Added via Oracle Learn*
