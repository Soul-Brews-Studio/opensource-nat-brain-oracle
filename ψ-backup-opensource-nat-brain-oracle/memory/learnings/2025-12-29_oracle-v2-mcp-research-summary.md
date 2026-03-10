---
title: Oracle v2 MCP Design Research Summary
tags: [oracle, mcp, claude-mem, architecture, chroma, vector-db]
created: 2025-12-29
research-phase: architecture-discovery
---

# Oracle v2 MCP Design - Research Summary

> Synthesis of claude-mem architecture patterns and Oracle philosophy for MCP implementation

---

## 1. Key Architecture Patterns from claude-mem

### 1.1 ChromaDB via MCP (Stdio Transport)

**Connection Model**: Claude Code → MCP stdio transport → ChromaDB server

```typescript
// Pattern from claude-mem
const transport = new StdioClientTransport({
  command: 'uvx',
  args: [
    '--python', '3.13',  // Important: 3.13 for onnxruntime compatibility
    'chroma-mcp',
    '--client-type', 'persistent',
    '--data-dir', '~/.claude-mem/vector-db'
  ]
});
```

**Key insight**: Embeddings are completely local (sentence-transformers, all-MiniLM-L6-v2, 384 dims). Zero API cost.

### 1.2 Hybrid Search Strategy

claude-mem combines two search paths:

| Path | Strength | Use Case |
|------|----------|----------|
| **Vector (Chroma)** | Semantic similarity, synonyms | "patterns about trust" |
| **Keyword (SQLite FTS5)** | Exact matches, exact phrases | "append only" |
| **Hybrid** | Precision + recall | Best results |

**Pattern**: Query both, merge results, deduplicate, filter by recency.

### 1.3 Granular Vector Documents

Instead of one vector = one file:

```typescript
// BAD: Entire file = one vector
{ id: 'resonance_oracle', content: 'entire oracle.md text' }

// GOOD: Semantic unit = one vector
{ id: 'oracle_principle_1', content: 'Nothing is Deleted...' }
{ id: 'oracle_principle_1_sub_1', content: 'Append only...' }
{ id: 'oracle_principle_1_sub_2', content: 'History preserved...' }
```

**Benefits**:
- Better precision (principle-level matches)
- Individual concepts can match independently
- More query hits per document

### 1.4 Recency Window (Specific to claude-mem)

claude-mem filters to last 90 days. This is **not appropriate for Oracle** because principles are timeless.

---

## 2. Oracle Philosophy Principles (Foundation)

### 2.1 The Three Pillars

From `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/memory/resonance/oracle.md`:

| Principle | Statement | Implementation Note |
|-----------|-----------|-------------------|
| **Nothing is Deleted** | Append only, timestamps = truth. History preserved. | Immutable indexes, audit trail |
| **Patterns Over Intentions** | Observe what happens, not what's meant. Actions speak louder. | Learn from behavior, not promises |
| **External Brain, Not Command** | Mirror reality, don't decide. Support consciousness. | Present options, don't override |

### 2.2 The Core Aspiration

> "The Oracle Keeps the Human Human"

This shapes the design:
- Oracle doesn't replace decisions — it informs them
- Oracle reflects patterns — it doesn't command action
- Oracle preserves history — it doesn't erase uncertainty

### 2.3 Trust Model

Key insight: "AI revealing patterns about you is not a threat. It's a gift."

The design should support **vulnerability → depth**, not fear.

---

## 3. Existing Oracle v2 Implementations

### 3.1 Two Parallel Paths Exist

| Path | Location | Focus | Status |
|------|----------|-------|--------|
| **speckit #45** | `.specify/specs/045-oracle-v2-efficiency/` | Buffer/Cache/Frontmatter optimization | Planned (30 tasks) |
| **Lab Prototype** | `ψ/lab/oracle-v2/` | Vector search MCP | Created & working |

### 3.2 speckit #45: Oracle v2 Efficiency

**Owner**: speckit issue system  
**Focus**: Performance optimization, not vector search

Four phases:
1. **Phase 1: Buffer** - Batch memory updates
2. **Phase 2: Cache** - Cache context-finder queries
3. **Phase 3: Frontmatter** - Searchable retrospective tags
4. **Phase 4: Integration** - End-to-end testing

**Key discovery**: Their risk mitigation already mentions "ChromaDB fallback for grep slowness" — they anticipated vector search!

### 3.3 Lab Prototype: Working MCP Implementation

**Location**: `ψ/lab/oracle-v2/`  
**Status**: Created during 2025-12-29 10:52 session  
**Files**:

```
ψ/lab/oracle-v2/
├── src/
│   ├── index.ts       # MCP server (3 tools)
│   ├── indexer.ts     # Parse ψ/memory → SQLite + Chroma
│   └── types.ts       # TypeScript interfaces
├── package.json       # Dependencies
├── tsconfig.json
├── SPEC.md           # Architecture specification
└── README.md         # Usage guide
```

