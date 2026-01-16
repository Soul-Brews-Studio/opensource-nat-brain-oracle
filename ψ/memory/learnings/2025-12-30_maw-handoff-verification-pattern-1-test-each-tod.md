---
title: MAW Handoff Verification Pattern:
tags: [maw, handoff, verification, checkpoint]
created: 2025-12-30
source: Oracle Learn
---

# MAW Handoff Verification Pattern:

MAW Handoff Verification Pattern:
1. Test each TODO item individually
2. Document status in handoff file with timestamps
3. Collect artifacts (scripts, configs) to central location
4. Mark handoff as CLEARED when all verified

Key commands tested:
- `maw peek` - agent status overview
- `cp-done.sh clear/wait/status/N` - checkpoint file system
- Toolkit collection: find + cp to central dir

---
*Added via Oracle Learn*
