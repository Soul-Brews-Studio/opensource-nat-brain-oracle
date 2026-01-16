---
title: Claude-mem Architecture & Oracle v2 Patterns
tags: [claude-mem, vector-db, mcp, chroma, speckit, ralph-loop]
created: 2025-12-29
session: 10.52_oracle-v2-exploration-session
---

# Claude-mem Architecture & Oracle v2 Patterns

> Deep dive into claude-mem's vector database architecture and lessons for Oracle v2

## 1. ChromaDB via MCP

claude-mem connects to ChromaDB via MCP protocol using the `chroma-mcp` Python package.

### Connection Pattern

```typescript
import { Client } from '@modelcontextprotocol/sdk/client/index.js';
import { StdioClientTransport } from '@modelcontextprotocol/sdk/client/stdio.js';

const transport = new StdioClientTransport({
  command: 'uvx',
  args: [
    '--python', '3.13',        // Python version (not 3.14+ due to onnxruntime)
    'chroma-mcp',
    '--client-type', 'persistent',
    '--data-dir', '~/.claude-mem/vector-db'
  ]
});

const client = new Client({ name: 'my-app', version: '1.0.0' }, { capabilities: {} });
await client.connect(transport);
```

### Chroma MCP Tools

| Tool | Purpose |
|------|---------|
| `chroma_create_collection` | Create vector collection |
| `chroma_add_documents` | Add documents with embeddings |
| `chroma_query_documents` | Semantic search |
| `chroma_get_documents` | Fetch by ID/filter |

### Key Insight

**Embeddings are local** - Chroma uses sentence-transformers (all-MiniLM-L6-v2, 384 dims) by default. Zero API cost.

---

## 2. Hybrid Search Pattern

claude-mem uses **vector + keyword** search combined:

```
Query
  ↓
┌─────────────────┬─────────────────┐
│  Chroma Vector  │   SQLite FTS5   │
│  (semantic)     │   (keyword)     │
└────────┬────────┴────────┬────────┘
         │                 │
         └────────┬────────┘
                  ↓
         Merge + Deduplicate
                  ↓
         Filter by recency (90 days)
                  ↓
         Hydrate from SQLite
                  ↓
         Return results
```

### Why Hybrid?

| Approach | Strength | Weakness |
|----------|----------|----------|
| Vector only | Semantic similarity | Misses exact matches |
| Keyword only | Exact matches | Misses synonyms |
| **Hybrid** | Both | Slightly more complex |

---

## 3. Granular Vector Documents

Instead of one vector per document, split into smaller chunks:

```typescript
// BAD: One document = one vector
{ id: 'obs_123', content: 'entire observation text...' }

// GOOD: One semantic unit = one vector
{ id: 'obs_123_narrative', content: 'the narrative part' }
{ id: 'obs_123_fact_0', content: 'first fact' }
{ id: 'obs_123_fact_1', content: 'second fact' }
```

### Benefits

- Better semantic precision
- Individual facts can match queries
- More hits per observation

---

## 4. 90-Day Recency Window

claude-mem filters results to last 90 days:

```typescript
const RECENCY_WINDOW_MS = 90 * 24 * 60 * 60 * 1000;
const recentIds = results.filter(r =>
  r.created_at_epoch > Date.now() - RECENCY_WINDOW_MS
);
```

### Why?

- Keeps results relevant
- Prevents stale matches
- Manageable index size

**Oracle Note**: Oracle principles are timeless - may not need recency filter.

---

## 5. speckit Already Has Oracle v2

**Discovery**: Issue #45 and `.specify/specs/045-oracle-v2-efficiency/` already exist!

### Existing Spec Contents

| Document | Content |
|----------|---------|
| spec.md | User scenarios, requirements, success criteria |
| plan.md | 4-phase implementation (Buffer, Cache, Frontmatter, Integration) |
| tasks.md | 30 tasks with dependency graph |
| research.md | Decisions from /debate sessions |
| data-model.md | Entity definitions |

### speckit Issue #45: Oracle v2 Efficiency