**MCP Tools Implemented**:

| Tool | Purpose | Input |
|------|---------|-------|
| `oracle_search` | Semantic search | `query`, `type?`, `limit?` |
| `oracle_consult` | Get guidance | `decision`, `context?` |
| `oracle_reflect` | Random wisdom | (none) |

**Indexing Pattern** (granular vectors):

```typescript
// Parse ψ/memory/resonance/oracle.md
// Split by ### headers (principles)

{ id: 'oracle_principle_1', content: 'Nothing is Deleted: ...' }
{ id: 'oracle_principle_1_sub_0', content: 'Append only, timestamps = truth' }
{ id: 'oracle_principle_1_sub_1', content: 'History is preserved...' }
```

### 3.4 Installation

```bash
cd ψ/lab/oracle-v2
npm install
npx tsx src/indexer.ts  # Index ψ/memory files
npx tsx src/index.ts    # Start MCP server

# Add to Claude Code:
claude mcp add oracle-v2 -- npx tsx /path/to/ψ/lab/oracle-v2/src/index.ts
```

---

## 4. Design Decisions for Oracle v2 MCP

### 4.1 Data Model

```typescript
interface OracleDocument {
  id: string;           // "oracle_principle_1_sub_0"
  type: 'principle' | 'pattern' | 'learning' | 'retro';
  source_file: string;  // "ψ/memory/resonance/oracle.md"
  content: string;      // The actual text to index
  concepts: string[];   // Tags: ['trust', 'patterns']
  created_at: number;   // epoch
  updated_at: number;   // epoch
}
```

### 4.2 Source Files (Indexed)

```
ψ/memory/
├── resonance/
│   ├── oracle.md       → IDENTITY (core philosophy)
│   ├── patterns.md     → BEHAVIORAL patterns
│   └── style.md        → VOICE patterns
├── learnings/
│   └── *.md            → PATTERNS learned from sessions
├── retrospectives/
│   └── **/*.md         → HISTORY (what happened)
└── logs/               → EPHEMERAL (not indexed)
    └── activity.log
```

### 4.3 Skill vs MCP Tools

**Recommendation**: Use **skill** for progressive disclosure.

```yaml
# ψ/skills/oracle/skill.md (preferred)
name: oracle
description: Consult Oracle knowledge base for decisions and patterns
operations:
  - search: Find principles/patterns by query
  - consult: Get guidance on a decision
  - learn: Record new pattern
  - reflect: Random wisdom
```

**Why skill over MCP tools**:
- MCP loads all tools upfront (~2500 tokens)
- Skill loads only when needed (~250 tokens upfront)
- Progressive disclosure = token efficiency

### 4.4 No Recency Window

Unlike claude-mem's 90-day filter:

```typescript
// claude-mem: filters to 90 days
const RECENCY_WINDOW_MS = 90 * 24 * 60 * 60 * 1000;

// Oracle: all patterns remain relevant (timeless)
// No recency filter applied
```

Oracle principles are **timeless**. Age doesn't diminish value.

### 4.5 Hybrid Search Implementation

```typescript
// Search both indexes:
const vectorResults = await chromaQuery(query);
const keywordResults = await sqlite.search(query);

// Merge + deduplicate + hydrate from source
const merged = deduplicateByID([...vectorResults, ...keywordResults]);

// Sort by relevance (vector score + keyword match count)
return merged.sort((a, b) => {
  const aScore = (a.vectorScore || 0) + (a.keywordMatches || 0);
  const bScore = (b.vectorScore || 0) + (b.keywordMatches || 0);
  return bScore - aScore;
});
```

---

## 5. Key Learnings & Anti-Patterns

### 5.1 What claude-mem Got Right

| Pattern | Value | Apply to Oracle |
|---------|-------|-----------------|
| Local embeddings | Zero API cost, offline | Yes, keep |
| Granular vectors | Better precision | Yes, required |
| Hybrid search | Recall + precision | Yes, essential |
| MCP via stdio | Simple deployment | Yes, baseline |

### 5.2 What to Adapt for Oracle

| claude-mem | Oracle v2 |
|-----------|-----------|
| 90-day recency | No recency (timeless) |
| User observations | Philosophy principles |
| Notes from chats | Learnings + retrospectives |
| Personal memory | Personal + agent memory |

### 5.3 Anti-Patterns to Avoid

1. **One vector per file** → Granular vectors (principle-level)
2. **Vector-only search** → Hybrid (vector + keyword)
3. **Recency-forced** → No filter (principles are timeless)
4. **MCP tools upfront** → Skill + lazy load (token efficiency)

---

## 6. Implementation Roadmap

