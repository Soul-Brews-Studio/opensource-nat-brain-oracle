# Claude Code Workshop Lessons — Blog Draft

**Created**: 2025-12-22 14:32 GMT+7
**Status**: Draft
**Author**: Human + AI collaboration

---

## Sources Index

| Type | File | Key Topics |
|------|------|------------|
| Retrospective | ψ/memory/retrospectives/2025-12/22/14.25_tong-claude-code-training.md | Tong training, demo prep |
| Retrospective | ψ/memory/retrospectives/2025-12/22/09.22_arthur-demo-workshop-prep.md | Arthur demo, workshop planning |
| Slides | ψ/writing/slides/2025-12-22_subagent-workshop.md | 10-slide deck, subagent teaching |
| Learning | ψ/memory/learnings/2025-12-22_verify-before-demo-content.md | Demo verification pattern |
| History | SIIT workshops (Dec 12), Wave art workshop (Dec 18) | Past workshop experience |

---

## TL;DR

สอน Claude Code ไม่ใช่แค่สอน tool — แต่ต้องสอน "วิธีคิด" การ delegate งานให้ AI สิ่งที่ได้ผลคือ: **Live coding > Slides**, **Subagent demo > Feature list**, **"ลูกน้อง ปุ่มลัด คู่มือ" > "Subagent Command Skill"**

---

## The Problem

### Context
สอน Claude Code ให้คนที่ไม่เคยใช้ยากมาก:
- Feature เยอะเกินไป (subagents, commands, skills, hooks, MCP...)
- Documentation เป็น English technical
- ไม่รู้จะเริ่มตรงไหน

### Pain Point
"Claude Code ทำอะไรได้?" — คำถามนี้ตอบยาก เพราะมันทำได้ทุกอย่าง แต่ต้องรู้วิธี extend

---

## The Journey

### Attempt 1: สอนจาก Feature List
ครั้งแรกลองสอนโดยไล่ features:
- "Subagent คือ specialized agent ที่..."
- "Command คือ prompt template ที่..."
- "Skill คือ..."

**ผลลัพธ์**: คนฟังงง ไม่เห็นภาพว่าจะใช้ตอนไหน

**เรียนรู้**: Technical terms ไม่ช่วย — ต้องมี metaphor

### Attempt 2: ใช้ Metaphor
เปลี่ยนมาใช้คำเปรียบเทียบ:

| Technical | Metaphor |
|-----------|----------|
| Subagent | "ลูกน้อง" ที่ทำงานแยก |
| Command | "ปุ่มลัด" ที่พิมพ์เอง |
| Skill | "คู่มือ" ที่ AI อ่านเอง |

**ผลลัพธ์**: เข้าใจง่ายขึ้น แต่ยังไม่เห็นว่าใช้ยังไง

**เรียนรู้**: Metaphor ช่วย แต่ต้อง demo ด้วย

### Attempt 3: Live Coding Demo
สร้าง subagent ให้ดูสดๆ:

```markdown
# tong-finder.md (สร้างให้ดูใน 2 นาที)
---
name: tong-finder
description: ค้นหาไฟล์และ git history
tools: Bash, Grep, Glob
model: haiku
---
```

**ผลลัพธ์**: "อ๋อ! แค่นี้เองหรอ?" — breakthrough moment

**เรียนรู้**: Live coding > 1000 slides

### Aha Moment
จุดเปลี่ยนคือ **Memory Search Demo**:
- ถาม: "หาเรื่องเมาให้หน่อย"
- Claude: หาเจอใน 2 วินาที — activity log จาก 13 ธ.ค.

คนดูเห็นว่า AI "จำ" ได้จริง → ทำให้อยากเรียนต่อ

---

## The Solution

### Workshop Structure ที่ได้ผล

```
1. HOOK (5 min)
   └── Memory search demo — "หาของให้หน่อย" → เจอทันที

2. CONCEPT (10 min)
   └── Metaphor: ลูกน้อง / ปุ่มลัด / คู่มือ
   └── Decision tree: เลือกอะไรดี?

3. LIVE CODING (20 min)
   └── สร้าง subagent ด้วยกัน
   └── ทดสอบเลย

4. HANDS-ON (15 min)
   └── แต่ละคนสร้างของตัวเอง
```

