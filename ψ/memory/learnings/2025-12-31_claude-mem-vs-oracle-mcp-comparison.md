---
title: "Claude-Mem vs Oracle MCP: Feature Comparison"
tags: [mcp, claude-mem, oracle, comparison, memory]
created: 2025-12-31
source: Ralph Loop Analysis
---

# Claude-Mem vs Oracle MCP: Feature Comparison

## Overview

Both systems provide MCP (Model Context Protocol) tools for AI memory and knowledge retrieval, but with different focuses:

| Aspect | claude-mem | Oracle MCP |
|--------|------------|------------|
| **Purpose** | Cross-session memory persistence | Philosophy/knowledge base search |
| **Storage** | SQLite database (claude-mem.db) | SQLite FTS5 + ChromaDB vectors |
| **Scope** | Session observations, prompts, work | Principles, learnings, retrospectives |
| **Focus** | "What did we do?" | "What should we do?" |

---

## Tool Comparison

### claude-mem Tools (5 tools)

| Tool | Purpose | Parameters |
|------|---------|------------|
| `search` | Search observations, sessions, prompts | query, limit, project, type, dateStart, dateEnd, obs_type |
| `timeline` | Get chronological context around an anchor | anchor (ID or query), depth_before, depth_after |
| `get_recent_context` | Latest session summaries | limit, project |
| `get_context_timeline` | Timeline around specific observation ID | anchor (required), depth_before, depth_after |
| `progressive_description` | Get usage documentation on-demand | topic: workflow, search_params, examples, all |

### Oracle MCP Tools (5 tools)

| Tool | Purpose | Parameters |
|------|---------|------------|
| `oracle_search` | Hybrid FTS5 + vector search | query, type, limit, offset, mode (hybrid/fts/vector) |
| `oracle_consult` | Get guidance on decisions | decision, context |
| `oracle_reflect` | Random wisdom for reflection | (none) |
| `oracle_learn` | Add new pattern/learning | pattern, source, concepts |
| `oracle_list` | Browse all documents | type, limit, offset |

---

## Functional Mapping

| Capability | claude-mem | Oracle MCP |
|------------|------------|------------|
| **Keyword Search** | `search` with query | `oracle_search` (FTS5) |
| **Semantic Search** | No | `oracle_search` (ChromaDB vector) |
| **Timeline/Context** | `timeline`, `get_context_timeline` | No equivalent |
| **Recent Activity** | `get_recent_context` | No equivalent |
| **Add Knowledge** | Automatic (via hooks) | `oracle_learn` (manual) |
| **Browse All** | `search` with filters | `oracle_list` |
| **Decision Guidance** | No | `oracle_consult` |
| **Random Wisdom** | No | `oracle_reflect` |
| **Documentation** | `progressive_description` | No equivalent |

---

## Key Differences

### 1. Data Model

**claude-mem** tracks:
- **Observations**: Individual work items with types (bugfix, feature, decision, discovery, change)
- **Sessions**: Grouped work with start/end times
- **Prompts**: User requests with summaries

**Oracle MCP** tracks:
- **Principles**: Core philosophy statements
- **Patterns**: Learned behaviors
- **Learnings**: Extracted knowledge
- **Retrospectives**: Session reviews

### 2. Search Approach

| Aspect | claude-mem | Oracle MCP |
|--------|------------|------------|
| **Default** | Keyword (FTS5) | Hybrid (FTS5 + Vector) |
| **Semantic** | No | Yes (ChromaDB) |
| **Scoring** | Single score | Combined FTS + vector scores |
| **Fallback** | N/A | Graceful to FTS5 if ChromaDB unavailable |

### 3. Context Features

**claude-mem** excels at temporal context:
- `timeline`: Shows what happened before/after an event
- `get_context_timeline`: Anchor-based timeline
- `get_recent_context`: Quick session summaries

**Oracle MCP** has no temporal context tools but offers:
- `oracle_consult`: Decision-making guidance
- `oracle_reflect`: Random wisdom surfacing

### 4. Write Operations

| System | Write Method |
|--------|--------------|
| claude-mem | Automatic via hooks (pre-commit, post-response) |
| Oracle | Manual via `oracle_learn` tool |

---

## Integration Opportunities

### What Oracle Could Learn from claude-mem

1. **Timeline Tools**: Add `oracle_timeline` for temporal context around knowledge items
2. **Progressive Description**: Add on-demand documentation tool
3. **Observation Types**: Track observation categories (bugfix, feature, etc.)
4. **Session Context**: Link knowledge to sessions for "what was happening when"

### What claude-mem Could Learn from Oracle

1. **Semantic Search**: Add vector embeddings for better relevance
2. **Consult Mode**: Add decision guidance synthesis
3. **Random Reflection**: Add serendipitous discovery
4. **Hybrid Scoring**: Combine keyword + semantic scores

---

## Usage Patterns

### When to Use claude-mem

```
"Did we solve this before?"
"What happened last week?"
"Show context around observation #123"
"What was the last session about?"
```

### When to Use Oracle MCP

```
"Should I use force push?"
"What are the principles about safety?"
"Give me some random wisdom"
"Add this pattern to knowledge base"
```

---

## Recommendation

**Use Both Together**:
- claude-mem for **session memory** (what happened)
- Oracle MCP for **knowledge retrieval** (what to do)

They complement each other:
- claude-mem captures work → Oracle stores learnings
- Oracle guides decisions → claude-mem tracks outcomes

---

*Generated via Ralph Loop analysis, 2025-12-31*
