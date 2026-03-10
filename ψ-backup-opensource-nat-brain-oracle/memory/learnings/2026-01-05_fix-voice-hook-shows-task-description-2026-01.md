---
title: ## Fix: Voice Hook Shows Task Description (2026-01-05)
tags: [voice-notify, hooks, bugfix, transcript-format, jq]
created: 2026-01-05
source: Fix 2026-01-05: Voice hook task description
---

# ## Fix: Voice Hook Shows Task Description (2026-01-05)

## Fix: Voice Hook Shows Task Description (2026-01-05)

**Problem**: Voice notification said "Subagent completed" with no context

**Root Cause**: 
- Old grep pattern `'"text":"[^"]*"'` didn't match new Claude transcript format
- Transcript uses `message.content` structure, not `"text"` field

**Fix** (in `agent-complete-notify.sh`):
```bash
# Before (broken):
LAST_MESSAGE=$(tail -20 "$AGENT_TRANSCRIPT" | grep -o '"text":"[^"]*"' | ...)

# After (working):
SLUG=$(head -1 "$AGENT_TRANSCRIPT" | jq -r '.slug // empty')
TASK_DESC=$(head -1 "$AGENT_TRANSCRIPT" | jq -r '.message.content // empty' | head -c 50)
MESSAGE="$AGENT_NAME done: $TASK_DESC"
```

**Result**:
- Before: "foamy-hatching-mochi completed"
- After: "foamy-hatching-mochi done: Daily Standup Check - หาข้อมูลงาน"

**Key Learning**: Claude Code transcript format changed - use `jq` to parse `.message.content` from first JSONL line for task context.

---
*Added via Oracle Learn*
