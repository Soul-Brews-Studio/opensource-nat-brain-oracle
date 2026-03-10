# Concept: Cross-Repo Context Forward

**Status**: 💭 Concept
**Created**: 2025-12-11

---

## Idea

Forward context จาก repo นี้ไปสร้าง GitHub Issue ใน repo อื่น

```
Nat's Agents (repo A)
    │
    │ gh issue create --repo B
    │
    ▼
GitHub Issue ใน repo B
    │
    ▼
Claude session ใน repo B เห็น context
```

## Why Useful

- Context ไม่หายเมื่อย้าย project
- Cross-project handoff
- ใช้ GitHub เป็น bridge

## Technical Approach (unproven)

```bash
# Command idea
/forward-to-repo <owner/repo>

# Creates issue with:
# - Current context summary
# - Key decisions
# - Links back to source
```

## Challenges

- [ ] GitHub Issue limit (65,536 chars)
- [ ] Format ที่ Claude อ่านง่าย
- [ ] Privacy - public vs private repos
- [ ] ยังไม่ได้ทดสอบ

## When to Test

เมื่อต้องทำงานข้าม repo บ่อยๆ

## Related

- `/forward` command (local WIP.md)
- `ψ/inbox/handoff/` (session handoff)

---

*Concept only - may or may not work*
