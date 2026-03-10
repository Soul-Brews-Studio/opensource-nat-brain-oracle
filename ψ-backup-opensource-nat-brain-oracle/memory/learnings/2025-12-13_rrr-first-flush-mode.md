# RRR First, Flush Mode

**Date**: 2025-12-13

## What We Learned

### Flow Change

**เดิม (ผิด):**
```
งานเสร็จ → /snapshot → commit → rrr
```

**ใหม่ (ถูก):**
```
งานเสร็จ → rrr → /snapshot
```

**ทำไม:**
- rrr creates data (retrospective)
- snapshot extracts patterns from data
- ไม่มี data → ไม่มี pattern

### Flush Mode

เมื่อ context เหลือน้อย:
- ไม่ spawn subagents
- Main agent เขียนเลยจากที่จำได้
- Flush ลง file ก่อนหมด

**เหมือน `sync` ใน Unix** — flush buffers to disk before shutdown

## How Things Connect

- **rrr** = flush memory to file
- **snapshot** = extract patterns from file
- **subagents** = expensive when context low
- **flush mode** = skip subagents, write direct

## Tags

`rrr` `snapshot` `flush-mode` `workflow` `context-management`
