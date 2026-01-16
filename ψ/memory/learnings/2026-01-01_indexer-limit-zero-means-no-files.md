---
title: "CLI Indexer Limit 0 Means No Files Not Unlimited"
date: 2026-01-01
concepts: [cli, indexer, edge-case, api-design]
---

# CLI Indexer Limit 0 Means No Files

## The Problem

Running `bun run scripts/index-data.ts "../../memory" 0` returned 0 files, not "all files" as expected.

## The Mistake

Assumed `limit=0` would mean "no limit" (unlimited). But in the implementation, `limit=0` literally means "limit to 0 files".

## The Fix

Use a high number for "unlimited": `bun run scripts/index-data.ts "../../memory" 10000`

## Better API Design

For future CLI tools, use more explicit conventions:

```typescript
// Option 1: Use -1 for unlimited
if (limit === -1) files = allFiles;
else files = allFiles.slice(0, limit);

// Option 2: Use "all" string
// bun run index.ts --limit all
// bun run index.ts --limit 100

// Option 3: Omit flag for unlimited
// bun run index.ts (no limit = all)
// bun run index.ts --limit 100 (explicit limit)
```

## Key Insight

`0` is ambiguous in limit contexts. Be explicit: use `-1` for unlimited, or design the API so omitting the flag means unlimited.

---

*Learned during: Data-Aware RAG Reindexing 2026-01-01*
