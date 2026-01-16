---
title: **Don't add technology because it's available - add it when it solves a problem*
tags: [yagni, architecture, simplicity, decision-making, graphql]
created: 2026-01-03
source: Oracle v2 architecture decision - 2026-01-03
---

# **Don't add technology because it's available - add it when it solves a problem*

**Don't add technology because it's available - add it when it solves a problem**

Evaluated adding drizzle-graphql to Oracle v2. The feature exists and integration is easy. But Oracle's core value is FTS5+ChromaDB hybrid search (which GraphQL can't help with) and MCP is the primary interface (not HTTP). Adding GraphQL would mean another port, server, and dependency set without solving any actual problem. Say no to cool tech that doesn't serve the use case. Document the "no" decision for future reference.

---
*Added via Oracle Learn*
