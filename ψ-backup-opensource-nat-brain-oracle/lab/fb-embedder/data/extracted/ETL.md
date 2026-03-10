# Facebook Data ETL Pipeline

**Source**: `~/Downloads/facebook_v2.duckdb`
**Date**: 2025-12-31
**Purpose**: Extract Facebook data for RAG embedding

## Pipeline Overview

```
DuckDB (47k+ records)
    ↓ Extract
CSV files (clean, filtered)
    ↓ Transform
Embeddings (vector DB)
    ↓ Load
RAG Demo (web UI)
```

## Extract Commands

### 1. Messages (10,000 samples)

```sql
COPY (
  SELECT content, timestamp, sender, conversation_name
  FROM messages
  WHERE content IS NOT NULL
    AND length(content) > 5
  LIMIT 10000
) TO 'messages.csv' WITH (HEADER, DELIMITER ',')
```

**Output**: `messages.csv`
- Fields: content, timestamp, sender, conversation_name
- Filter: Non-null, min 5 chars
- Limit: 10,000 records (sample for demo)

### 2. Posts (all)

```sql
COPY (
  SELECT content, timestamp, action_type
  FROM posts
  WHERE content IS NOT NULL
    AND length(content) > 10
) TO 'posts.csv' WITH (HEADER, DELIMITER ',')
```

**Output**: `posts.csv`
- Fields: content, timestamp, action_type
- Filter: Non-null, min 10 chars

### 3. Comments (all)

```sql
COPY (
  SELECT content, timestamp, target_person
  FROM comments
  WHERE content IS NOT NULL
    AND length(content) > 5
) TO 'comments.csv' WITH (HEADER, DELIMITER ',')
```

**Output**: `comments.csv`
- Fields: content, timestamp, target_person
- Filter: Non-null, min 5 chars

## Source Table Schemas

### messages
| Column | Type | Description |
|--------|------|-------------|
| content | VARCHAR | Message text |
| timestamp | VARCHAR | Date/time |
| sender | VARCHAR | Who sent it |
| conversation_name | VARCHAR | Chat/group name |

### posts
| Column | Type | Description |
|--------|------|-------------|
| content | VARCHAR | Post text |
| timestamp | VARCHAR | Date/time |
| action_type | VARCHAR | Post type |

### comments
| Column | Type | Description |
|--------|------|-------------|
| content | VARCHAR | Comment text |
| timestamp | VARCHAR | Date/time |
| target_person | VARCHAR | Who was commented on |

## Data Counts

Run to get counts:
```sql
SELECT 'messages' as type, COUNT(*) FROM messages WHERE content IS NOT NULL
UNION ALL
SELECT 'posts', COUNT(*) FROM posts WHERE content IS NOT NULL
UNION ALL
SELECT 'comments', COUNT(*) FROM comments WHERE content IS NOT NULL
```

## Next Steps

1. Generate embeddings: `bun run embed-csv.ts`
2. Create RAG web UI
3. Demo with dev-browser
