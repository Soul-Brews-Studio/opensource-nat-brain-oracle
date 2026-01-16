# Day 3: Intelligence

> "From memory to wisdom"

## What You'll Build

```bash
python oracle_smart.py consult "should I force push?"
python oracle_smart.py reflect
python oracle_smart.py learn "new pattern"
python oracle_smart.py supersede old_id new_id
```

## Vector Search (ChromaDB)

```python
import chromadb

client = chromadb.Client()
collection = client.create_collection("oracle")

# Semantic search
results = collection.query(
    query_texts=["git safety"],  # Finds "force push danger"
    n_results=5
)
```

## The Four Commands

### 1. `oracle consult`

Get advice from your past self:

```bash
oracle_smart.py consult "should I merge without review?"
→ Based on your learnings about code review...
→ No. You learned on 2025-12-15 that reviews catch 80% of bugs.
```

### 2. `oracle reflect`

Daily wisdom surfacing:

```bash
oracle_smart.py reflect
→ "Context-finder isn't optional at scale"
→ — from 2026-01-05 session
```

### 3. `oracle learn`

Add new knowledge:

```bash
oracle_smart.py learn "Always use context-finder for bulk operations"
→ Learned + indexed in vectors
```

### 4. `oracle supersede`

Mark old knowledge as evolved:

```bash
oracle_smart.py supersede learning_123 learning_456 "better approach"
→ Old stays searchable, marked as superseded
```

## Philosophy: Nothing is Deleted

`supersede` doesn't delete — it evolves:
- Old knowledge preserved
- Linked to newer version
- History shows evolution
- Mistakes become lessons

## Exercises

1. [ ] Install: `pip install chromadb anthropic`
2. [ ] Run: `python oracle_smart.py learn "test pattern"`
3. [ ] Run: `python oracle_smart.py reflect`
4. [ ] Run: `python oracle_smart.py consult "test question"`
5. [ ] Try: `python oracle_smart.py supersede 1 2`

## Success Criteria

Your Oracle now:
- Searches semantically (vectors)
- Advises from knowledge (consult)
- Surfaces wisdom (reflect)
- Grows continuously (learn)
- Evolves gracefully (supersede)

---

## The Complete Journey

| Day | Built | Learned |
|-----|-------|---------|
| 1 | Memory | Nothing is Deleted |
| 2 | Scale | Patterns Over Intentions |
| 3 | Intelligence | External Brain, Not Command |

**You have a personal AI knowledge system that survives its own success.**

---

*Day 3 Complete | Your Oracle is ready to grow*
