# Course 003: AI Coding Buddy & Life Tracker

> **ให้ AI เป็นเพื่อนคู่คิด — ทั้งเขียนโค้ดและจัดการชีวิต**

## Course Info

| Item | Value |
|------|-------|
| **Duration** | 4 ชั่วโมง |
| **Level** | Intermediate |
| **Prerequisites** | 000-setup, basic Claude Code |
| **Outcome** | Personal AI system ที่รู้จักคุณ |

---

## Course Description

เรียนรู้วิธีสร้าง AI buddy ที่:
- **รู้จักคุณ** — จำ context, patterns, preferences
- **ช่วยเขียนโค้ด** — pair programming ตลอดเวลา
- **track ชีวิต** — feelings, work hours, learnings
- **จัดการงาน** — projects, deadlines, handoffs

**Based on real system**: Nat's Agents (ψ/ folder structure)

---

## Learning Objectives

หลังจบ course ผู้เรียนจะสามารถ:

1. ✅ สร้าง personal AI system ที่จำ context ได้
2. ✅ ออกแบบ folder structure สำหรับ "AI brain"
3. ✅ สร้าง custom commands (/feel, /fyi, /jump)
4. ✅ Log emotions, work patterns, learnings อัตโนมัติ
5. ✅ ใช้ subagents เพื่อ research และ analysis
6. ✅ สร้าง retrospectives และ handoffs

---

## Course Outline

### Part 1: Philosophy (30 min)
**"Oracle Keeps the Human Human"**

- AI as external brain, not replacement
- Nothing is deleted — append only
- Patterns over intentions
- Context is everything

**Demo**: Show ψ/ folder structure

### Part 2: Folder Structure (45 min)
**"5 Pillars of AI Brain"**

```
ψ/
├── active/     ← กำลังค้นคว้าอะไร?
├── inbox/      ← คุยกับใคร?
├── writing/    ← กำลังเขียนอะไร?
├── lab/        ← กำลังทดลองอะไร?
└── memory/     ← จำอะไรได้?
    ├── resonance/      WHO I am
    ├── learnings/      PATTERNS I found
    ├── retrospectives/ SESSIONS I had
    └── logs/           MOMENTS captured
```

**Hands-on**: Create your own ψ/ structure

### Part 3: Custom Commands (60 min)
**"Make AI Work Your Way"**

| Command | Purpose | We'll Build |
|---------|---------|-------------|
| `/feel` | Log emotions | ✅ |
| `/fyi` | Log info with context | ✅ |
| `/jump` | Topic switching with stack | ✅ |
| `/rrr` | Session retrospective | ✅ |

**Hands-on**: Create 2 custom commands

### Part 4: Life Tracking (45 min)
**"AI ที่รู้จักคุณ"**

#### Work Hours Pattern
```markdown
## Work Patterns
- Average: 10-14 ชม./วัน (intensive)
- Peak: 19+ ชม. overnight
- Window: 09:00-24:00
```

#### Feelings Log
```markdown
## Feeling: exhausted
Context: 04:00 นอน + heavy day
Pattern: Overnight → short sleep → crash
```

**Hands-on**: Log your first week

### Part 5: Retrospectives & Handoffs (60 min)
**"AI ที่ส่งต่อได้"**

#### Retrospective Format
```markdown
# Session Retrospective
## What Happened
## AI Diary (honest reflection)
## For Next Session
```

#### Handoff
```markdown
# Handoff: [Topic]
## Task for Next Session
## Context
## Questions to Ask
```

**Hands-on**: Write a retrospective

---

## Workshop Activities

| Time | Activity | Output |
|------|----------|--------|
| 0:00 | Philosophy intro | Understanding |
| 0:30 | Create ψ/ structure | Folder setup |
| 1:15 | Build /feel command | Working command |
| 2:00 | Build /fyi command | Working command |
| 2:30 | BREAK | - |
| 2:45 | Life tracking setup | Logs started |
| 3:30 | First retrospective | rrr file |
| 4:00 | Q&A + Show & Share | - |

---

## What You'll Take Home

1. **Personal AI system** — ψ/ folder ready to use
2. **4 custom commands** — /feel, /fyi, /jump, /rrr
3. **Life tracking templates** — work hours, feelings
4. **Retrospective habit** — end-of-session ritual
5. **CLAUDE.md** — customized for your workflow

---

## Real Examples (From This System)

### Example: /feel
```
/feel เหนื่อยจัด แย่มาก

→ Creates: ψ/memory/logs/feelings/2025-12-14_19-45_exhausted.md
→ With context: overnight session, 200L beer dumped, deadline stress
```

### Example: /fyi
```
/fyi เมื่อคืนนอนตีสี่

→ Creates: ψ/memory/logs/info/2025-12-14_12-26_sleep-time-04.md
→ AI adds: cross-reference to work patterns, pitch prep context
```

### Example: Work Pattern Discovery
```
AI analyzed retrospectives:
- "27h/day" = impossible → corrected to 19+ ชม. overnight
- Bimodal: either 12-14h or <3h (no middle)
- Peak creativity: evening/overnight
```

---

## Who Is This For?

**Perfect for**:
- Developers who want AI pair programming
- People who want to track life patterns
- Anyone building "second brain" systems
- Teams wanting shared AI knowledge base

**Not for**:
- Complete beginners (need 000-setup first)
- People who just want chat (use ChatGPT)

---

## Prerequisites

- ✅ Completed 000-setup (Claude Code installed)
- ✅ Basic terminal/command line
- ✅ Comfortable with Markdown
- ✅ Open to "AI as partner" mindset

---

## Materials Provided

- [ ] Starter ψ/ template
- [ ] Command templates (.claude/commands/)
- [ ] CLAUDE.md example
- [ ] Work pattern tracker template
- [ ] Retrospective template

---

## Instructor Notes

**Key points to emphasize**:
1. AI doesn't replace you — amplifies you
2. Context is the magic ingredient
3. Consistency > perfection (log something > log perfectly)
4. Retrospectives build compounding knowledge

**Common questions**:
- "Isn't this just journaling?" → No, AI actively uses the data
- "What about privacy?" → Everything local, nothing external
- "How is this different from Notion?" → AI reads and writes context

---

## Follow-up Courses

After this course:
- **004**: Multi-agent workflows (subagents)
- **005**: Voice interface (speak to AI)
- **006**: Team AI (shared knowledge base)

---

*Course 003: AI Coding Buddy & Life Tracker*
*Duration: 4 hours | Level: Intermediate*
*Status: 💡 Idea*
