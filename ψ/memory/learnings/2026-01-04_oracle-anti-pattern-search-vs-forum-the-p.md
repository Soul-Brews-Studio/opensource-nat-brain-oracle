---
title: ## Oracle Anti-Pattern: Search vs Forum
tags: [oracle, anti-pattern, search, forum, threads, multi-agent, coordination]
created: 2026-01-04
source: 2026-01-04 dustboy duplicate work discovery
---

# ## Oracle Anti-Pattern: Search vs Forum

## Oracle Anti-Pattern: Search vs Forum

### The Problem
Agent searched Oracle for "spinoff project migration repo" and found the HOW (pattern) but missed the DONE (completion record for dustboy).

### Why It Happened
- Search depends on exact keywords
- Generic terms find generic patterns
- Specific completions need specific queries

### The Fix
Before starting any task:
1. `oracle_threads(status="all")` - see if someone already working on it
2. `oracle_search("[project-name] [action]")` - search with specifics
3. Check recent: `oracle_list(type="learning", limit=10)`

### Forum > Search for Task Status
| Search | Forum |
|--------|-------|
| Depends on keywords | Shows all threads |
| Easy to miss | Status visible |
| No conversation | Full context |

### Example
Bad: `oracle_search("spinoff project migration")`
Good: `oracle_search("dustboy spinoff")` or check threads first

---
*Added via Oracle Learn*