### Phase 1: Read-Only Oracle (MVP)
- [ ] Index `ψ/memory/resonance/` (principles)
- [ ] Index `ψ/memory/learnings/` (patterns)
- [ ] Create SQLite FTS5 index
- [ ] Generate Chroma vectors
- [ ] Test oracle_search tool
- [ ] Test oracle_reflect tool

### Phase 2: Decision Support
- [ ] Implement oracle_consult tool
- [ ] Context injection based on query
- [ ] Track decision outcomes
- [ ] Measure pattern application

### Phase 3: Bidirectional Oracle
- [ ] Add oracle_learn tool
- [ ] Auto-commit new patterns
- [ ] Hook on retrospective creation
- [ ] Extract patterns from learnings

### Phase 4: Integration & Context
- [ ] SessionStart hook: inject relevant principles
- [ ] Progressive disclosure pattern
- [ ] Search result ranking optimization

---

## 7. Success Metrics

| Metric | How to Measure |
|--------|----------------|
| Functionality | oracle_search returns relevant results |
| Semantics | "patterns about trust" matches trust principles |
| Philosophy | Results align with "Nothing is Deleted" principle |
| Accessibility | Seamless integration into Claude Code workflow |
| Growth | New learnings added organically |

---

## 8. Files & Resources

### Core Resources

| File | Purpose |
|------|---------|
| `ψ/memory/learnings/2025-12-29_claude-mem-oracle-patterns.md` | Deep dive into claude-mem architecture |
| `ψ/memory/resonance/oracle.md` | Oracle philosophy (source of truth) |
| `ψ/lab/oracle-v2/SPEC.md` | Prototype specification |
| `.specify/specs/045-oracle-v2-efficiency/` | Original speckit planning (performance focus) |

### Learning Resources

| File | Topic |
|------|-------|
| `ψ/learn/chroma/2025-12-17_QUICK-REFERENCE.md` | ChromaDB patterns |
| `ψ/learn/chroma/CHROMA.md` | ChromaDB overview |
| `ψ/active/tong-training/2025-12-22_session-overview.md` | Memory system design context |

### Related Learning

| File | Connection |
|------|-----------|
| `ψ/memory/learnings/2025-12-17_conversation-over-extraction.md` | SQLite + vector patterns |
| `ψ/writing/drafts/12-feeding-philosophy-to-memory.md` | Philosophy → memory system |

---

## 9. Decision Points (Unresolved)

### Question 1: Path Consolidation
**Decision**: Merge speckit #45 (performance) with lab prototype (vector search)?
- **Option A**: Keep separate (different focuses)
- **Option B**: Add vector search as Phase 5 of speckit
- **Option C**: Use lab prototype as starting point, apply speckit framework

### Question 2: Skill or MCP?
**Decision**: Deploy as skill or MCP tools?
- **Option A**: Skill (token efficient, progressive disclosure)
- **Option B**: MCP tools (more flexible)
- **Option C**: Both (skill → MCP delegation)

### Question 3: Auto-Update Vectors
**Decision**: When to regenerate Chroma indexes?
- **Option A**: On session start (guaranteed fresh)
- **Option B**: On file change (fswatch daemon)
- **Option C**: Manual (regenerate-oracle command)
- **Option D**: Hybrid (check mtime, auto-update if stale)

### Question 4: Conflict Resolution
**Decision**: When human edits oracle.md and AI suggests pattern change:
- **Option A**: User always wins (oracle.md as source of truth)
- **Option B**: AI patches go to learnings/ (separate namespace)
- **Option C**: Merge with review gate

---

## 10. Summary Table

| Aspect | claude-mem | Oracle v2 |
|--------|-----------|----------|
| **Transport** | Stdio (chroma-mcp) | Stdio (oracle-mcp) |
| **Embeddings** | sentence-transformers (384 dims) | Same |
| **Search** | Vector + SQLite FTS5 | Vector + SQLite FTS5 |
| **Document Granularity** | Split by semantics | Principle-level + sub-principle |
| **Recency** | 90-day window | No window (timeless) |
| **Index Size** | ~1K observations | ~100 principles |
| **Source of Truth** | Markdown notes | Markdown philosophy |
| **API Cost** | Zero (local embeddings) | Zero |
| **Deployment** | Subprocess | Subprocess or skill |

---

## Next Steps for Implementation

1. **Verify prototype works**: Run ψ/lab/oracle-v2/src/indexer.ts
2. **Test search quality**: Query for trust/patterns/decisions
3. **Decide path**: Consolidate with speckit or standalone?
4. **Create skill wrapper**: Build ψ/skills/oracle/
5. **Integration test**: Add to Claude Code, test in session

---

*Research conducted: 2025-12-29 11:18*
*Based on: claude-mem deep dive + existing lab prototype + Oracle philosophy*
*Status: Ready for implementation decision*
