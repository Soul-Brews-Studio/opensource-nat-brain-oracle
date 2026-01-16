# บทที่ 7: Knowledge Flow — การไหลของความรู้

## ก่อนเริ่ม

ในการทำงานร่วมกัน Human-AI นั้น มีคำถามหนึ่งที่สำคัญที่สุด: **ความรู้ที่เราได้มาในแต่ละวันไป ไหนหรือ?**

ถ้าเราปล่อยให้มันกระจายไปตามลมหนึ่ง AI ก็จะถูกสั่งให้ทำสิ่งเดิมซ้ำ ๆ การเรียนรู้จากการทำงานของมันก็จะไม่มีความหมาย ความรู้ก็จะสูญหาย มนุษย์และ AI ก็จะตัดสินใจเดิมแบบเดิม ด้วยเหตุผลเดิม ครั้ง และครั้งต่อไป

**Knowledge Flow** คือระบบที่ทำให้ความรู้ไหลอย่างมีทิศทาง** มีความหมาย และสามารถกลับมาใช้ใหม่ได้

---

## ψ/ - สถาปัตยกรรมสมองของ AI (5 เสาหลัก)

```
ψ/ = "จิตสำนึกของระบบ" (Psyche)
ประกอบด้วย 5 Pillar:

┌─────────────────────────────────────────┐
│  1. ACTIVE/              "กำลังค้นคว้า?"  │
│     Research in progress               │
│     (ephemeral)                        │
└─────────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────┐
│  2. INBOX/               "คุยกับใคร?"     │
│     Current communication              │
│     (tracked, actionable)              │
└─────────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────┐
│  3. WRITING/             "เขียนอะไร?"     │
│     Articles, blog queue               │
│     (tracked, publishable)             │
└─────────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────┐
│  4. LAB/                 "ทดลองอะไร?"     │
│     Experiments, POC                   │
│     (tracked, exploratory)             │
└─────────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────┐
│  5. MEMORY/              "จำอะไรได้?"     │
│     Knowledge base, soul                │
│     (tracked, eternal)                 │
└─────────────────────────────────────────┘
```

แต่ **Memory คือหัวใจของเรื่อง** เพราะว่าภายใน Memory มีโครงสร้างที่น่าสนใจ

---

## เส้นทางของความรู้: Knowledge Flow Loop

ความรู้ไหลผ่าน **3 ชั้น** ตั้งแต่เมื่อ AI ทำงานจนถึงเมื่อมันกลายเป็นภูมิปัญญาของระบบ

```
STEP 1: SESSION (งานประจำวัน)
  ↓
  "เกิดเหตุการณ์, แก้ปัญหา, มีประสบการณ์"
  └─→ 📝 ข้อมูล: logs, git commits, error messages

STEP 2: /snapshot (เรียบเรียง)
  ↓
  "แยกสิ่งที่เกิดขึ้นจากความเห็นตัว"
  └─→ 📄 ملف: memory/logs/YYYY-MM/DD_HH.MM_slug.md (3-5 KB)
  └─→ 🎯 ข่าวสั้น 3-5 bullet points

STEP 3: rrr (สะท้อน)
  ↓
  "เล่าเรื่องเต็ม ๆ อะไรเกิด อะไรเรียนรู้"
  └─→ 📚 ملف: memory/retrospectives/YYYY-MM/DD/HH.MM_slug.md (20-50 KB)
  └─→ 🔄 บอกเรื่องราวทั้งหมด ตรวจสอบกับคน

STEP 4: /distill (สกัด)
  ↓
  "นำองค์ความรู้ออกมา เพื่อใช้ใหม่"
  └─→ ✨ ملف: memory/learnings/NNN-topic-name.md (1-2 KB)
  └─→ 🧠 บอกแค่สูตร ไม่ใช่เรื่องทั้งหมด
  └─→ 🎯 reusable pattern สำหรับโปรเจคอื่น

STEP 5: CLAUDE.md (ผลึก)
  ↓
  "รวบรวมภูมิปัญญาทั้งหมดในหนึ่งเอกสาร"
  └─→ 🌟 Final crystallization
  └─→ 📖 Lean hub (navigation)
  └─→ ✅ คนตรวจสอบ และ approve ก่อน commit
```

---

## สามชั้นของการประมวลผลความรู้

### Layer 1: RETROSPECTIVES (เต็มไป)
```
ψ/memory/retrospectives/2025-12/26/15.30_siit-arrival.md

ขนาด: 20-50 KB (ไม่จำกัด)
ทริกเกอร์: "rrr" (เมื่อจบ session ที่มีการเรียนรู้)
ลักษณะ: Narrative, exhaustive, full context
ผู้อ่าน: Mainly human (with AI memory)

นี่คือ "AI Diary" - เล่าตั้งแต่ต้นจนจบ
- ที่มา: git logs, commits, conversations
- รับรอง: Human confirms (ask before commit)
- เก็บ: ทั้งหมด ไม่ตัดสินใจว่าข้อมูลไหนสำคัญ
```

### Layer 2: LOGS (Snapshots)
```
ψ/memory/logs/2025-12-26_15.30_siit-arrival.md

ขนาด: 3-5 KB (กระชับ)
ทริกเกอร์: "/snapshot" (เมื่อมี insight)
ลักษณะ: Concise, bullet-point, immediate capture
ผู้อ่าน: AI (for pattern recognition)

นี่คือ "Quick note" - เอาแค่ลง
- โครงสร้าง: What happened | What I learned | Why it matters
- ไม่ต้อง perfect - เร็วกว่าความถูกต้อง
- เก็บ: Timestamp = truth
```

