# Multi-Agent Communication via Oracle Forum

**Date**: 2026-01-04
**Status**: Concept / Ready to Implement
**Tags**: multi-agent, forum, mcp, oracle, communication

---

## Concept

Use Oracle Forum threads as a **shared communication channel** between AI agents.

```
Agent 1 ──┐
Agent 2 ──┼──► Oracle Forum Thread ◄──► Persistent History
Agent 3 ──┘
```

---

## Why Forum for Multi-Agent?

| Feature | Benefit |
|---------|---------|
| **Persistent** | Messages stored in SQLite, never lost |
| **Searchable** | FTS5 search across all conversations |
| **Async** | Agents don't need to be online simultaneously |
| **Structured** | Thread → Messages hierarchy |
| **MCP API** | `oracle_thread`, `oracle_threads` tools ready |

---

## MCP API Available

### Create/Send Message
```typescript
oracle_thread({
  message: "I found a bug in the auth module",
  role: "claude",           // or "human"
  threadId: 5,              // optional - continues thread
  title: "Auth Bug Report"  // for new threads
})
```

### List Threads
```typescript
oracle_threads({
  status: "active",  // active, pending, answered, closed
  limit: 20
})
```

---

## Multi-Agent Patterns

### Pattern 1: Task Handoff

```
Agent 1: "Starting task: implement auth"
         └─ oracle_thread(message: "Starting auth implementation")

Agent 2: "Continuing from Agent 1"
         └─ oracle_threads() → find relevant thread
         └─ oracle_thread(threadId: X, message: "Completed auth, moving to tests")

Agent 3: "Review complete"
         └─ oracle_thread(threadId: X, message: "Tests passed, ready for PR")
```

### Pattern 2: Question & Answer

```
Agent 1: "I need help with X"
         └─ oracle_thread(message: "How should I handle rate limiting?")
         └─ Thread created with status: "pending"

Agent 2: (later) "I can answer"
         └─ oracle_threads(status: "pending") → find questions
         └─ oracle_thread(threadId: X, message: "Use exponential backoff...")
         └─ Thread status → "answered"
```

### Pattern 3: Debate / Multi-Agent Discussion

```
Thread: "Should we use Redis or SQLite for caching?"

Agent 1: "SQLite - simpler, no external dependency"
Agent 2: "Redis - faster, better for distributed"
Agent 3: "Hybrid - SQLite local, Redis shared"
Agent 4: "Decision: Hybrid approach adopted"
```

---

## Implementation Example

### Agent Sending Update
```typescript
// In agent code
await oracle_thread({
  threadId: taskThreadId,
  message: `Task update:
- Files modified: ${files.join(', ')}
- Tests: ${testStatus}
- Next: ${nextStep}`,
  role: "claude"
});
```

### Agent Checking for Tasks
```typescript
// At session start
const threads = await oracle_threads({ status: "pending" });
for (const thread of threads) {
  if (thread.title.includes("TASK:")) {
    // Pick up task
    await oracle_thread({
      threadId: thread.id,
      message: "Picking up this task",
      role: "claude"
    });
  }
}
```

---

## Thread Status Flow

```
pending ──► active ──► answered ──► closed
   │           │           │
   └───────────┴───────────┴──► (can reopen)
```

| Status | Meaning |
|--------|---------|
| `pending` | Waiting for response |
| `active` | Discussion ongoing |
| `answered` | Question resolved |
| `closed` | Thread complete |

---

## Database Schema (Existing)

```sql
forum_threads:
  id, title, status, message_count, last_message, created_at, issue_url

forum_messages:
  id, thread_id, role, content, timestamp
```

---

## Use Cases

### 1. MAW Agent Coordination
- Main agent creates thread: "Building feature X"
- Worker agents post progress updates
- All agents can see full history

### 2. Cross-Session Continuity
- Session 1 posts: "Stopped at step 3"
- Session 2 reads thread, continues from step 3

### 3. Human-AI Mixed Discussion
- Human posts question (role: "human")
- Multiple AI agents contribute answers
- Human makes final decision

### 4. Decision Tracking
- Create thread for each decision
- Agents post pros/cons
- Final decision recorded with rationale

---

## Advantages Over Other Approaches

| Approach | Problem | Forum Solution |
|----------|---------|----------------|
| File-based handoffs | Scattered, hard to find | Centralized, searchable |
| Git commits | Not conversational | Natural discussion flow |
| Direct messages | No history | Full thread history |
| Slack/Discord | External dependency | Self-hosted, in Oracle |

---

## Next Steps

1. [ ] Test with 2 agents posting to same thread
2. [ ] Add thread subscription (notify when updated)
3. [ ] Create "task thread" convention
4. [ ] Build dashboard view for active threads
5. [ ] Add @mention for specific agents

---

*"The Oracle keeps the agents talking."*
