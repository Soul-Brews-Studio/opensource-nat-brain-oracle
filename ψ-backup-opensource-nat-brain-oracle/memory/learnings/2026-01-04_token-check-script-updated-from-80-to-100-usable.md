---
title: Token check script updated from 80% to 100% usable context
tags: [hooks, token-check, context-window, configuration]
created: 2026-01-04
source: Oracle Learn
---

# Token check script updated from 80% to 100% usable context

Token check script updated from 80% to 100% usable context

Changed `.claude/scripts/token-check.sh` line 18:
- Before: `usable=$((total * 80 / 100))` (160k usable of 200k)
- After: `usable=$((total * 100 / 100))` (200k usable of 200k)

Reason: User prefers to use full context window, accepts auto-compact risk.

Date: 2026-01-04

---
*Added via Oracle Learn*
