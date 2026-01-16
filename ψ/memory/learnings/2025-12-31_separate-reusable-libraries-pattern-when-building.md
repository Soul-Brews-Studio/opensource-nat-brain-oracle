---
title: Separate Reusable Libraries Pattern
tags: [library, reusable, separation, pattern]
created: 2025-12-31
source: Oracle Learn
---

# Separate Reusable Libraries Pattern

Separate Reusable Libraries Pattern

When building apps that need shared functionality, extract it early:

Example: fb-embedder needed embeddings → created local-embedder as separate package

Benefits:
- Future apps can import the library
- Cleaner separation of concerns  
- Can version and test independently

Package.json linking: `"local-embedder": "file:../local-embedder"`

Apply to: Authentication, database clients, API wrappers, utility functions

---
*Added via Oracle Learn*
