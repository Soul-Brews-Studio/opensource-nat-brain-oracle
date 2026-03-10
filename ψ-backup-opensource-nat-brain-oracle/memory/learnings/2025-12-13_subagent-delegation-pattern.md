# Subagent Delegation Pattern

**Created**: 2025-12-13
**Source**: Session ที่ context หมดเร็วเพราะ main agent ทำเองหมด

---

## Key Insight

> **แจกงาน + ตอบสั้น + ตรวจ + trust หรือ verify**

---

## Anti-Pattern (ทำให้ context หมดเร็ว)

```
Main Agent: Read file 1 → Edit → Read file 2 → Edit → ... (36 times)
= 70+ file operations = context เต็ม
```

## Pattern (ประหยัด context)

```
1. Main แจกงาน → Subagents (parallel)
2. Subagents ทำ + ตอบสั้นๆ (summary only)
3. Main ตรวจ + ให้คะแนน
4. ถ้าไม่เชื่อ → ค่อยอ่านไฟล์เอง
```

---

## Subagent Response Format

```
✅ Done: 11/11 files

| File | Status |
|------|--------|
| file1.md | ✅ |
| file2.md | ✅ |

Verify: [command to check]
Expected: [result]
```

---

## When to Use

| Task | Use Subagent? |
|------|---------------|
| Edit 5+ files | ✅ Yes |
| Bulk search | ✅ Yes |
| Single file edit | ❌ No |
| Complex logic | ❌ No (main ทำเอง) |

---

## Apply When

- ต้อง edit หลายไฟล์ pattern เดียวกัน
- ต้อง search หลาย source
- งาน repetitive ที่ Haiku ทำได้

---

*"Trust but verify — ถ้า verify ผ่าน ไม่ต้องอ่านเอง"*
