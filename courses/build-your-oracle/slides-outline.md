# Build Your Oracle - Slide Outline

> 3 Days | Technical | Private Workshop for Developers
> **"Build an AI Knowledge System That Survives Its Own Success"**

---

## Workshop Overview

| Day | Focus | Core Moment |
|-----|-------|-------------|
| 1 | The Memory System | Working Oracle storage |
| 2 | The Search Problem | **Discover context-finder through pain** |
| 3 | Making Oracle Smart | Full Oracle with MCP |

**Total Slides**: ~90 slides (30 per day)
**Hands-on**: 50% of time

---

# DAY 1: THE MEMORY SYSTEM
## "Build the brain that never forgets"

---

## Morning Session (3h) — 15 slides

### Slide 1: Title
**Build Your Oracle**
The AI Knowledge System That Survives 10 Years

### Slide 2: The Problem
- AI forgets everything
- You solved this before (but forgot where)
- Knowledge scattered across sessions
- No compound learning

### Slide 3: What If...
> "What if your AI remembered every conversation, decision, and lesson learned?"

That's Oracle.

### Slide 4: What You'll Build (3 Days)
```
Day 1: Memory that persists
Day 2: Search that scales
Day 3: Intelligence that grows
```

### Slide 5: Oracle Philosophy
> "The Oracle Keeps the Human Human"

AI removes obstacles → freedom → connection → humanity

### Slide 6: Principle 1 — Nothing is Deleted
- Append only
- Timestamps = truth
- History preserved
- **Time machines need complete history**

### Slide 7: Principle 2 — Patterns Over Intentions
- Observe behavior, not promises
- Git commits reveal more than plans
- **What you DID > what you MEANT**

### Slide 8: Principle 3 — External Brain, Not Command
- Mirror, don't decide
- Support, don't replace
- **Best advice = your past self**

### Slide 9: The Storage Decision
| Option | Pros | Cons |
|--------|------|------|
| JSON files | Simple | No query |
| SQLite | Fast, queryable | Single file |
| Postgres | Scalable | Overkill |

**We'll use: SQLite + Markdown**

### Slide 10: Why SQLite + Markdown?
```
SQLite = Fast queries, indexes, FTS5
Markdown = Human readable, git-friendly
Together = Searchable + Readable
```

### Slide 11: Database Schema
```sql
CREATE TABLE observations (
  id INTEGER PRIMARY KEY,
  content TEXT NOT NULL,
  type TEXT,
  created_at TIMESTAMP DEFAULT NOW,
  source_file TEXT
);
```

### Slide 12: Markdown Structure
```
ψ/memory/
├── learnings/     → Patterns discovered
├── retrospectives/ → Sessions recorded
├── resonance/     → Core identity
└── logs/          → Moments captured
```

### Slide 13: The Dual System
```
Write → Markdown (human readable)
Index → SQLite (machine queryable)
Sync → Both always in sync
```

### Slide 14: Hands-on — Setup Database
**Your turn:**
```bash
sqlite3 oracle.db
CREATE TABLE observations (...);
```

### Slide 15: Demo — First Insert
[Live: Insert observation, query it back]

---

## Afternoon Session (3h) — 15 slides

### Slide 16: From Storage to Memory
Storage = where data lives
Memory = how you find it

**Now: Make it findable**

### Slide 17: Full-Text Search (FTS5)
```sql
CREATE VIRTUAL TABLE observations_fts
USING fts5(content, source_file);
```

**Why**: Instant keyword search across all knowledge

### Slide 18: FTS5 in Action
```sql
SELECT * FROM observations_fts
WHERE observations_fts MATCH 'context-finder';
```

→ Returns all observations mentioning context-finder

### Slide 19: Building the Index
```python
def index_markdown(file_path):
    content = read(file_path)
    db.execute("""
        INSERT INTO observations (content, source_file)
        VALUES (?, ?)
    """, [content, file_path])
```

### Slide 20: Hands-on — Index Your Files
**Your turn:**
Index 10 markdown files into SQLite

### Slide 21: Your First Oracle Query
```bash
oracle search "how did I solve X before?"
```

→ Returns: 3 past sessions where you solved X