### Slides ที่ใช้ได้ (10 slides)

| # | Slide | Purpose |
|---|-------|---------|
| 1 | Title | Hook |
| 2 | Big Picture | 3 tools overview |
| 3-4 | Subagent | Concept + code |
| 5-6 | Command | Concept + code |
| 7-8 | Skill | Concept + code |
| 9 | Decision Tree | เลือกอะไร? |
| 10 | Hands-on | ลงมือทำ |

### Key Demo Script

```
Demo 1: Memory Search
> หาเรื่อง [X] ให้หน่อย
→ เจอใน memory ทันที

Demo 2: Subagent Creation
> สร้าง subagent ให้ดู
→ เขียน .claude/agents/demo.md
→ ใช้งานเลย

Demo 3: Parallel Work
> /trace [topic]
→ 5 agents search พร้อมกัน
→ รวมผลลัพธ์
```

---

## The Pattern

### Key Takeaways

1. **Metaphor First, Technical Later**
   - "ลูกน้อง" > "Subagent"
   - เข้าใจ concept ก่อน → technical terms ตามหลัง

2. **Live Coding > Slides**
   - สร้างให้ดูสดๆ 2 นาที > อธิบาย 20 นาที
   - "แค่นี้เอง?" = success

3. **Demo ที่ Personal**
   - "หาเรื่องเมา" = personal, memorable
   - "Search git history" = boring, forgettable

4. **Decision Tree สำคัญ**
   - ไม่ใช่แค่ "คืออะไร" แต่ "ใช้เมื่อไหร่"
   - ต้อง context แยก? → Subagent
   - พิมพ์ /xxx เอง? → Command
   - หลายไฟล์? → Skill

### When to Apply
- Workshop Claude Code สำหรับ beginners
- Teaching AI tools ทั่วไป
- Any "feature-rich" tool explanation

### When NOT to Apply
- Advanced users ที่รู้ concepts แล้ว
- Documentation writing (ต้อง technical)

---

## Full Context

### Session Timeline (Dec 22, 2025)
- 09:22 — Arthur demo + workshop prep
- 12:04 — FloodBoy timeline trace
- 13:40 — Arrived Grand Centre Point
- 13:45 — Voice design trace
- 13:52 — Memory search demo ("เมา")
- 14:01 — tong-finder subagent creation
- 14:02 — Docs reading (subagent vs command vs skill)
- 14:04 — Generated 10-slide workshop

### Related Commits
| Hash | Message |
|------|---------|
| 03f08a0 | rrr: arthur demo prep + workshop planning |
| ae915d2 | feat: add SIIT Day 1 workshop slides |
| fbbaa03 | rrr: wave art workshop collab |

### Workshop History
- SIIT workshops (Dec 12) — 3+ sessions
- Wave art workshop (Dec 18) — "Replace Your ___ with AI"
- Tong training (Dec 22-23) — Grand Centre Point

---

## Tags

`workshop` `claude-code` `teaching` `subagent` `metaphor` `live-coding`

---

## Writing Notes

### Tone
- Practical, hands-on
- Thai-English mix (natural)
- Story-driven with concrete examples

### Target Audience
- Workshop facilitators
- Claude Code beginners
- AI tool trainers

### Suggested Title Alternatives
1. "สอน Claude Code ยังไงให้คนเข้าใจใน 30 นาที"
2. "ลูกน้อง ปุ่มลัด คู่มือ — Metaphor ที่ทำให้ Claude Code เข้าใจง่าย"
3. "Live Coding > Slides: บทเรียนจากการสอน Claude Code"

### Next Steps
- [ ] Review with actual workshop feedback
- [ ] Add screenshots of demo
- [ ] Record video version
- [ ] Publish on blog

---

*Draft generated from session knowledge*
*Ready for human review and AI continuation*
