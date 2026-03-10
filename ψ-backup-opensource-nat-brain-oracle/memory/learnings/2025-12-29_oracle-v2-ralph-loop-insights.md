---
title: Oracle v2 Ralph Loop Implementation Insights
tags: [oracle, mcp, ralph-loop, speckit, vector-db, claude-mem]
created: 2025-12-29
session: ralph-loop-oracle-v2
---

# Oracle v2 Ralph Loop Implementation Insights

> Deep learnings from building Oracle v2 MCP in a Ralph loop session

## 1. Claude-mem Architecture Patterns

### What Works

| Pattern | Implementation | Benefit |
|---------|----------------|---------|
| **Hybrid Search** | SQLite FTS5 + ChromaDB | Best of keyword + semantic |
| **Granular Vectors** | Principle-level, not file-level | Better search precision |
| **Local Embeddings** | sentence-transformers via Chroma | Zero API cost |
| **Source of Truth** | Markdown files in git | Human-editable, auditable |

### Key Insight

**ChromaDB is CACHE, not source** - This respects "Nothing is Deleted" principle. The markdown files are authoritative; vector indexes are derived and rebuildable.

---

## 2. Speckit Workflow Effectiveness

### The Flow That Worked

```
/speckit.specify → spec.md
        ↓
/speckit.plan → plan.md + research.md + data-model.md
        ↓
/debate → FTS5 vs ChromaDB decision
        ↓
Build MVP (not via speckit.implement)
        ↓
/speckit.tasks → tasks.md (retrospective)
```

### Key Insight

**Debate before implement** - The /debate command saved hours by establishing that FTS5-only MVP was sufficient. ChromaDB can be added later.

**Tasks.md as retrospective** - Running /speckit.tasks AFTER implementation captures what was done, not just what was planned.

---

## 3. Ralph Loop Productivity Pattern

### What Happened

| Iteration | Output |
|-----------|--------|
| 1 | speckit.specify + speckit.plan |
| 2 | Debate → FTS5-only decision |
| 3 | Build MVP, fix indexer issues |
| 4 | HTTP server + curl testing |
| 5 | Web UI + search results |
| 6 | Knowledge graph visualization |
| 7 | speckit.tasks documentation |

### Key Insight

**Ralph loop enables incremental delivery** - Each iteration produced shippable output. The stop hook fed back the original prompt, but the work accumulated in git.

**Delegate to subagents for heavy lifting** - Coder subagent (Sonnet) created the graph feature while main agent (Opus) reviewed.

---

## 4. Technical Gotchas

### Python Version Compatibility

```bash
# ChromaDB needs Python 3.13, not 3.14+
uvx --python 3.13 --from chromadb chroma run
```

**Why**: onnxruntime doesn't support Python 3.14 yet.

### tsx Import Check

```typescript
// WRONG - fails in tsx
if (import.meta.url === `file://${process.argv[1]}`) {

// RIGHT - works in tsx
const isMain = import.meta.url.endsWith('indexer.ts');
if (isMain) {
```

### ChromaDB OOM with Large Batches

4466 documents at once → OOM. Need batching for production.

---

## 5. Constitution Compliance

### How Oracle v2 Respects Constitution

| Principle | How Respected |
|-----------|---------------|
| Nothing is Deleted | Markdown is source; indexes are cache |
| Patterns Over Intentions | Learns from actual retrospectives |
| External Brain, Not Command | Oracle suggests, human decides |
| Git-First Architecture | All state in git; ChromaDB rebuilds |

### Key Insight

**Constitution check in plan.md** - The speckit.plan command includes a Constitution Check section. This caught the "ChromaDB as source" anti-pattern early.

---

## 6. MVP vs Full Implementation

### What We Shipped

| Feature | MVP Status | Full Status |
|---------|------------|-------------|
| Search (FTS5) | ✅ Working | ⏳ Add ChromaDB |
| Consult | ✅ Working | ✅ Done |
| Reflect | ✅ Working | ✅ Done |
| Learn | ❌ Skipped | ⏳ Phase 6 |
| Graph | ✅ Working | ⏳ Optimize |

### Key Insight

**Ship FTS5, iterate to ChromaDB** - The debate concluded: validate need before adding complexity. FTS5 handles 80% of use cases.

---

## 7. Dev-Browser for Visual Testing

### Pattern

```bash
# Start browser server
./skills/dev-browser/server.sh &

# Navigate and screenshot
cd skills/dev-browser && npx tsx <<'EOF'
const page = await client.page("oracle-v2");
await page.goto("http://localhost:37778");
await page.screenshot({ path: "tmp/oracle-ui.png" });
EOF
```

### Key Insight

**Visual validation in Ralph loop** - Screenshots prove UI works without human checking. Subagents can describe images.

---

## Summary Table

| Pattern | What | When |
|---------|------|------|
| Speckit workflow | 6-step spec → plan → tasks | New features |
| Debate before build | FTS5 vs ChromaDB decision | Architecture choices |
| Ralph loop | Incremental delivery | Long tasks |
| Constitution check | In plan.md | Every feature |
| FTS5 first | MVP, add vectors later | Search features |
| Dev-browser | Visual validation | UI features |
| Subagent delegation | Heavy lifting to Haiku/Sonnet | Code generation |

---

## See Also

- [[specs/001-oracle-mcp/spec.md|Oracle v2 Specification]]
- [[specs/001-oracle-mcp/plan.md|Oracle v2 Implementation Plan]]
- [[specs/001-oracle-mcp/tasks.md|Oracle v2 Task List]]
- [[ψ/lab/oracle-v2/|Oracle v2 Lab Prototype]]

---

*Learned from: Ralph loop session building Oracle v2 MCP*
*Created: 2025-12-29 12:15*
