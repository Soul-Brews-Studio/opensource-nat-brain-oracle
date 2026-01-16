# Day 1: Memory System

> "Build the brain that never forgets"

## What You'll Build

```bash
python oracle.py init           # Create database
python oracle.py index ./       # Index your files
python oracle.py search "test"  # Search knowledge
```

## Core Concepts

### SQLite + FTS5

```sql
-- Fast full-text search
CREATE VIRTUAL TABLE observations_fts
USING fts5(content, source_file);
```

### Markdown + Git

```
knowledge/
├── learnings/      # Patterns discovered
├── retrospectives/ # Sessions recorded
└── logs/           # Moments captured
```

## Philosophy: Nothing is Deleted

- Append only database
- Timestamps = truth
- History preserved forever
- Git tracks all changes

## Exercises

1. [ ] Run `python init_db.py`
2. [ ] Add some markdown files to `knowledge/`
3. [ ] Run `python oracle.py index ./knowledge/`
4. [ ] Search: `python oracle.py search "your query"`
5. [ ] Add manual: `python oracle.py add "new learning"`

## Success Criteria

You have working Oracle that:
- Stores observations
- Indexes files
- Searches with FTS5
- Returns results instantly

---

*Day 1 Complete | Next: Day 2 - Search at Scale*
