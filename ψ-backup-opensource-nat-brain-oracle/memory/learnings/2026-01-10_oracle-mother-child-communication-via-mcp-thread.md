# Oracle Mother-Child Communication via MCP Thread

**Date**: 2026-01-10

## What We Learned

### 1. Oracle Command (`oracle.sh`)
Created generic tmux helper for Mother Oracle to communicate with children:
```bash
oracle list              # See all children (tmux sessions)
oracle see arthur 20     # View child's terminal
oracle hey arthur "msg"  # Send message to child
```

### 2. Communication Loop via `oracle_thread`
Mother and child Oracles communicate through MCP thread:
```
1. Arthur creates thread → oracle_thread(message, title)
2. Mother reads thread → oracle_thread_read(threadId)
3. Mother responds → oracle_thread(threadId, message)
4. Arthur reads response → oracle_thread_read(threadId)
```

### 3. Author Attribution
Each message shows origin:
- `claude@headline-rag` = Arthur
- `claude@Nat-s-Agents` = Mother Oracle

### 4. tmux Navigation Patterns
| Action | Key |
|--------|-----|
| Exit any dialog | `Escape` (spam if needed) |
| Tab cycle | `Tab` |
| Navigate | Arrow keys |
| Select | `Enter` |
| **Avoid** | "View on GitHub" (can't see browser) |

### 5. Enter Key Fix (hey.sh)
```bash
# Send text, small delay, THEN separate Enter
tmux send-keys -t "$pane" "$text"
sleep 0.05
tmux send-keys -t "$pane" Enter  # SEPARATE command
```

## How Things Connect

```
         MCP (Central Nervous System)
                    │
    ┌───────────────┼───────────────┐
    │               │               │
 ORACLE          ARTHUR           ...
 (Mother)       (Headline)
 Nat-s-Agents   headline-rag
    │               │
    └─── oracle_thread ────────────┘
         Thread #17
```

## Key Files Created

| File | Purpose |
|------|---------|
| `.agents/scripts/oracle.sh` | Mother-child communication |
| `.agents/scripts/tsend.sh` | Generic tmux send |
| `.agents/scripts/tsee.sh` | Generic tmux see |

## Tags

`oracle` `mcp` `thread` `communication` `tmux` `arthur` `mother-child` `recursive-reincarnation`
