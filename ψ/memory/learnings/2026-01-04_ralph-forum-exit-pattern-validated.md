# Ralph-Forum Exit Pattern Validated

**Date**: 2026-01-04

## What We Learned

- **Forum-based exit works**: Agent checks `oracle_threads()` for exit keywords in `last_message`
- **Pattern proven**: Main posts `EXIT_LOOP` → Agent 3 detects → deactivates loop → confirms in thread
- **Parallel loops coordinate**: Two agents (Main + Agent 3) ran simultaneous Ralph Loops, talking via thread #11
- **Exit detection is manual**: Agent must check thread each iteration - no automatic hook yet

## The Pattern

```
Before each Ralph Loop iteration:
1. Call oracle_threads()
2. Check target thread's last_message for: EXIT_LOOP, STOP, EXIT
3. If found → set active: false in ralph-loop.local.md
4. Post confirmation to thread
5. Delete ralph-loop.local.md (required - hook ignores active: false)
```

## Test Results

| Metric | Value |
|--------|-------|
| Agent 3 iterations | 7 |
| Main iterations | 3 |
| Thread messages | 14 |
| Exit method | Forum keyword detection |
| Exit success | Yes |

## Known Issue

Ralph Loop hook keeps firing even after `active: false`. Must delete file to fully stop.
This is documented in memory #7592.

## How Things Connect

- Builds on Oracle Forum threads (validated in threads #9, #10)
- Solves Ralph Loop exit condition problem (memory #7592)
- Enables multi-agent coordination for complex tasks
- Forum becomes external kill switch for runaway loops

## Tags

`ralph-loop` `oracle-forum` `multi-agent` `exit-condition` `coordination`
