---
title: **Decision: Skip GraphQL for Oracle v2**
tags: [graphql, architecture, decision, drizzle, simplicity, yagni]
created: 2026-01-03
source: Architecture decision - 2026-01-03
---

# **Decision: Skip GraphQL for Oracle v2**

**Decision: Skip GraphQL for Oracle v2**

Evaluated adding drizzle-graphql to auto-generate GraphQL API from Drizzle schema. Decided against it because:

1. **Search is custom logic** - Core feature (FTS5 + ChromaDB hybrid) requires custom resolvers anyway
2. **MCP is primary interface** - Claude uses MCP protocol, not HTTP/GraphQL
3. **Simple data model** - Flat logging tables don't benefit from GraphQL's nested query strength
4. **REST already sufficient** - 12 clean endpoints cover all use cases
5. **Unnecessary complexity** - Another port, server, dependencies without solving real problems

**When to reconsider:**
- If Oracle becomes a public API
- If complex nested data relationships emerge
- If multiple clients need different data shapes

**Lesson:** Don't add technology because it's available. Add it when it solves a real problem.

---
*Added via Oracle Learn*
