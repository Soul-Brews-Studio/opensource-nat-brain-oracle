# Auto Activity Logging Pattern

**Date**: 2025-12-13
**Context**: ต้องการให้ activity.log + WIP.md sync อัตโนมัติ

## Problem

- activity.log ไม่ update เมื่อทำงาน
- WIP.md stale เพราะต้อง manual update
- /active แสดงข้อมูลเก่า

## Solution: 3-Layer Auto-Logging

### Layer 1: Hook Auto-Log (Task tool)

```
PreToolUse (Task) → log "working | [description]"
PostToolUse (Task) → log "done | [description]"
```

**Key Discovery**: Hooks รับ JSON ผ่าน stdin ไม่ใช่ env var

```bash
# .claude/hooks/log-task-start.sh
input=$(cat)
description=$(echo "$input" | jq -r '.tool_input.description // "unknown"')
echo "$timestamp | working | $description" >> activity.log
```

### Layer 2: wip-keeper Subagent

Sync WIP.md กับ activity.log:
- Mark done: items ที่มีใน activity.log
- Keep pending: items ที่ยังไม่ได้ทำ
- Trigger: ก่อน rrr หรือจบ session

### Layer 3: /active Command

Display current state:
- Focus (from focus.md)
- Todo (from TodoWrite)
- Done (from activity.log)

## Key Learnings

### 1. Hook stdin JSON

```json
{
  "tool_input": {
    "description": "task description here"
  }
}
```

ใช้ `jq -r '.tool_input.description'` เพื่อ extract

### 2. Subagent = แยก Context

Main agent spawn subagent → subagent ทำงานแยก → return summary
ไม่กิน context ของ main agent

### 3. Parallel Subagents

แทนที่ 1 agent ทำ 10 iterations → spawn 10 agents พร้อมกัน
เร็วกว่า + ไม่มี context sharing อยู่แล้ว

## Pattern Summary

```
User action
    │
    ▼
Main agent spawns Task
    │
    ├─ PreToolUse hook → log start
    │
    ├─ Subagent runs (separate context)
    │
    └─ PostToolUse hook → log end

Before rrr:
    │
    ▼
wip-keeper syncs WIP.md ← activity.log
```

## Files Created

- `.claude/hooks/log-task-start.sh`
- `.claude/hooks/log-task-end.sh`
- `.claude/agents/wip-keeper.md`
- `.claude/commands/active.md` (updated)

## Tags

`hooks` `auto-logging` `subagents` `wip-keeper` `activity-log`