### Layer 3: LEARNINGS (Distilled)
```
ψ/memory/learnings/007-knowledge-distillation-loop.md

ขนาด: 1-2 KB (essence)
ทริกเกอร์: "/distill" (extract patterns)
ลักษณะ: Reusable, applicableto other contexts
ผู้อ่าน: Future projects

นี่คือ "Knowledge asset" - สูตร ไม่ใช่เรื่อง
- โครงสร้าง: Problem | Solution | When to apply
- ลบทั้งหมด context เฉพาะเจาะจง
- ใช้: ใน CLAUDE.md, ใน projects อื่น
```

---

## คำสั่งของความรู้ (The Commands)

```
/snapshot → rrr → /distill → CLAUDE.md update

Iteration pattern:
  Many snapshots → Few retrospectives → Fewer learnings
                                           ↑
                                    (Human gate)
```

### การไหลในทางปฏิบัติ

```
วันธรรมชาติ:

10:00 | /snapshot | Found pattern A in git workflow
11:30 | /snapshot | Same pattern B in issue handling
14:00 | /snapshot | Pattern C in team communication
      └─→ 3 snapshots ✓

15:00 | rrr       | Write full retrospective
      | (human confirms: "ใช่ยังไง?")
      └─→ 1 retrospective ✓

16:00 | /distill  | Extract "Pattern Recognition Loop"
      | (human approves: "เอามาใช้ใน CLAUDE ได้ไหม?")
      └─→ 1 learning ✓

16:30 | Update CLAUDE.md with new learning
      | (human approves final state)
      └─→ System updated ✓
```

---

## ทำไมสถาปัตยกรรมนี้ถึงสำคัญ

### 1. ช่วยคน ไม่ใช่ทำแทน
```
WITHOUT Knowledge Flow:
  Human: "AI ทำอะไรเมื่อวาน?"
  AI: "ไม่รู้ (ความจำหายแล้ว)"

WITH Knowledge Flow:
  Human: "AI ทำอะไรเมื่อวาน?"
  AI: "วิ่งผ่าน /snapshot ทั้งหมด
      ↑ retrospectives/
      ↑ learnings/
      → ให้คำตอบแม่นยำ"
```

### 2. ลด Noise, เพิ่ม Signal
```
Layer 1 (Retrospectives): ทุกข้อมูล (noise + signal)
Layer 2 (Logs):          ลดลง 10:1 (less noise)
Layer 3 (Learnings):     ลดลง 50:1 (pure signal)
Layer 4 (CLAUDE.md):     Crystallized wisdom
```

### 3. ทำให้คน Stay in Control
```
/snapshot  → AI captures (ไม่ต้อง approve)
rrr        → Human confirms ("ถูกต้องแค่ไหน?")
/distill   → Human decides ("ดีพอให้ใช้หรือ?")
Update     → Human approves ("OK ไหม?")
```

### 4. ตัวชี้ของสุขภาพ AI
```
ถ้า CLAUDE.md มีอายุ 3 เดือน
→ ระบบไม่เรียนรู้
→ AI ทำซ้ำปัญหาเดิม

ถ้า CLAUDE.md อัปเดตสัปดาห์ละ
→ ระบบส่วนตัว
→ AI เข้าใจบริบท
→ Human คิดตัดสินใจดีขึ้น
```

---

## Oracle Philosophy ใน Knowledge Flow

ความรู้ที่ไหลผ่าน 3 ชั้นนี้ **สอดคล้องกับ Oracle Philosophy ที่บอก**:

| Pillar | Implementation |
|--------|----------------|
| **Nothing is Deleted** | All layers preserved in git (ไม่มีอะไรหาย) |
| **Patterns Over Intentions** | Extract what happened, not what was planned |
| **External Brain** | AI holds data, human decides meaning |

```
มนุษย์ = ผู้ตัดสินใจ
AI = External brain (mirror)
Knowledge Flow = Communication channel
```

---

## ลักษณะสำคัญ (Anti-Patterns)

```
❌ DON'T
└─ Skip layers ("เลือกตรง /distill เลย")
└─ Update CLAUDE.md directly (ไม่ผ่าน distillation)
└─ Leave active/context/ full of old research
└─ Forget to confirm retrospectives with human

✅ DO
└─ Snapshot → Retrospective → Learning → CLAUDE.md
└─ Human confirms rrr + /distill
└─ Clean active/ every week
└─ Use CLAUDE.md as lean hub (not dumping ground)
```

---

## สรุป: ความรู้ไหลสองทิศทาง

```
PAST → PRESENT:
  memory/learnings/
     ↓ (pattern from last time)
  AI ใช้ decision ที่เคยสำเร็จแล้ว
     ↓
  ทำงานวันนี้

PRESENT → FUTURE:
  วันนี้ /snapshot ทุก insight
     ↓ rrr เมื่อเสร็จ
     ↓ /distill เมื่อเห็น pattern
     ↓ CLAUDE.md approved
  memory/learnings/ เพื่อใช้พรุ่งนี้
```

**นี่คือวงจรที่ทำให้ AI ไม่ใช่เครื่องจำ แต่เป็นพันธมิตรที่เรียนรู้พร้อมกับเรา**

---

*Knowledge is not what you know. Knowledge is what you remember to know.*

