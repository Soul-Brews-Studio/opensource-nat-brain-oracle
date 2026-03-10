---
title: "Claude-Mem Tool Usage Guide"
tags: [mcp, claude-mem, guide, memory]
created: 2025-12-31
source: Ralph Loop Analysis (Iteration 1)
---

# Claude-Mem Tool Usage Guide

Practical examples and patterns for using claude-mem MCP tools effectively.

## Tool 1: search

**Purpose**: Find observations, sessions, or prompts

### Basic Search
```
search(query="authentication", limit=20, project="Nat-s-Agents")
```

### Filter by Type
```
# Only observations
search(type="observations", limit=10, project="Nat-s-Agents")

# Only sessions
search(type="sessions", limit=5, project="Nat-s-Agents")

# Only prompts
search(type="prompts", limit=5, project="Nat-s-Agents")
```

### Filter by Observation Type
```
# Find bugfixes
search(type="observations", obs_type="bugfix", limit=10, project="Nat-s-Agents")

# Available obs_types: bugfix, feature, decision, discovery, change
```

### Date Filtering
```
search(dateStart="2025-12-30", dateEnd="2025-12-31", limit=20, project="Nat-s-Agents")
```

---

## Tool 2: timeline

**Purpose**: Get chronological context around an event

### With Query (auto-finds anchor)
```
timeline(query="TypeScript", depth_before=3, depth_after=3, project="Nat-s-Agents")
```

### With Anchor ID
```
timeline(anchor=131, depth_before=5, depth_after=5, project="Nat-s-Agents")
```

**Returns**: Interleaved observations, sessions, and prompts in chronological order.

---

## Tool 3: get_recent_context

**Purpose**: Quick summary of recent sessions

```
get_recent_context(limit=5, project="Nat-s-Agents")
```

**Returns**: Session summaries with:
- Request (what user asked)
- Completed (what was done)
- Learned (key insights)
- Next Steps

---

## Tool 4: get_context_timeline

**Purpose**: Timeline around a specific observation ID

```
get_context_timeline(anchor=128, depth_before=2, depth_after=2, project="Nat-s-Agents")
```

**Difference from `timeline`**: Requires anchor ID, doesn't accept query.

---

## Tool 5: get_batch_observations

**Purpose**: Fetch full details for multiple observations efficiently

```
get_batch_observations(ids=[126, 127, 128], orderBy="date_desc")
```

**Returns rich data**:
- `title`: Short description
- `subtitle`: Context
- `facts`: Array of key points
- `narrative`: Detailed explanation
- `concepts`: Tags like "problem-solution", "gotcha"
- `files_modified`: What files were touched
- `discovery_tokens`: Work effort

---

## Tool 6: progressive_description

**Purpose**: On-demand documentation

```
progressive_description(topic="workflow")      # 4-step workflow
progressive_description(topic="search_params") # Parameter reference
progressive_description(topic="examples")      # Usage examples
progressive_description(topic="all")           # Complete guide
```

---

## Recommended Workflow

### 1. Start Broad
```
search(type="observations", limit=20, project="Nat-s-Agents")
```

### 2. Get Context
```
timeline(anchor=<interesting_id>, depth_before=3, depth_after=3)
```

### 3. Fetch Details (Batch)
```
get_batch_observations(ids=[id1, id2, id3])
```

### 4. Quick Session Recap
```
get_recent_context(limit=3, project="Nat-s-Agents")
```

---

## Data Model

### Observation Fields
| Field | Description |
|-------|-------------|
| id | Unique identifier |
| type | bugfix, feature, decision, discovery, change |
| title | Short description |
| subtitle | Additional context |
| facts | Array of key points |
| narrative | Detailed explanation |
| concepts | Tags (problem-solution, gotcha, etc.) |
| files_modified | Array of file paths |
| discovery_tokens | Work effort measurement |
| created_at | Timestamp |

### Session Fields
| Field | Description |
|-------|-------------|
| id | Session identifier (S123) |
| request | What user asked |
| completed | What was done |
| learned | Key insights |
| next_steps | Follow-up items |

---

*Generated via Ralph Loop, Iteration 1*