### Slide 22: The CLI Interface
```python
@click.command()
@click.argument('query')
def search(query):
    results = db.execute("""
        SELECT * FROM observations_fts
        WHERE observations_fts MATCH ?
    """, [query])
    for r in results:
        print(r)
```

### Slide 23: Hands-on — Build oracle search
**Your turn:**
Create CLI that searches your knowledge

### Slide 24: Git as History
```bash
git log --all --oneline --grep="pattern"
```

Even deleted knowledge lives in git history

### Slide 25: Indexing Git History
```python
def index_git_history():
    commits = git.log('--all', '--oneline')
    for commit in commits:
        index_observation(commit.message, 'git')
```

### Slide 26: Demo — Search Across Time
[Live: Find something from 6 months ago]

### Slide 27: Day 1 Checkpoint
```
✅ SQLite database created
✅ FTS5 index working
✅ Markdown files indexed
✅ oracle search command
✅ Git history accessible
```

**You have a working memory system**

### Slide 28: The Hidden Problem
Your Oracle works great now.

With 100 files.

What happens at 1,000 files?

### Slide 29: Homework — Add More Data
**Tonight:**
- Index all your markdown files
- Index your git history
- Index your old notes
- **Make it big**

### Slide 30: Tomorrow's Challenge
> "Your Oracle will try to kill itself through its own success"

See you tomorrow.

---

# DAY 2: THE SEARCH PROBLEM
## "This is where context-finder becomes NECESSARY"

---

## Morning Session (3h) — 15 slides

### Slide 31: Day 2 Start
How was homework?
- How many files indexed?
- How does search feel?

### Slide 32: Let's Test At Scale
```python
# The naive approach (what we built yesterday)
def search(query):
    results = []
    for file in all_files:  # 1000+ files
        content = read(file)  # Expensive!
        if query in content:
            results.append(content)
    return results
```

### Slide 33: Demo — Run It
[Live: Search with 1000 files, measure time]

### Slide 34: The Numbers
```
Files: 1,000
Time: 45 seconds
Cost: $1.50 per search (Opus reads all files)
```

**Is this acceptable?**

### Slide 35: Project Forward
```
Month 1: 100 files → $0.15/search → $22/month
Month 6: 1,000 files → $1.50/search → $225/month
Year 2: 4,000 files → $6.00/search → $900/month
```

### Slide 36: The Death Spiral
```
More knowledge stored = Higher search cost
Higher cost = Use Oracle less
Use less = Stop using entirely
Stop using = Oracle is dead
```

**Your Oracle will kill itself through success**

### Slide 37: Feel The Pain
**Hands-on:**
Run 10 searches on your 1000+ file database
Calculate your daily cost if you search 20x/day

### Slide 38: Group Discussion
- What's your search costing?
- Would you pay this daily?
- What would you do?

### Slide 39: The Insight
We're using **expensive model** for **cheap work**

```
Opus = Brain surgeon
Finding files = Nurse work
```

**Wrong tool for the job**

### Slide 40: Two Phases of Search
| Phase | Goal | Needs |
|-------|------|-------|
| Finding | "Which files matter?" | Speed, low cost |
| Understanding | "What do they mean?" | Depth, precision |

### Slide 41: The Solution Emerges
```
Phase 1: Cheap model finds candidates
Phase 2: Expensive model understands them
```

**Use the right tool for each phase**

### Slide 42: Introducing Haiku
| Model | Cost | Speed | Best For |
|-------|------|-------|----------|
| Opus | $15/1M | Slow | Deep understanding |
| Sonnet | $3/1M | Medium | General work |
| Haiku | $0.25/1M | Fast | Finding, filtering |

**Haiku = 60x cheaper than Opus**

### Slide 43: The New Pattern
```python
def search(query):
    # Phase 1: Haiku finds candidates
    candidates = haiku_search(query)  # $0.08

    # Phase 2: Opus understands relevant ones
    results = opus_analyze(candidates[:10])  # $0.15

    return results

# Total: $0.23 instead of $1.50
```

### Slide 44: Hands-on — Implement Two-Phase
**Your turn:**
Modify your search to use Haiku first

### Slide 45: The Context-Finder Pattern
What you just built has a name:

**context-finder**

- Cheap model for "eyes and hands"
- Expensive model for "brain"
- Delegation = survival

---

## Afternoon Session (3h) — 15 slides

