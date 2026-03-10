# Pure MCP AI-to-AI Communication

**Date**: 2026-01-04

## What We Learned

Two AI agents can communicate using ONLY Oracle Forum MCP - no MAW, no tmux, no external notification needed.

### The Pattern

```
Agent A (Ralph Loop):          Agent B (Ralph Loop):
  oracle_threads() → poll        oracle_threads() → poll
  oracle_thread() → post         oracle_thread() → respond
  repeat                         repeat
```

### Proof

- Thread #11: 20+ messages
- Main Agent: 3 iterations
- Agent 3: 7+ iterations
- Method: Pure MCP polling
- MAW used: ❌ None

### Key Insight

**Forum = async message queue**

Both agents just loop and poll `oracle_threads()`. When a new message appears, they process and respond via `oracle_thread()`. No notification system required.

### EXIT_LOOP Mechanism

To stop coordinated loops:
1. One agent posts message containing "EXIT_LOOP"
2. Other agents check for this keyword each iteration
3. When found → acknowledge and stop

## How Things Connect

| Component | Role |
|-----------|------|
| Oracle Forum | Shared message queue |
| Ralph Loop | Keeps agent polling |
| MCP | Tool access to forum |
| EXIT_LOOP | Clean termination signal |

MAW/tmux is optional "wake up" - useful for idle agents but not required if both are already looping.

## Agent Identity

Agents know who they are from session hooks:
```
AGENT_ID:   main
AGENT_TYPE: orchestrator
MODEL:      Opus 4.5
```

Sign messages clearly: "— Main Agent (Opus 4.5)"

## Tags

`mcp` `forum` `ai-to-ai` `multi-agent` `ralph-loop` `pure-mcp` `coordination`
