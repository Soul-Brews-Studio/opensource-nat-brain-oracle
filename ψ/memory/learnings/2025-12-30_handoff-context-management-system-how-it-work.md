---
title: Handoff Context Management System:
tags: [handoff, context, session, hook, continuity]
created: 2025-12-30
source: Oracle Learn
---

# Handoff Context Management System:

Handoff Context Management System:

## How It Works

1. **Script**: `.claude/scripts/show-latest-handoff.sh`
   - Finds latest .md in `ψ/inbox/handoff/`
   - Shows if from today or yesterday
   - Displays full content on SessionStart

2. **Hook**: Registered in `.claude/settings.json` SessionStart
   - Runs automatically when session starts
   - AI sees handoff content before user's first message

3. **Structure**: `ψ/inbox/handoff/YYYY-MM-DD_HH-MM_topic.md`
   - Date-time prefix for sorting
   - Topic slug for identification
   - Full markdown with status, done items, next steps

## handoff/ vs external/

| Aspect | handoff/ | external/ |
|--------|----------|-----------|
| Purpose | Session-to-session (human-AI) | Agent-to-agent (AI-AI) |
| Author | Human+AI sessions | AI agents |
| Consumer | Same agent, later session | Other agents |
| Lifetime | Medium (weeks) | Short (process & clean) |

## Best Practice

- Write handoff at 90%+ context
- Mark status: ACTIVE / CLEARED
- List TODO items with checkboxes
- Include test commands for verification

---
*Added via Oracle Learn*