**Focus**: Efficiency improvements (different from MCP vector search)

| Phase | Goal | Files |
|-------|------|-------|
| 1: Buffer | Batch memory updates | `ψ/lib/oracle/buffer.py` |
| 2: Cache | Cache context-finder queries | `ψ/lib/oracle/cache.py` |
| 3: Frontmatter | Searchable retrospective tags | `ψ/lib/oracle/frontmatter.py` |
| 4: Integration | End-to-end testing | - |

**Key insight from spec**: Risk mitigation mentions "ChromaDB fallback" for grep slowness - they anticipated vector search!

### speckit Workflow Commands

```bash
# Create new feature (branch + directory)
.specify/scripts/bash/create-new-feature.sh "Description" --short-name "name"

# The 6-step workflow
/speckit.constitution  # Project principles (once per project)
/speckit.specify       # Define WHAT (user stories)
/speckit.clarify       # Resolve ambiguities (uses /debate)
/speckit.plan          # Technical HOW
/speckit.tasks         # Generate task checklist
/speckit.implement     # Execute tasks

# Analysis (non-destructive)
/speckit.analyze       # Cross-artifact consistency check
/speckit.checklist     # Generate custom checklist
```

### speckit Task Format

All tasks MUST follow this format:
```
- [ ] [T001] [P] [US1] Description with file path
```

| Part | Meaning |
|------|---------|
| `- [ ]` | Checkbox |
| `[T001]` | Task ID (sequential) |
| `[P]` | Parallelizable (optional) |
| `[US1]` | User Story reference |
| Description | Action + file path |

### Lesson

**Always search before building.** Could have used `/speckit.implement 45` instead of creating from scratch.

**speckit + Ralph pattern**: Use speckit for spec/plan, Ralph loop for implementation iteration.

---

## 6. Oracle MCP Prototype (ψ/lab/oracle-v2/)

Built during this session - a working MCP server for Oracle knowledge.

### Architecture

```
Claude Code
    ↓
oracle-v2 MCP Server (stdio)
    ↓
┌─────────────────────────────────────┐
│              3 Tools                 │
├───────────┬───────────┬─────────────┤
│  search   │  consult  │   reflect   │
└─────┬─────┴─────┬─────┴──────┬──────┘
      │           │            │
      ▼           ▼            ▼
┌──────────┐ ┌──────────┐ ┌──────────┐
│  Chroma  │ │  SQLite  │ │ ψ/memory │
│ (vector) │ │  (meta)  │ │ (source) │
└──────────┘ └──────────┘ └──────────┘
```

### MCP Tools

| Tool | Purpose | Input |
|------|---------|-------|
| `oracle_search` | Semantic search | `query`, `type?`, `limit?` |
| `oracle_consult` | Get guidance | `decision`, `context?` |
| `oracle_reflect` | Random wisdom | (none) |

### Indexer: Granular Vector Pattern

```typescript
// Parse ψ/memory/resonance/oracle.md
// Split by ### headers (principles)
// Each principle → main vector
// Each bullet → sub-vector

{ id: 'oracle_principle_1', content: 'Nothing is Deleted: ...' }
{ id: 'oracle_principle_1_sub_0', content: 'Append only, timestamps = truth' }
{ id: 'oracle_principle_1_sub_1', content: 'History is preserved, not overwritten' }
```

### Files Created

| File | Purpose |
|------|---------|
| `package.json` | Dependencies (MCP SDK, better-sqlite3, chromadb) |
| `src/types.ts` | TypeScript interfaces |
| `src/indexer.ts` | Parse ψ/memory → SQLite + Chroma |
| `src/index.ts` | MCP server with 3 tools |
| `SPEC.md` | Architecture documentation |

### To Run

```bash
cd ψ/lab/oracle-v2
npm install
npx tsx src/indexer.ts  # Index ψ/memory files
npx tsx src/index.ts    # Start MCP server
```

### To Add to Claude Code

```bash
claude mcp add oracle-v2 -- npx tsx /path/to/ψ/lab/oracle-v2/src/index.ts
```

