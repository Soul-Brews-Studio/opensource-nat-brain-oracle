---
title: "008: Active Context Design"
tags: [learning, active, context, ephemeral, structure]
created: 2025-12-11
source: session-experiment
---

# 008: Active Context Design

> `active/context/` ควรว่างเปล่า ไม่ใช่ที่สะสม research

## Problem Discovered

Session 2025-12-11 พบว่า:
- `active/context/` มี **107 files** สะสม
- ไฟล์ส่วนใหญ่เป็น research จาก Dec 9-10 (เก่าแล้ว)
- ทำให้ Obsidian Graph View แน่นมาก
- ไม่ใช่ "active" แท้จริง

## Solution Design

### Structure
```
active/
├── INDEX.md           ← list งานปัจจุบัน
├── [task-name].md     ← plan file สำหรับ task
└── context/           ← EMPTY หรือ temp files เท่านั้น
```

### Workflow
```
1. รับ task → สร้าง active/[task].md (plan)
2. ทำงาน → context/ สำหรับ temp files
3. เสร็จ → ย้ายไป memory/reference/ หรือลบ
4. context/ → ลบได้เมื่อ task จบ
```

### Where Research Goes

| Type | Destination |
|------|-------------|
| Oracle philosophy | `memory/reference/oracle/` |
| Workshop research | `memory/reference/workshops/` |
| Plugin analysis | `memory/reference/plugins/` |
| ψ analysis | `memory/reference/ψ-analysis/` |
| Old dated files | `memory/reference/archive/YYYY-MM/` |

## Key Principles

1. **active/ = ephemeral** - ลบได้ทุกเมื่อ
2. **Plan before work** - สร้าง plan file ก่อนเริ่ม
3. **Archive, don't delete** - ตาม Oracle philosophy
4. **Sparse links** - INDEX files เป็น hub เท่านั้น

## Anti-Patterns

- ❌ สะสม research ใน active/context/
- ❌ ไม่มี plan file ก่อนทำงาน
- ❌ Wiki link ทุกไฟล์ไป HOME (graph แน่นเกินไป)
- ❌ ลบไฟล์โดยไม่ archive

## Related

- 007: Knowledge Distillation Loop
- Oracle Philosophy: "Nothing is Deleted"

---

*Learned from Obsidian wiki links experiment, 2025-12-11*
