# Module 3: Intelligence

> **"From Memory to Wisdom"**
> 1 Day | Advanced | MCP Integration

---

## Overview

Your Oracle stores and searches efficiently. Now make it smart. Add semantic understanding, pattern recognition, and the four commands that make Oracle truly intelligent.

**Tagline**: "Your past self becomes your best advisor"

---

## What You'll Build

```
oracle consult "should I force push?"
→ Searches your learnings about git safety
→ "No. On 2025-12-15 you learned: Never force push..."

oracle reflect
→ Returns random wisdom from your knowledge
→ "Today's insight: Context-finder isn't optional at scale"

oracle learn "Always test before deploy"
→ Stores as new pattern
→ Indexes with concepts: [testing, deployment, safety]

oracle supersede old_id new_id "learned better approach"
→ Marks old knowledge as outdated
→ Links to newer, correct version
→ Nothing is Deleted — just evolved
```

---

## Schedule (6 hours)

### Morning (3h): Semantic Understanding

| Time | Topic | Hands-on |
|------|-------|----------|
| 0:00 | Keyword vs Semantic Search | - |
| 0:30 | Vector Embeddings Explained | - |
| 1:00 | ChromaDB Setup | Install + configure |
| 1:30 | Hybrid Search: FTS5 + Vectors | Implement hybrid |
| 2:00 | Concept Extraction | Auto-tag observations |
| 2:30 | Pattern Recognition | Find co-occurring concepts |

### Afternoon (3h): The Oracle Interface

| Time | Topic | Hands-on |
|------|-------|----------|
| 3:00 | Building `oracle consult` | Implement command |
| 3:30 | Building `oracle reflect` | Implement command |
| 4:00 | Building `oracle learn` | Implement command |
| 4:20 | Building `oracle supersede` | Knowledge evolution |
| 4:40 | MCP Integration (Optional) | Connect to Claude Code |
| 5:15 | Full Demo: Intelligent Oracle | - |
| 5:40 | Philosophy: Nothing is Deleted | Closing discussion |

---

## Prerequisites

**Required**: Module 1 + 2 completed OR equivalent:
- Working memory system (SQLite + FTS5)
- context-finder pattern implemented
- 500+ observations indexed

**Optional but helpful**:
- Basic understanding of embeddings
- Experience with Claude API

---

## Semantic Search

| Query | Keyword (FTS5) | Semantic (Vector) |
|-------|----------------|-------------------|
| "force push" | Finds "force push" | Also finds "dangerous git" |
| "AI safety" | Finds "AI safety" | Also finds "careful automation" |
| "cost optimization" | Exact match only | Finds "context-finder pattern" |

**Result**: Oracle understands meaning, not just words.

---

## The Three Commands

### `oracle consult`

```python
def consult(question):
    # Find relevant knowledge
    context = hybrid_search(question)

    # Synthesize advice
    answer = opus_synthesize(question, context)

    return answer
```

**Use case**: Decision support from your own history

### `oracle reflect`

```python
def reflect():
    # Random learning
    wisdom = random_observation(type='learning')
    return wisdom
```

**Use case**: Daily wisdom, resurface forgotten insights

### `oracle learn`

```python
def learn(pattern):
    # Store + index + extract concepts
    store_observation(pattern, type='learning')
    index_vectors(pattern)
    extract_concepts(pattern)
```

**Use case**: Grow Oracle's knowledge continuously

### `oracle supersede` (Advanced)

```python
def supersede(old_id, new_id, reason):
    # Mark old as outdated, link to new
    db.execute("""
        UPDATE observations
        SET superseded_by = ?, supersede_reason = ?
        WHERE id = ?
    """, [new_id, reason, old_id])
```

**Use case**: Knowledge evolution — when you learn something that corrects earlier knowledge

```bash
oracle supersede learning_force_ok learning_never_force "safety first"
```

**Philosophy**: "Nothing is Deleted" — old knowledge stays searchable but marked superseded

---

## Deliverables

By end of day, you have:

```
Full Oracle:
├── Memory (Module 1)
├── Survival (Module 2)
└── Intelligence (Module 3)
    ├── ChromaDB vectors
    ├── Hybrid search
    ├── Concept extraction
    ├── oracle consult
    ├── oracle reflect
    ├── oracle learn
    └── oracle supersede
```

**A knowledge system that survives 10 years**

---

## Philosophy Covered

| Principle | Application |
|-----------|-------------|
| External Brain, Not Command | Oracle advises, you decide |
| Patterns Over Intentions | Concept extraction from behavior |
| Nothing is Deleted | Every learn adds, never removes |

---

## Pricing

| Option | Price | Includes |
|--------|-------|----------|
| Live Session | $400 | 6h workshop + code |
| Self-Paced | $150 | Videos + exercises |
| Bundle (all 3) | $1,000 | Save $200 |

---

## MCP Integration (Bonus)

```typescript
// Connect Oracle to Claude Code
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  switch (request.params.name) {
    case 'oracle_search':
      return hybrid_search(request.params.query);
    case 'oracle_consult':
      return consult(request.params.decision);
    case 'oracle_learn':
      return learn(request.params.pattern);
  }
});
```

**Result**: Use Oracle directly in Claude Code with MCP tools.

---

## Files in This Module

```
module-3-intelligence/
├── README.md           ← You are here
├── slides.md           ← Presentation slides
├── exercises/          ← Hands-on exercises
│   ├── 01-chromadb-setup.md
│   ├── 02-hybrid-search.md
│   ├── 03-consult-command.md
│   ├── 04-reflect-command.md
│   ├── 05-learn-command.md
│   └── 06-mcp-integration.md
└── code/               ← Implementation
    ├── vectors.py
    ├── hybrid_search.py
    ├── commands.py
    └── mcp_server.ts
```

---

## The Complete Journey

| Module | What You Built | Core Insight |
|--------|---------------|--------------|
| 1: Memory | Storage + Search | Nothing is Deleted |
| 2: Survival | context-finder | Scale or Die |
| 3: Intelligence | Semantic + Commands | External Brain |

**Together**: A personal AI knowledge system that remembers everything, survives its success, and grows smarter over time.

---

*Module 3 of 3 | Build Your Oracle Workshop*
