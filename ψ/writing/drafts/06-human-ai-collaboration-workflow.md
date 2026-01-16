# Human + AI Collaboration Workflow — Blog Draft

**Created**: 2025-12-13 20:35 GMT+7
**Status**: Draft
**Author**: Nat + Claude (Opus)

---

## Sources Index

| Type | File | Key Topics |
|------|------|------------|
| Learning | 2025-12-13_simple-beats-complex.md | Bash > Haiku, simplicity wins |
| Learning | 2025-12-13_draft-command-subagent-pattern.md | Delegation pattern |
| Learning | 002-context-finder-first.md | When to delegate |
| Retro | 20.25_jump-brewing-learn-structure.md | Jump stack, workflow |
| Retro | 17.47_draft-command-90-10-cleanup.md | Subagent return paths |
| Retro | 14.27_reunion-folder-complete.md | Structure decisions |

---

## TL;DR

วิธีทำงานร่วมกันระหว่างคนกับ AI ที่ evolve มาจากหลายสัปดาห์ของการทดลอง — ไม่ใช่ทฤษฎี แต่คือสิ่งที่ใช้จริงทุกวัน

**Core insight**: AI ไม่ได้ทำทุกอย่างเก่ง — ต้องแบ่งงานตาม strengths

---

## The Problem

เริ่มต้นใช้ Claude Code แบบ "ถามอะไรก็ให้มันทำหมด"

ปัญหาที่เจอ:
- **Token หมดเร็ว** — อ่านไฟล์ใหญ่ทุกครั้ง
- **Output หาย** — บาง subagent รันแล้วไม่มี output
- **Context งง** — ไม่รู้ว่าเพิ่งทำอะไรไป
- **ซ้ำซ้อน** — ถามคำถามเดิมซ้ำ

### Aha Moment

> "AI ไม่ต้องทำทุกอย่าง — แค่ทำสิ่งที่มันเก่ง"

---

## The Solution: Division of Labor

### Token Efficiency Hierarchy

```
Subagent (Haiku)  →  gather data (ถูก, เร็ว)
        ↓
Main (Opus)       →  review + decide
        ↓
Main (Opus)       →  write final output (ต้องการ context)
```

### 5 Core Principles

| # | Principle | How |
|---|-----------|-----|
| 1 | **Delegate Reading** | ไม่อ่านไฟล์ใหญ่เอง → ใช้ context-finder |
| 2 | **Context-Finder FIRST** | ถามตัวเองก่อน "subagent ทำได้ไหม?" |
| 3 | **Check File Size** | wc -l ก่อน → เล็ก(<500) อ่านเอง, ใหญ่ → subagent |
| 4 | **Subagent = Data Only** | Haiku เก็บข้อมูล, Opus เขียน final |
| 5 | **Hide Complexity** | Wrap ugly commands ใน clean scripts |

---

## Daily Workflow Sequence

### 1. เริ่ม Session

```bash
/jump list          # ดูว่าค้างอะไร
/pending            # งานค้าง
/recap              # สรุป context (ถ้าใหม่)
```

### 2. ระหว่างทำงาน

```bash
/jump [topic]       # เปลี่ยนเรื่อง (push stack)
/snapshot [title]   # จด moment สำคัญ
focus.md            # update current task
activity.log        # append history
```

### 3. ก่อน Commit

```bash
repo-auditor        # check file size
security-scanner    # check secrets
```

### 4. จบ Session

```bash
rrr                 # retrospective (Main เขียนเอง!)
/jump list          # verify stack
```

---

## Anti-Patterns ที่เจอ

| Wrong | Right |
|-------|-------|
| Subagent เขียน retrospective | Main เขียน, subagent เก็บ data |
| อ่านไฟล์ใหญ่ตรง | context-finder อ่านแทน |
| Haiku executor บางทีหาย output | Main รัน bash ตรงๆ (เสถียร) |
| ซับซ้อนเกินไป | Simple bash script ดีกว่า |

### Simple Beats Complex

```
Complex solution → Test → Fail sometimes
       ↓
Simplify → Test → Works 100%
       ↓
Ship it
```

Example: `/jump` command
- เริ่มจาก Haiku executor → output หายบางครั้ง
- เปลี่ยนเป็น bash script → เสถียร 100%
- บทเรียน: **Script ทำ logic, AI ทำ thinking**

---

## The Structure

```
ψ/
├── incubate/       🌱 ideas + repo/ (ignored)
├── learn/          📚 external notes + repo/ (ignored)
├── active/         ephemeral research
├── inbox/          focus.md, jump-stack.log
├── lab/            experiments (brewing/)
├── writing/        drafts
└── memory/
    ├── learnings/      patterns (31 docs)
    ├── retrospectives/ sessions
    ├── resonance/      identity
    └── logs/           snapshots

.claude/
├── commands/       /jump, /pending, /project, etc.
├── scripts/        jump.sh (bash)
└── skills/         jump/ (AI instructions)
```

---

## Key Patterns

### Pattern 1: Subagent Returns Paths, Not Content

```
❌ Subagent reads full files → sends to main
✅ Subagent finds paths → main reads selectively
```

**Why**: 10x cheaper, main context stays clean

### Pattern 2: Main Owns Quality

| Task | Who | Why |
|------|-----|-----|
| Git log, git diff | Subagent | Data gathering |
| Repo health check | Subagent | Pre-flight |
| **Retrospective** | **Main** | Needs reflection |
| **All writing** | **Main** | Quality matters |
| Review/approve | **Main** | Final gate |

### Pattern 3: Iteration Loop

```
1. Dispatch subagents (parallel)
2. Review results + decide
3. Write/Edit content
4. Verify via subagent
5. Final review
```

---

## What I Learned

1. **Delegation ไม่ใช่ขี้เกียจ** — คือ efficiency
2. **Simple > Complex** — ถ้า bash ทำได้ ใช้ bash
3. **Structure ชัด = ไม่ต้องคิดเยอะ** — notes vs repo แยกกัน
4. **Nothing is Deleted** — timestamps = truth

---

## Tags

`workflow` `collaboration` `subagent` `delegation` `claude-code`

---

## Writing Notes

### Tone
- Practical, hands-on
- Mix Thai casual + English technical

### Target Audience
- Developers using Claude Code
- People interested in human-AI collaboration

### Next Steps
- [ ] Add diagrams/screenshots
- [ ] Polish language for blog
- [ ] Add concrete examples with numbers
- [ ] Link to related blog posts

---

*Draft generated from 31 learnings + 3 retrospectives + git history*
*Ready for human review*