### Key Difference from speckit #45

| speckit #45 | Lab Prototype |
|-------------|---------------|
| Buffer/Cache/Frontmatter | Vector search MCP |
| Python (`ψ/lib/oracle/`) | TypeScript (`ψ/lab/oracle-v2/`) |
| Grep-based search | Semantic search |
| Efficiency focus | Query focus |

**Potential merge**: speckit #45 Phase 5 could add ChromaDB as the "grep slowness fallback" mentioned in risk mitigation.

---

## 7. Claude MCP CLI

Manage MCP servers via CLI:

```bash
# List active MCP servers
claude mcp list

# Remove an MCP server
claude mcp remove playwright

# Add an MCP server
claude mcp add oracle-v2 npx oracle-v2-mcp
```

Config stored in `~/.claude.json` (project-scoped).

---

## 7. Safety Hooks Can Teach

Instead of just blocking, error messages should teach the safe alternative:

```bash
# Before (just blocks)
echo "BLOCKED: rm -rf not allowed." >&2

# After (teaches recovery pattern)
echo "BLOCKED: rm -rf not allowed." >&2
echo "Use: mv <path> /tmp/trash_\$(date +%Y%m%d_%H%M%S)_\$(basename <path>)" >&2
echo "Recovery: ls /tmp/trash_*" >&2
```

### Principle

**Hooks as teachers, not just guards.**

---

## 8. Ralph Loop + Opus Pattern

### Pattern

```
Ralph Loop (iteration)
    ↓
Sonnet agents (exploration, parallel)
    ↓
Opus agent (implementation, quality)
    ↓
Main agent (review, synthesis)
```

### Best Practices

| Setting | Recommendation |
|---------|----------------|
| `--max-iterations` | Set to 3-5 for focused work |
| `--completion-promise` | Define clear exit criteria |
| Agent model | Sonnet for exploration, Opus for code |

### Gotcha

Ralph loop without limits runs forever. Always set bounds.

---

## 9. speckit Workflow

The proper speckit workflow:

```bash
# 1. Create feature (handles branch + directory)
.specify/scripts/bash/create-new-feature.sh "Description" --short-name "name"

# 2. Specify (user stories, requirements)
/speckit.specify

# 3. Plan (technical design)
/speckit.plan

# 4. Tasks (actionable checklist)
/speckit.tasks

# 5. Implement
/speckit.implement
```

### Key Insight

**Use the scripts, don't create files manually.** Scripts handle branch creation, directory structure, and validation.

---

## Summary Table

| Pattern | What | When |
|---------|------|------|
| Chroma via MCP | Vector DB connection | Need semantic search |
| Hybrid search | Vector + FTS5 | Best of both worlds |
| Granular vectors | Split large docs | Better precision |
| Recency window | 90-day filter | Keep results fresh |
| speckit workflow | 6-step process | New features |
| speckit + Ralph | Spec → iterate → implement | Complex features |
| Oracle MCP | 3 tools (search/consult/reflect) | Query Oracle knowledge |
| Safety hooks teach | Error → instruction | Blocked commands |
| Claude MCP CLI | list/add/remove | Manage MCP servers |

## Two Oracle v2 Paths

| Path | Location | Focus | Status |
|------|----------|-------|--------|
| speckit #45 | `.specify/specs/045-*/` | Buffer/Cache/Frontmatter | Planned (30 tasks) |
| Lab prototype | `ψ/lab/oracle-v2/` | Vector search MCP | Created (working) |

**Decision needed**: Merge or choose one path.

---

## See Also

- [[ψ/memory/retrospectives/2025-12/29/10.52_oracle-v2-exploration-session|Session Retrospective]]
- [[ψ/lab/oracle-v2/SPEC.md|Oracle v2 Prototype Spec]]
- [[.specify/specs/045-oracle-v2-efficiency/spec.md|Original Oracle v2 Spec (speckit)]]

---

*Learned from: Ralph loop exploration of claude-mem*
*Created: 2025-12-29 10:52*
