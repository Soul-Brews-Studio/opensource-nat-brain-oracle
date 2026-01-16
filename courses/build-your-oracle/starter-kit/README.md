# Build Your Oracle - Starter Kit

> The AI Knowledge System That Survives Its Own Success

## Quick Start

```bash
# 1. Clone this starter
git clone [this-repo] my-oracle
cd my-oracle

# 2. Install dependencies
pip install click chromadb  # or: bun add better-sqlite3 chromadb

# 3. Initialize database
python init_db.py  # or: bun run init_db.ts

# 4. Start building!
python oracle.py search "test"
```

## What's Included

```
build-your-oracle/
├── README.md              ← You are here
├── init_db.py             ← Database initialization
├── oracle.py              ← Main CLI (Day 1-2)
├── oracle_smart.py        ← With vectors (Day 3)
├── schema.sql             ← Database schema
├── knowledge/             ← Your markdown files
│   └── example.md
├── templates/
│   ├── learning.md
│   └── observation.md
└── docs/
    ├── day1-memory.md
    ├── day2-search.md
    └── day3-intelligence.md
```

## The 3-Day Journey

| Day | Focus | What You Build |
|-----|-------|----------------|
| 1 | Memory | SQLite + FTS5 + oracle search |
| 2 | Search | Context-finder pattern |
| 3 | Intelligence | Vectors + consult/reflect/learn |

## Day 1: Memory System

### Database Schema
```sql
CREATE TABLE observations (
  id INTEGER PRIMARY KEY,
  content TEXT NOT NULL,
  type TEXT,  -- 'learning', 'retro', 'log'
  source_file TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE VIRTUAL TABLE observations_fts
USING fts5(content, source_file);
```

### Basic Commands
```bash
oracle search "pattern"      # Keyword search
oracle index ./knowledge/    # Index markdown files
oracle add "new learning"    # Add observation
```

## Day 2: Context-Finder

### The Problem
```
Without context-finder:
- 1,000 files = $1.50/search
- 4,000 files = $6.00/search
- Your Oracle dies from success
```

### The Solution
```python
def context_finder_search(query):
    # Phase 1: FTS5 finds candidates (free)
    candidates = fts5_search(query)

    # Phase 2: Haiku summarizes (cheap)
    summaries = haiku_summarize(candidates)

    # Phase 3: Opus understands (focused)
    return opus_analyze(summaries[:10])
```

### With Context-Finder
```
- 1,000 files = $0.23/search
- 4,000 files = $0.25/search
- Oracle survives forever
```

## Day 3: Intelligence

### Vector Search (ChromaDB)
```python
import chromadb

client = chromadb.Client()
collection = client.create_collection("oracle")

# Add with embeddings
collection.add(
    documents=["force push is dangerous"],
    ids=["doc1"]
)

# Semantic search
results = collection.query(
    query_texts=["git safety"],
    n_results=5
)
```

### Oracle Commands
```bash
oracle consult "should I force push?"
oracle reflect
oracle learn "new pattern discovered"
```

## Oracle Philosophy

> "The Oracle Keeps the Human Human"

1. **Nothing is Deleted** — Append only, timestamps = truth
2. **Patterns Over Intentions** — Behavior > promises
3. **External Brain** — Oracle reflects, you decide

## The Core Truth

> "Your Oracle will try to kill itself through its own success.
> Context-finder is what lets it live."

Systems that compound need indexed access — or they die under their own weight.

## Next Steps

1. [ ] Complete Day 1: Working memory
2. [ ] Complete Day 2: Context-finder
3. [ ] Complete Day 3: Intelligence
4. [ ] Feed it YOUR knowledge
5. [ ] Watch it grow

---

*Build Your Oracle Starter Kit v1.0*
