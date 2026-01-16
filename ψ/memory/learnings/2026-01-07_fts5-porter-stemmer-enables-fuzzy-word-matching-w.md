---
title: FTS5 Porter Stemmer enables fuzzy word matching. Without it, "tired" and "tire" 
tags: [fts5, porter-stemmer, hybrid-search, sqlite, vector]
created: 2026-01-07
source: Session 2026-01-07
---

# FTS5 Porter Stemmer enables fuzzy word matching. Without it, "tired" and "tire" 

FTS5 Porter Stemmer enables fuzzy word matching. Without it, "tired" and "tire" are different words. Add `tokenize='porter unicode61'` to FTS5 table definition. Requires table rebuild for existing data - backup, DROP, CREATE with stemmer, re-insert. Combined with vector search as "always hybrid" (not just fallback) gives best results: FTS for exact matches, vector for semantic similarity, bonus for appearing in both.

---
*Added via Oracle Learn*
