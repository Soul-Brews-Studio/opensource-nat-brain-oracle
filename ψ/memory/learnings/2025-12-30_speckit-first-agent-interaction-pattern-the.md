---
title: # Speckit-First: Agent Interaction Pattern
tags: [speckit, workflow, acceptance-criteria, agent-pattern, tdd]
created: 2025-12-30
source: Session 2025-12-30 07:05 - User correction
---

# # Speckit-First: Agent Interaction Pattern

# Speckit-First: Agent Interaction Pattern

## The Rule

Before implementing ANY task from a speckit, the agent MUST:

1. **Read the speckit first** - Check tasks.md for current status
2. **Verify acceptance criteria exist** - If missing, ADD them before coding
3. **Update criteria if ambiguous** - Define what "done" means
4. **Implement AFTER criteria defined** - Never code without clear goals
5. **Mark complete with evidence** - Show how each criterion was met

## Why It Matters

Without clear criteria:
- Agent guesses what "pagination" means
- User expects different behavior
- Work gets redone
- Time wasted on wrong implementation

## Example (This Session)

```markdown
# BAD - Started implementing T034 without criteria
- [ ] T034 [P] Add pagination to search results

# GOOD - Added criteria first, then implemented
- [ ] T034 [P] Add pagination to search results
  - **Acceptance Criteria**:
    1. MCP tool oracle_search accepts `offset` parameter (default: 0)
    2. HTTP endpoint /search accepts `offset` query parameter
    3. Response includes `total` count
    4. Response includes `offset` and `limit` in metadata
    5. UI shows pagination controls when results > limit
  - **Files**: index.ts, server.ts, ui.html
```

## The Workflow

```
1. Read tasks.md
2. Find pending task
3. Check: Has acceptance criteria? 
   - No → Add criteria first
   - Yes → Proceed
4. Implement to meet each criterion
5. Test each criterion
6. Mark complete with ✅ on each criterion
7. Commit with task reference
```

## Prevention

User should say: "speckit first!" when agent jumps to implementation.
Agent should self-check: "Do I have clear acceptance criteria?"

---
*Added via Oracle Learn*
