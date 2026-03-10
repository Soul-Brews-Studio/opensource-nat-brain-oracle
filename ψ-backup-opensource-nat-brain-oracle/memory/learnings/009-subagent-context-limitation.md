---
title: "009: Subagent Context Limitation"
tags: [learning, subagent, context, tokens, efficiency]
created: 2025-12-11
source: session-observation
---

# 009: Subagent Context Limitation

> Subagent ไม่รู้ context เต็ม - ใช้ gather data เท่านั้น, ไม่ใช่ write final output

## Problem Discovered

Session 2025-12-11 พบว่า:
- ให้ Haiku subagent เขียน retrospective
- Subagent เขียนไปผิด path (`ψ-retrospectives/` แทนที่จะเป็น `ψ/memory/retrospectives/`)
- ต้อง mv แล้ว read อีกที = เปลือง tokens

## Pattern

| Task Type | Who Should Do |
|-----------|---------------|
| Gather data (git log, search) | **Subagent** (Haiku) |
| Write final output (retrospective, docs) | **Main agent** (Opus) |

## Why

- **Subagent** = ไม่เห็น conversation history, ไม่รู้ context เต็ม
- **Main agent** = รู้ทุกอย่างที่คุยกันมา, เขียนได้ตรง context

## Anti-Patterns

- ❌ ให้ subagent เขียน retrospective (ไม่รู้ context)
- ❌ mv/cp แล้ว read file อีกที (เปลือง tokens)
- ❌ ให้ subagent ทำ task ที่ต้องการ full context

## Best Practices

- ✅ Subagent = gather data, search, analysis
- ✅ Main agent = write final output with context
- ✅ ใช้ `stat` หรือ `wc -l` แทน read หลัง mv/cp

## Hash Verification

หลัง mv/cp file ถ้าต้องการ verify ว่าถูกต้อง:

```bash
# แทนที่จะ read file (เปลือง tokens)
md5 -q /path/to/file

# หรือ check file exists + size
stat -f "%z bytes" /path/to/file
```

**Why**: อ่าน content เปลือง tokens, hash/stat บอกได้ว่า file อยู่ถูกที่ + ขนาดถูกต้อง

## Related

- 002: Context-Finder First
- 008: Active Context Design

---

*Learned from retrospective writing session, 2025-12-11*
