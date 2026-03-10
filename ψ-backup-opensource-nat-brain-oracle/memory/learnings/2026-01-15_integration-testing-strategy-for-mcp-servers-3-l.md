---
title: Integration Testing Strategy for MCP Servers:
tags: [integration-testing, mcp, drizzle, sqlite, fts5, ci, github-actions]
created: 2026-01-15
source: Session 2026-01-15 - Oracle-v2 integration tests
---

# Integration Testing Strategy for MCP Servers:

Integration Testing Strategy for MCP Servers:

3-layer integration test approach:

1. **Database Tests** (most reliable, run in CI)
   - Use Drizzle ORM with test database
   - Apply migrations from files
   - Test CRUD + FTS5 + business logic
   - Cleanup after each run

2. **HTTP API Tests** (requires running server)
   - beforeAll: spawn server, wait for health
   - afterAll: kill server
   - Test endpoints, error handling, pagination

3. **MCP Tests** (requires running server)
   - Spawn MCP server with stdio
   - Send JSON-RPC requests
   - Test tool listing and execution

Key patterns:
- Separate test DB from production (`~/.oracle-v2/test-integration.db`)
- Use migration files directly in tests
- FTS5 requires raw SQL (Drizzle doesn't support)
- CI runs only reliable tests (unit + database)

---
*Added via Oracle Learn*
