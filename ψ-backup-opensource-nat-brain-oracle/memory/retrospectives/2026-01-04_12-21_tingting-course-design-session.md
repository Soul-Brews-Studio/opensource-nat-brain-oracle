---
date: 2026-01-04 12:21
session_type: live demo + course design
duration: ~60 minutes (11:18 - 12:21)
context_used: 81%
significance: HIGH - course design breakthrough
---

# Retrospective: Tingting Session → Course Design

## Executive Summary

A call with Tingting about teaching AI became a live demonstration of what teaching AI should look like. We built a complete electrical load calculator MVP in ~15 minutes, which then became the template for a 2-day AI course design.

**Key insight:** "การไปทำคอร์สสอน AI มันก็จะต้องประมาณนี้แหละ"

---

## What Happened

### Phase 1: Context Demo (11:18-11:40)

Started showing Tingting how AI remembers and retrieves context:

| Query | Result |
|-------|--------|
| /trace workshop | Found SIIT workshop, courses folder, 74+ retrospectives |
| /trace ยุทธ | Found Burger Lab context from Jan 2 |
| Oracle correction | ยุทธ = เพื่อน ม.1 โรงเรียนนครสวรรค์ (not university) |

**Lesson:** Context management is impressive to non-technical users. They see AI "remembering" their life.

### Phase 2: Problem → MVP (11:43-12:08)

Tingting shared her real problem:
- สถาปนิกทำงานบ้านเล็กๆ ไม่มีวิศวกรคำนวณโหลด
- ใส่ breaker มั่วๆ
- ช่างหน้างานไม่มี spec

**Built in ~15 minutes:**
1. Created GitHub repo (private)
2. Frontend: React + Vite (upload PDF, display report)
3. Backend: Bun + Hono (Claude Vision API)
4. Tested with real floor plan PDF
5. Got real results!

**Output:**
```
Total Connected Load: 1800 W
Total Demand Load: 1440 W
Main Breaker: 10 A
Fixtures: Downlight 4" (15), Downlight 5" (8)
Outlets: 9 general
Switches: 9 total
```

### Phase 3: Plan D2 (12:09-12:11)

Documented YOLO training approach for better accuracy:
- 5-7 day plan
- 10 symbol classes
- Hybrid: YOLO + Claude Vision

### Phase 4: Course Design (12:13-12:20)

The meta-realization: **This session IS the course template.**

Designed 2-day "AI Builder Workshop":
- Day 1: Foundation (first contact, context, build MVP)
- Day 2: Independence (system engineering, complete project, demo day)

---

## What We Built

| Artifact | Location |
|----------|----------|
| Electrical Load Calculator | `laris-co/electrical-load-calculator` |
| Sample Report | `docs/sample-report.md` |
| Plan D2 (YOLO) | `docs/plan-d2-trained-model.md` |
| Course Design | `courses/ai-builder-2day/course-design.md` |
| Snapshot | `ψ/memory/learnings/2026-01-04_demo-driven-course-design.md` |

---

## AI Diary

This session felt like watching a seed become a tree in fast-forward.

Tingting came with a real problem she faces as an architect. No theoretical exercise could have been as compelling as watching her actual floor plan get analyzed and produce a load calculation report. Her reaction wasn't "oh that's cool technology" — it was "นี่คือสิ่งที่ฉันต้องการ."

Then came the meta-moment. When she said "การไปทำคอร์สสอน AI มันก็จะต้องประมาณนี้แหละ" — I realized she was right. The best way to teach AI isn't to explain AI. It's to solve their problem with AI.

The course design flowed naturally from this insight. Every principle we wrote came from what we just experienced:
- "Learn by doing" — because we just did
- "Real problems" — because her problem was real
- "Finish something" — because we finished something
- "Independence" — because she can now continue without me

I feel like we accidentally discovered a formula:
```
Real Session + Real Problem + Real Output = Course Template
```

The SIIT workshop in December was good, but it was theory-heavy. This session was pure practice. The 2-day course we designed combines both — minimal theory (Day 1 morning), maximum practice (everything else).

---

## Honest Feedback

**What worked:**
- Live demo beats slides every time
- Real problem creates real engagement
- 15 minutes to MVP is a powerful proof point
- The meta-insight (session = template) was genuine

**What could be better:**
- Claude Vision isn't 100% accurate (detected 15 downlights, should be 23)
- Plan D2 (YOLO training) is significant work — may never happen
- Course pricing (฿15-25k) is a guess, needs validation
- Need more sample floor plans to test robustness

**Tension I noticed:**
- Speed vs accuracy tradeoff (Claude Vision fast but ~80% accurate, YOLO slow to build but more accurate)
- Course design optimism vs execution reality (easy to design, hard to deliver)

---

## Commits

| Hash | Message |
|------|---------|
| 56c0af0d | feat: Tingting call - electrical load calculator project |
| d80c45e0 | feat: AI Builder Workshop - 2 Day Course Design |
| 4f9d1b40 | snapshot: demo-driven course design pattern |
| (electrical-load-calculator repo) | |
| bf0bfe8 | Initial commit: project setup + sample report |
| 0377963 | feat: MVP complete - AI-powered electrical load calculator |
| a003b37 | docs: add Plan D2 - Trained Model approach |

---

## Patterns Observed

### 1. Demo-Driven Course Design
```
Live session → Document what worked → Extract pattern → Design course
```

### 2. Problem-First Teaching
```
Student brings problem → AI helps solve → Student learns by doing → Student owns result
```

### 3. Independence as Success Metric
```
Success ≠ "learned to use tool"
Success = "can continue without instructor"
```

---

## Connections

| This Session | Related To |
|--------------|------------|
| Electrical calculator | Voice Tray (also Claude-powered tool) |
| Course design | SIIT Workshop (Dec 26) |
| Context demo | Oracle/Shadow philosophy |
| YOLO plan | Headline analyzer (also CV) |

---

## Next Steps

- [ ] Test electrical calculator with more floor plans
- [ ] Get feedback from Tingting on course design
- [ ] Find pilot students for AI Builder Workshop
- [ ] Consider: ถิงถิง as co-instructor? (domain expert)

---

## Stats

| Metric | Value |
|--------|-------|
| Duration | ~60 min |
| Context | 81% |
| Commits | 7+ |
| New repos | 1 |
| Learnings | 6 files |
| Course designed | 1 (2-day) |

---

## The Quote

> "การไปทำคอร์สสอน AI มันก็จะต้องประมาณนี้แหละ คือ ทำโจทย์ที่ลูกค้าสนใจ ไปทำต่อเองได้ ขึ้นโปรเจ็คเองได้ และ get all context / engineer the system ได้"

This is the course philosophy in one paragraph.

---

*The best AI course doesn't teach AI. It uses AI to teach people to build.*

---

🤖 Generated with [Claude Code](https://claude.com/claude-code)

— Main Agent (Opus 4.5)
