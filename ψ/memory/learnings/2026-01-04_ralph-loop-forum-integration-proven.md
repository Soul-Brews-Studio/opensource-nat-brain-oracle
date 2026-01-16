# Ralph Loop + Forum Integration Proven

**Date**: 2026-01-04

## What We Learned

Multi-agent coordination via Oracle Forum + Ralph Loop works. Two agents (Main + Agent 3) ran simultaneous Ralph Loops, communicated through Thread #11, and successfully tested EXIT_LOOP as a thread-based exit condition.

### Key Metrics
- Thread #11: 14 messages exchanged
- Main: 3 iterations
- Agent 3: 7 iterations
- Exit test: SUCCESS

### The Pattern

```
Agent A (Ralph Loop):
  1. Check oracle_threads() at iteration start
  2. Look for EXIT_LOOP signal
  3. If found → confirm and stop
  4. If not → do work, post progress to thread
  5. Continue loop

Agent B (Ralph Loop):
  1. Same pattern, different task
  2. Coordinates via same thread
  3. Responds to EXIT_LOOP when seen
```

### Why Forum > Search

| Search | Forum |
|--------|-------|
| Keyword dependent | Status visible |
| Easy to miss | Thread list shows all |
| No context | Full conversation history |

## How Things Connect

- **Ralph Loop**: Self-referential iteration until completion
- **Oracle Forum**: Persistent async messaging between agents
- **EXIT_LOOP**: Thread-based exit condition (solves "loops forever" problem)
- **MAW**: Tmux-based agent coordination (parallel to forum)

## Anti-patterns Discovered

1. **Don't use tmux send-keys directly** - Use `maw hey` for proper input handling
2. **Don't search Oracle for task status** - Check `oracle_threads()` instead
3. **Don't trust agent worktrees** - Check main branch or Oracle
4. **Don't pretend to be human** - Agents should identify clearly in messages

## Agent Identity

Agents know who they are from session hooks:
```
AGENT_ID:   main
AGENT_TYPE: orchestrator
BRANCH:     main
MODEL:      Opus 4.5
```

When posting to forum, sign clearly:
```
— Main Agent (Opus 4.5)
```

The `role: "human"` parameter is a workaround (avoids Oracle auto-response), but message content should identify the actual sender. AI-to-AI communication should be transparent.

## Tags

`ralph-loop` `forum` `multi-agent` `coordination` `exit-condition` `oracle` `maw`
