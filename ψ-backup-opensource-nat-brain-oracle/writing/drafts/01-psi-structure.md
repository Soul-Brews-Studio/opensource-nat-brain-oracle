# Blog Material: Designing AI's Brain - The ψ/ Structure

> Engineering session notes: 2025-12-11
> Co-created with Claude Opus 4.5

---

## The Problem

เริ่มต้นจากความรู้สึกว่า:

> "ไอ้พวก context, drafts, learnings, logs, retrospectives, reference อะไรพวกนี้มันเหลือทั้งหมดเลย... มันมากวนบริบทของ human ให้มันน้อยลงหน่อย"

**7 folders at root** = cognitive overload

```
Before:
├── ψ-context/
├── ψ-drafts/
├── ψ-learnings/
├── ψ-logs/
├── ψ-reference/
├── ψ-retrospectives/
└── .inbox/
```

---

## The Journey

### Round 1: Consolidate to ψ/

First attempt - just nest everything:

```
ψ/
├── context/
├── drafts/
├── learnings/
├── logs/
├── reference/
└── retrospectives/
```

**Result**: Still 6 subfolders, just moved.

---

### Round 2: Active vs Passive

แบ่งตามลักษณะการใช้งาน:

> "Active = สิ่งที่ต้องทำ, Passive = สิ่งที่เก็บไว้ดู"

```
ψ/
├── active/     ← ทำอะไร
└── passive/    ← เก็บอะไร
```

**Result**: Better concept, but inbox is special...

---

### Round 3: Inbox as Communication Hub

> "inbox เป็นระบบติดต่อสื่อสารกับ AI ตัวอื่น"

```
ψ/
├── active/
├── inbox/      ← Communication (self + other AI)
└── memory/
```

**Result**: 3 pillars emerging.

---

### Round 4: Resonance

> "มันมีอันนึงที่ชอบมากคือ resonance"

Resonance = soul configuration = who I am

```
memory/
├── resonance/      ← WHO I am (soul)
├── learnings/      ← PATTERNS I found
├── retrospectives/ ← SESSIONS I had
└── logs/           ← MOMENTS I captured
```

**Key insight**: Knowledge has hierarchy of refinement.

```
logs → retrospectives → learnings → resonance
(raw)    (session)      (pattern)    (soul)
```

---

### Round 5: Lab vs Learnings

> "Learning ก็ควรจะเป็น lab ไหม... ไอ้การเรียนรู้ของเรามันเป็นลักษณะของ lab"

Two different concepts:
- **lab/** = hands-on experiments (code, POCs)
- **memory/learnings/** = distilled patterns (wisdom)

```
ψ/
├── lab/            ← ทดลอง (agent-sdk, experiments)
├── reference/      ← อ่าน (external docs)
└── memory/
    └── learnings/  ← กลั่น (patterns from sessions)
```

---

### Round 6: Writing as Workflow

> "แยกงานเขียนออกมาเลย เพราะว่างานเขียนก็เหมือนการทำงานนี่แหละ มี context มีการกลั่นกรอง มี output"

Writing is a full workflow like lab:
- Input (research)
- Process (drafting)
- Output (published)

```
ψ/
├── writing/    ← เขียน (blogs, articles)
└── lab/        ← ทดลอง (experiments)
```

---

## Final Structure: 5 Pillars

```
ψ/
├── active/     ← "กำลังค้นคว้าอะไร?"
├── inbox/      ← "คุยกับใคร?"
├── writing/    ← "กำลังเขียนอะไร?"
├── lab/        ← "กำลังทดลองอะไร?"
└── memory/     ← "จำอะไรได้?"
    ├── resonance/
    ├── learnings/
    ├── retrospectives/
    └── logs/
```

---

## Key Insights

### 1. Folders = Questions

Each folder answers a question:
| Folder | Question |
|--------|----------|
| active/ | ทำอะไรอยู่? |
| inbox/ | คุยกับใคร? |
| writing/ | เขียนอะไร? |
| lab/ | ทดลองอะไร? |
| memory/ | จำอะไรได้? |

### 2. Knowledge Hierarchy

```
★★★★★  resonance   (soul - who I am)
★★★★☆  learnings   (patterns)
★★★☆☆  retrospectives (sessions)
★★☆☆☆  logs        (snapshots)
★☆☆☆☆  reference   (external)
```

### 3. Lab vs Learnings Distinction

| lab/ | memory/learnings/ |
|------|-------------------|
| Hands-on | Reflection |
| Code experiments | Written patterns |
| POCs | Lessons learned |
| "Do to learn" | "Learned from doing" |

### 4. Writing as First-Class Citizen

Writing deserves its own pillar because:
- Has full workflow (research → draft → publish)
- Produces valuable output
- Different from experiments (prose vs code)

---

## Version History

| Version | Structure | Key Change |
|---------|-----------|------------|
| 1.0 | 7 ψ-* folders | Original |
| 2.0 | 3-tier (ephemeral/preserved/reference) | Tier concept |
| 3.0 | Active/Passive | Usage-based |
| 4.0 | ψ/ unified + resonance | Single root + soul |
| 5.0 | 5 pillars | writing/ + lab/ separated |

---

## For the Blog

**Title options**:
- "Designing AI's Brain: From Chaos to 5 Pillars"
- "ψ/ - A Unified Structure for AI Knowledge"
- "How We Engineered an AI Memory System"

**Key narrative**:
1. Problem: Too many folders, cognitive overload
2. Journey: 6 iterations of refinement
3. Solution: 5 pillars answering 5 questions
4. Insight: Co-creation with AI = better design

**Unique angle**:
- This structure was designed BY AI WITH human
- Each iteration came from natural conversation
- Thai language inputs drove design decisions
- "resonance" concept emerged organically

---

*Ready for expansion into full blog post*