### Slide 46: Compare The Numbers
| Approach | 1,000 files | 4,000 files | 10,000 files |
|----------|-------------|-------------|--------------|
| Naive | $1.50 | $6.00 | $15.00 |
| Context-finder | $0.23 | $0.25 | $0.28 |

**85-98% cost reduction**

### Slide 47: Why It Scales
```
Naive: O(n) — cost grows with files
Context-finder: O(log n) — cost grows slowly

Like database indexes:
- Without index: scan all rows
- With index: jump to match
```

### Slide 48: The Real Insight
> context-finder isn't a cost optimization
> context-finder is what allows Oracle to SURVIVE

### Slide 49: Analogy — Database Indexing
You don't index a database to "be fancy"
You index because **queries die without it**

Context-finder = index for AI knowledge

### Slide 50: Advanced: FTS5 + Haiku
```python
def context_finder_search(query):
    # Step 1: FTS5 finds candidate files (free)
    files = fts5_search(query)

    # Step 2: Haiku summarizes each (cheap)
    summaries = haiku_summarize(files)

    # Step 3: Opus picks best matches (focused)
    results = opus_select(summaries)

    return results
```

### Slide 51: Three-Tier Search
| Tier | Tool | Cost | Purpose |
|------|------|------|---------|
| 1 | FTS5 | Free | Keyword match |
| 2 | Haiku | $0.08 | Summarize/filter |
| 3 | Opus | $0.15 | Deep understanding |

### Slide 52: Hands-on — Three-Tier Implementation
**Your turn:**
Add FTS5 as first tier to your search

### Slide 53: Demo — Full Context-Finder
[Live: Show search with all 3 tiers, measure cost]

### Slide 54: Your Oracle Now Scales
```
Year 2: 4,000 files
Search cost: $0.25
Monthly (20 searches/day): $150

vs Without context-finder: $3,600/month

You saved: $3,450/month
```

### Slide 55: The Compound Effect
With context-finder:
- Oracle can grow forever
- Cost stays manageable
- Knowledge compounds
- **System survives its success**

### Slide 56: Lesson Beyond Oracle
> "Systems that compound need indexed access or they die under their own weight"

This applies to:
- Databases → indexes
- File systems → directories
- Search engines → PageRank
- **Your Oracle → context-finder**

### Slide 57: Day 2 Checkpoint
```
✅ Felt the death spiral (pain)
✅ Understood two-phase search
✅ Implemented context-finder
✅ Measured cost reduction
✅ Oracle now scales
```

### Slide 58: The Emotional Journey
```
Day 1: "I built Oracle! It remembers!"
Day 2 AM: "Why is search so slow/expensive?"
Day 2 PM: "Oh... context-finder isn't optional"
```

**You discovered it. You understand it.**

### Slide 59: Homework — Stress Test
**Tonight:**
- Add even more files (5,000+)
- Run searches, measure costs
- Try different query types
- Break it if you can

### Slide 60: Tomorrow
Day 3: Making Oracle Smart
- Vector embeddings
- Semantic search
- Oracle consult, reflect, learn
- **Intelligence, not just memory**

---

# DAY 3: MAKING ORACLE SMART
## "From memory to intelligence"

---

## Morning Session (3h) — 15 slides

### Slide 61: Day 3 Start
Your Oracle:
- ✅ Stores everything
- ✅ Finds efficiently
- ❓ Understands semantically?

### Slide 62: Keyword vs Semantic
| Query | Keyword (FTS5) | Semantic (Vector) |
|-------|----------------|-------------------|
| "force push" | Finds "force push" | Finds "dangerous git operations" |
| "AI safety" | Finds "AI safety" | Finds "careful with automation" |

**Semantic = finds related concepts**

### Slide 63: Vector Embeddings Explained
```
Text → Numbers → Similarity

"force push" → [0.2, 0.8, 0.1, ...]
"dangerous git" → [0.3, 0.7, 0.2, ...]

Similar meaning = similar numbers
```

### Slide 64: ChromaDB Introduction
```python
import chromadb

client = chromadb.Client()
collection = client.create_collection("oracle")

collection.add(
    documents=["force push is dangerous"],
    ids=["doc1"]
)
```

### Slide 65: Hands-on — Setup ChromaDB
**Your turn:**
Install ChromaDB, create collection

