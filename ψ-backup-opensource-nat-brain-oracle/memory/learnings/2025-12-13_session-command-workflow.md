# Session Command Workflow

**Date**: 2025-12-13
**Time**: 10:55 GMT+7

## What We Learned

Session มี 4 commands ที่ทำงานด้วยกัน:

| Command | Purpose | Data Source |
|---------|---------|-------------|
| `/wip` | งานค้างจาก session ก่อน | `ψ/WIP.md` |
| `/active` | งานกำลังทำ session นี้ | focus.md + activity.log + TodoWrite |
| `/pending` | Comprehensive scan | WIP + GitHub + TODOs |
| `/done` | Mark task complete | Edit WIP/code + log |

## How Things Connect

### Flow ระหว่าง Session

```
Session Start → /wip หรือ /recap (ดูงานค้าง)
     ↓
ทำงาน → /active (ดู real-time)
     ↓
งานเสร็จ → /done [task] (mark complete)
     ↓
จบ session → /snapshot (lesson) → commit → rrr
     ↓
wip-keeper sync → WIP.md updated for next session
```

### Data Flow

```
activity.log ←──── hooks auto-log
     ↓
/active อ่าน ────→ แสดง Done section
     ↓
wip-keeper อ่าน ──→ update WIP.md
     ↓
/wip อ่าน ────────→ แสดงงานค้าง
```

## Key Discoveries

1. **Hooks = automation layer** — PreToolUse/PostToolUse log subagent activity
2. **wip-keeper = sync layer** — Keep WIP.md fresh from activity.log
3. **Commands = view layer** — Different views of same data

## Commits

- `65008fa` docs: clarify /snapshot = lesson learned before commit
- `e5ecd72` feat: add /done command
- `e795b81` feat: auto-log subagent with task description

## Tags

`workflow` `commands` `session` `/active` `/wip` `/done` `hooks`

## Raw Thoughts

- /active tree format กับ emoji ทำให้ scan ง่ายขึ้นมาก
- การที่ AI คิด title เองได้ ลด friction สำหรับ user
- wip-keeper ควร trigger auto ตอนจบ session (ยังไม่ได้ทำ)
