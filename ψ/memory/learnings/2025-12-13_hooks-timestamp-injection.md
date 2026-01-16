# Learning: Hook Timestamp Injection

**Date**: 2025-12-13
**Context**: ทดลอง inject timestamp ผ่าน hooks แทนการบังคับ AI รัน date เอง

---

## How I Learned This

| Source | Method |
|--------|--------|
| **User question** | Nat ถามว่า "ถ้าเอาเวลาไปใส่ใน hook agent จะเห็นไหม" |
| **claude-code-guide agent** | ใช้ Task tool query official docs |
| **Official docs** | https://code.claude.com/docs/en/hooks.md |

### Learning Process

1. **User sparked question** — ไม่เคยคิดมาก่อนว่า hook stdout จะ visible หรือเปล่า
2. **Used subagent to research** — `claude-code-guide` agent ค้น official documentation
3. **Found clear answer** — Docs ระบุชัดว่า:
   > "Claude Code does not see stdout if exit code is 0, **except for** UserPromptSubmit hook where stdout is injected as context"
4. **Tested hypothesis** — เพิ่ม hook ใน `.claude/settings.json` เพื่อ verify

### Key Insight

**ไม่ใช่ทุก hook ที่ agent เห็น output** — ต้องเช็ค docs ก่อนใช้

---

## Key Discovery

**Hook stdout → Agent visibility ขึ้นกับ hook type!**

| Hook | stdout → Agent? |
|------|-----------------|
| `SessionStart` | ✅ เห็น |
| `UserPromptSubmit` | ✅ เห็น |
| `PreToolUse` | ❌ ไม่เห็น |
| `PostToolUse` | ❌ ไม่เห็น |

---

## Two Approaches to Timestamps

### 1. CLAUDE.md Rule (Current)
```markdown
**Every command and subagent output MUST start with:**
date "+🕐 %H:%M (%A %d %B %Y)"
```

| Pros | Cons |
|------|------|
| ยืดหยุ่น | ต้องสอน AI |
| Agent เลือกได้เมื่อไหร่ | อาจลืม/ไม่ทำ |
| ไม่ต้อง restart | ใช้ tokens |

### 2. Hook Injection (New)
```json
{
  "hooks": {
    "UserPromptSubmit": [{
      "hooks": [{
        "type": "command",
        "command": "date '+🕐 NOW: %H:%M (%A %d %B %Y)'"
      }]
    }]
  }
}
```

| Pros | Cons |
|------|------|
| อัตโนมัติ 100% | ต้อง restart |
| ไม่ต้องสอน AI | ทุก prompt (อาจ noisy) |
| Consistent | ไม่ยืดหยุ่น |

---

## Project vs User Hooks

| Location | Scope | Commit? |
|----------|-------|---------|
| `~/.claude/settings.json` | All projects | ไม่ |
| `.claude/settings.json` | This project | ✅ ใช่ |
| `.claude/settings.local.json` | This project, local | ไม่ (gitignored) |

**Merge behavior**: Project hooks รวมกับ user hooks (ไม่ override)

---

## Recommendation (Updated)

**Hybrid approach**:
1. **Main agent** — Hook `UserPromptSubmit` inject timestamp อัตโนมัติ
2. **Subagents** — ต้องรัน START + END timestamps เอง

### Subagent Pattern
```
🕐 START: 09:15 (Saturday 13 December 2025)
... ทำงาน ...
---
🕐 END: 09:16
**Claude Haiku** (agent-name)
```

### Benefits
- Main agent คำนวณ **duration** ได้
- ตรวจสอบว่า subagent ทำงาน **เมื่อไหร่**
- ไม่มี hook สำหรับ subagent → ต้อง enforce ผ่าน agent definition

---

## Test Plan

1. Add hook to `.claude/settings.json`
2. Restart Claude Code
3. Send any message
4. Check if `🕐 NOW: XX:XX` appears in context
5. Compare with manual `date` command

---

*จาก session ที่ถามว่า "ถ้าเอาเวลาไปใส่ใน hook agent จะเห็นไหม"*