### Slide 66: Indexing with Vectors
```python
def index_with_vectors(content, file_path):
    # SQLite for keywords
    db.insert(content, file_path)

    # ChromaDB for semantics
    collection.add(
        documents=[content],
        ids=[file_path]
    )
```

### Slide 67: Hybrid Search
```python
def hybrid_search(query):
    # Keyword matches (FTS5)
    keyword_results = fts5_search(query)

    # Semantic matches (ChromaDB)
    semantic_results = collection.query(query)

    # Merge and rank
    return merge(keyword_results, semantic_results)
```

### Slide 68: Demo — Semantic Discovery
[Live: Query "git safety" → finds "never force push" even without exact match]

### Slide 69: Hands-on — Hybrid Implementation
**Your turn:**
Add ChromaDB to your Oracle

### Slide 70: Concept Extraction
```python
def extract_concepts(content):
    prompt = """
    Extract 3-5 key concepts from this text.
    Return as JSON array.
    """
    concepts = haiku(prompt, content)
    return concepts
```

### Slide 71: Concept Tags
```sql
CREATE TABLE concepts (
    observation_id INTEGER,
    concept TEXT,
    FOREIGN KEY (observation_id) REFERENCES observations(id)
);
```

Now you can: "Show all observations about 'git safety'"

### Slide 72: Pattern Recognition
```python
def find_patterns():
    # Find frequently co-occurring concepts
    patterns = db.execute("""
        SELECT c1.concept, c2.concept, COUNT(*)
        FROM concepts c1
        JOIN concepts c2 ON c1.observation_id = c2.observation_id
        GROUP BY c1.concept, c2.concept
        HAVING COUNT(*) > 3
    """)
    return patterns
```

### Slide 73: Demo — Pattern Discovery
[Live: Show patterns Oracle discovered from your data]

### Slide 74: Hands-on — Extract Concepts
**Your turn:**
Run concept extraction on your observations

### Slide 75: Morning Checkpoint
```
✅ ChromaDB setup
✅ Vector indexing
✅ Hybrid search working
✅ Concepts extracted
✅ Patterns emerging
```

---

## Afternoon Session (3h) — 15 slides

### Slide 76: The Oracle Interface
Three commands that make Oracle intelligent:
- `oracle consult` — Get advice
- `oracle reflect` — Daily wisdom
- `oracle learn` — Add knowledge

### Slide 77: oracle consult
```bash
oracle consult "should I force push to main?"
```

→ Searches learnings about git safety
→ Synthesizes: "No. Here's why you learned this rule..."

### Slide 78: Building Consult
```python
@click.command()
@click.argument('question')
def consult(question):
    # Find relevant knowledge
    context = hybrid_search(question)

    # Synthesize with Opus
    answer = opus("""
        Based on this knowledge, advise on: {question}
        Knowledge: {context}
    """)

    print(answer)
```

### Slide 79: Hands-on — Build oracle consult
**Your turn:**
Create the consult command

### Slide 80: oracle reflect
```bash
oracle reflect
```

→ Returns random wisdom for daily reflection
→ Surfaces forgotten learnings

### Slide 81: Building Reflect
```python
@click.command()
def reflect():
    # Get random learning
    learning = db.execute("""
        SELECT * FROM observations
        WHERE type = 'learning'
        ORDER BY RANDOM() LIMIT 1
    """)

    print(f"Today's reflection:\n{learning}")
```

### Slide 82: Hands-on — Build oracle reflect
**Your turn:**
Create the reflect command

### Slide 83: oracle learn
```bash
oracle learn "Always use context-finder for bulk operations"
```

→ Stores as new pattern
→ Indexes in both systems
→ Extracts concepts

### Slide 84: Building Learn
```python
@click.command()
@click.argument('pattern')
def learn(pattern):
    # Store in database
    db.insert(pattern, type='learning')

    # Index in ChromaDB
    collection.add([pattern])

    # Extract concepts
    concepts = extract_concepts(pattern)
    store_concepts(concepts)

    print(f"Learned: {pattern}")
```

### Slide 85: Hands-on — Build oracle learn
**Your turn:**
Create the learn command

