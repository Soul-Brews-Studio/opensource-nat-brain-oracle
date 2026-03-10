# /forward: APPEND, NOT REPLACE (Context-Aware Design)

> **Source**: Session 2025-12-14 00:22-00:26
> **Problem**: /forward deleted URGENT deadlines and running processes
> **Insight**: /forward runs at LOW context → should do SIMPLE work

---

## The Bug

```bash
# WRONG: /forward overwrote entire WIP.md
echo "# WIP — ..." > ψ/WIP.md  # ← Everything deleted!
```

**Result**: Lost URGENT deadlines, running processes, brewing tasks

---

## The Real Insight

**Context-aware task distribution:**

| When | Context Level | Should Do |
|------|---------------|-----------|
| `/forward` (end) | **LOW** | Simple APPEND only |
| `/recap` (start) | **FRESH** | Complex MERGE/cleanup |

```
Don't try to be smart when you're tired!
```

---

## The Fix

```
/forward = APPEND only (simple, safe)
/recap   = MERGE/cleanup (complex, has context)
```

### Section Classification

| Section | Action | Why |
|---------|--------|-----|
| 🔴 URGENT | **PRESERVE** | Deadlines survive session boundaries |
| 🤖 RUNNING PROCESSES | **PRESERVE** | tmux/agents keep running |
| 🔧 Quick Commands | **PRESERVE** | Shortcuts reusable |
| 🍺 Brewing/Physical | **PRESERVE** | Physical tasks continue |
| ✅ SESSION ACCOMPLISHED | **CLEAR** | New session = new work |
| 📚 KEY LEARNINGS | **CLEAR** | Each session different |

---

## The Pattern

```
BEFORE writing WIP.md:
1. READ current WIP.md
2. EXTRACT persistent sections
3. MERGE with new session info
4. WRITE combined result
```

**NOT**: Just write new content and overwrite

---

## Design Insight

**"Fresh start"** was misunderstood:

| Term | Intended | Misunderstood |
|------|----------|---------------|
| Fresh start | Fresh AI context window | Delete all state |
| New session | Clear focus, new work | Forget running processes |

**Correct interpretation**:
- Fresh AI context = `/clear`
- Operational continuity = WIP.md preserves persistent sections

---

## Anti-pattern

```
❌ เขียน WIP.md ใหม่ทั้งหมดโดยไม่อ่านเดิม
✅ อ่าน WIP.md → extract persistent → merge new → write
```

---

## Files Updated

- `.claude/commands/forward.md` — Added MERGE strategy + section classification

---

*Pattern discovered when /forward deleted Brewing section*
