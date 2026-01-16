# MAW Branching: Simple Beats Complex

**Date**: 2025-12-17

## What We Learned

When designing multi-agent branching strategy, we went through several iterations:

1. **wip/* branches** — Push to different remote name for staging → Too complex
2. **reset --hard after merge** — Scary, loses work → Unnecessary
3. **Simple: PR is optional** — User decides, AI asks → Best

**Key insight**: Don't over-engineer. The simplest pattern that works:

```
Default:  agents/N → main rebase → push (fast)
Optional: agents/N → push → PR → merge (when user wants review)
```

## How Things Connect

```
Problem: How to review agent work before main?
    ↓
Attempt 1: wip/* staging branches
    ↓
Concern: Sync issues after PR merge?
    ↓
Attempt 2: reset --hard the source agent
    ↓
Realization: Git rebase auto-skips duplicates!
    ↓
Simplification: Just rebase, no reset needed
    ↓
Final: PR is optional, user decides
```

## The Decision Framework

| Question | Answer |
|----------|--------|
| Need review? | User decides |
| Default flow? | Direct sync (no PR) |
| How to ask? | AI presents options |
| Force reset? | No, rebase handles it |

## Tags

`maw` `branching` `simplicity` `decision-making`
