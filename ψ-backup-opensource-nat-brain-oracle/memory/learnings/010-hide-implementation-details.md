---
title: "010: Hide Implementation Details"
tags: [learning, ux, scripting, presentation]
created: 2025-12-11
source: session-feedback
---

# 010: Hide Implementation Details

> Wrap ugly commands in clean scripts - ไม่อยากให้คนเห็น implementation

## Pattern

| แทนที่จะใช้ | ใช้ |
|------------|-----|
| `osascript scripts/xxx.scpt "..."` | `./scripts/send-antigravity "..."` |
| `curl -X POST ...` | `./scripts/api-call` |
| Complex command chains | Simple wrapper script |

## Why

- **Cleaner output** - คนดูไม่ต้องเห็น osascript, curl, etc.
- **Easier to remember** - ชื่อ script บอกว่าทำอะไร
- **Encapsulation** - เปลี่ยน implementation ข้างในได้โดยไม่กระทบ usage

## Implementation

```bash
# scripts/send-antigravity (wrapper)
#!/bin/bash
SCRIPT_DIR="$(dirname "$0")"
osascript "$SCRIPT_DIR/send-to-antigravity.scpt" "$1"
```

## Anti-Pattern

- ❌ แสดง raw osascript commands
- ❌ แสดง implementation details ที่ไม่จำเป็น
- ❌ Long complex commands in output

## Best Practice

- ✅ Wrap in executable script with clear name
- ✅ Hide complexity behind simple interface
- ✅ Script name = what it does (verb-noun)
- ✅ **เมื่อซ่อนแล้ว อย่าพูดถึงสิ่งที่ซ่อน** - แค่บอก "เรียบร้อย"

## Communication Pattern

| ❌ Don't say | ✅ Say instead |
|-------------|----------------|
| "ไม่มี osascript โผล่มาให้เห็นแล้ว" | "เรียบร้อย" |
| "ซ่อน implementation แล้ว" | "โอเค ใช้ได้แล้ว" |
| อธิบายว่าซ่อนอะไร | ไม่พูดถึงเลย |

**หลักการ**: ถ้าซ่อนแล้ว = ไม่มีอยู่ = ไม่ต้องพูดถึง

---

*Learned from Antigravity script session, 2025-12-11*
