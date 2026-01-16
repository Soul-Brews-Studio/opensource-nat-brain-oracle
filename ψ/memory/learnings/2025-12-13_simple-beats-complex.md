# Simple Beats Complex

**Date**: 2025-12-13

## What We Learned

- **Bash script > Haiku executor** สำหรับงานง่ายๆ
  - Haiku executor บางครั้ง output หาย
  - Main agent รัน bash ตรงๆ = เสถียร 100%

- **Script ทำ logic, AI ทำ thinking**
  - `/jump` = bash script ทำ read/write file
  - AI ช่วยเฉพาะหา context (ถ้าต้องการ)

- **Structure ที่ดี = ไม่ต้องคิดเยอะ**
  - `ψ/learn/` = notes (tracked) + `repo/` (ignored)
  - `ψ/incubate/` = ideas (tracked) + `repo/` (ignored)
  - แยกชัด = ไม่งง

## How Things Connect

```
Complex solution → Test → Fail sometimes
    ↓
Simplify → Test → Works 100%
    ↓
Ship it
```

- `/jump` เริ่มจาก executor (Haiku) → พบว่าไม่เสถียร → กลับมา bash ตรงๆ
- `reunion/` → เปลี่ยนเป็น `ψ/learn/` → ชัดเจนกว่า
- Snow Mash = overnight mash → รหัสลับสองคน 🤫

## Patterns

| Complex | Simple |
|---------|--------|
| Haiku executor | Bash script |
| Multiple folders | 2 folders (notes + repo) |
| AI ทำทุกอย่าง | Script ทำ logic, AI ทำ thinking |

## Tags

`simplicity` `bash` `architecture` `jump` `learn`
