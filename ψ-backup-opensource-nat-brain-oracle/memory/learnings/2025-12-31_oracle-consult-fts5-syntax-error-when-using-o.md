---
title: **Oracle Consult FTS5 Syntax Error**
tags: [oracle, fts5, error, debugging]
created: 2025-12-31
source: Oracle Learn
---

# **Oracle Consult FTS5 Syntax Error**

**Oracle Consult FTS5 Syntax Error**

When using oracle_consult, avoid special characters in queries that confuse FTS5:
- Characters that cause errors: `? * + - ( ) ^ ~ " ' :`
- The word "timer" caused "no such column: timer" error

**Solution**: Use simple keyword queries without special characters. Use oracle_search for complex queries instead, as it has better escaping.

**Example**:
- Bad: `oracle_consult("What CLI tool like session-timer?")`
- Good: `oracle_search("CLI tool simple pattern")`

---
*Added via Oracle Learn*