### Slide 86: Demo — Full Oracle Workflow
```bash
# Learn something
oracle learn "Never force push to main"

# Later, get advice
oracle consult "can I use --force?"
→ "No. You learned on 2026-01-08: Never force push..."

# Daily reflection
oracle reflect
→ "Today's wisdom: Context-finder isn't optional at scale"
```

### Slide 87: MCP Integration (Optional)
```typescript
// Model Context Protocol
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  if (request.params.name === 'oracle_search') {
    return hybrid_search(request.params.query);
  }
});
```

### Slide 88: What You Built
```
Your Oracle:
├── Memory (SQLite + Markdown)
├── Search (FTS5 + ChromaDB + Context-finder)
├── Intelligence (Concepts + Patterns)
└── Interface (consult + reflect + learn)
```

**A knowledge system that survives 10 years**

### Slide 89: The Journey
| Day | Started | Ended |
|-----|---------|-------|
| 1 | Nothing | Working memory |
| 2 | Naive search | Context-finder |
| 3 | Memory | Intelligence |

### Slide 90: What You Really Learned
| Level | Lesson |
|-------|--------|
| Surface | How to build Oracle |
| Middle | How to optimize AI costs |
| **Deep** | **How to build systems that survive success** |

---

## Closing — 5 slides

### Slide 91: Your Oracle Now
```
✅ Stores everything (nothing deleted)
✅ Finds efficiently (context-finder)
✅ Understands semantically (vectors)
✅ Advises wisely (consult)
✅ Surfaces wisdom (reflect)
✅ Grows continuously (learn)
```

### Slide 92: The Philosophy In Practice
| Principle | How You Built It |
|-----------|------------------|
| Nothing Deleted | Append-only database |
| Patterns Over Intentions | Concept extraction |
| External Brain | Oracle advises, you decide |

### Slide 93: What's Next
1. **Use it daily** — consistency compounds
2. **Feed it knowledge** — every session
3. **Trust the patterns** — Oracle sees what you miss
4. **Share what you build** — help others

### Slide 94: The Core Truth
> "Your Oracle will try to kill itself through success.
> Context-finder is what lets it live."

You didn't just learn a pattern.
You discovered why it's necessary.

### Slide 95: Thank You
**Build Your Oracle**
The AI Knowledge System That Survives Its Own Success

Questions? Let's discuss.

---

## Appendix: Slide Count Summary

| Section | Slides | Duration |
|---------|--------|----------|
| **Day 1 Morning** | 15 | 3h |
| **Day 1 Afternoon** | 15 | 3h |
| **Day 2 Morning** | 15 | 3h |
| **Day 2 Afternoon** | 15 | 3h |
| **Day 3 Morning** | 15 | 3h |
| **Day 3 Afternoon** | 15 | 3h |
| **Closing** | 5 | 30m |
| **Total** | **95 slides** | **~18.5h** |

---

## Hands-on Sessions (12 total)

| Day | Slide | Activity | Duration |
|-----|-------|----------|----------|
| 1 | 14 | Setup database | 15m |
| 1 | 20 | Index files | 20m |
| 1 | 23 | Build oracle search | 30m |
| 2 | 37 | Feel the pain | 15m |
| 2 | 44 | Two-phase search | 30m |
| 2 | 52 | Three-tier search | 30m |
| 3 | 65 | Setup ChromaDB | 15m |
| 3 | 69 | Hybrid search | 30m |
| 3 | 74 | Extract concepts | 20m |
| 3 | 79 | Build consult | 20m |
| 3 | 82 | Build reflect | 15m |
| 3 | 85 | Build learn | 20m |

---

## Design Notes

### Visual Style
- Technical but accessible
- Code blocks prominent
- Cost comparisons visual
- "Pain → Solution" narrative

### Key Diagrams Needed
1. Death spiral graph (costs over time)
2. Context-finder architecture
3. Three-tier search flow
4. Hybrid search merge
5. Full Oracle architecture

### The Emotional Arc
```
Day 1: Excitement ("I built it!")
Day 2 AM: Frustration ("Why so expensive?")
Day 2 PM: Relief ("Context-finder saves it!")
Day 3: Mastery ("It's intelligent now")
```

---

*Slide Outline v1.0 | Build Your Oracle Workshop*
*3 Days | Technical | ~95 slides*
*Ready for: Slide creation*
