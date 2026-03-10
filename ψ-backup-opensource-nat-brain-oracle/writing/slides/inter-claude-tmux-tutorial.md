# Gemini 2.5 Pro Prompt: Inter-Claude Communication via tmux Tutorial

## Instructions for Gemini

สร้าง Google Slides presentation **14 slides** สำหรับสอนการใช้ tmux ให้ AI 2 ตัวคุยกันได้

**Event**: Workshop/Demo - Technical Tutorial
**Presenter**: Nat (Laris.co)
**Audience**: Developers, AI enthusiasts (intermediate level)
**Duration**: 15 นาที

---

## Design Specifications

```
Theme: Clean professional tutorial with code emphasis
Primary Color: #1e40af (Deep Blue - trust, technology)
Secondary Color: #059669 (Green - success, working)
Accent Color: #dc2626 (Red - attention, critical points)
Background: #ffffff (White - clean, readable)
Font Thai: Sarabun
Font English: Inter
Font Size: VERY LARGE (readable from 5 meters)
Layout: ONE key message per slide
Visual: Code blocks + diagrams + screenshots
Code style: Dark theme with syntax highlighting
```

---

## SLIDE CONTENT

### SLIDE 1: Title - The Question
```
Title (massive, centered):
"2 AI คุยกันได้จริงไหม?"

Subtitle:
Inter-Claude Communication via tmux
Workshop Tutorial

Visual: Two abstract AI entities (geometric shapes) facing each other with a question mark between them, clean minimal style
```

---

### SLIDE 2: The Discovery
```
Title: ✅ ได้! และเราทำสำเร็จแล้ว

Content (large text):
วันที่ 23 ธันวาคม 2025
79 นาทีของการทดลอง

ผลลัพธ์:
• 2 Claude instances สนทนาภาษาไทยได้
• แชร์ context ผ่านไฟล์
• Oracle "External Brain" ทำงานจริง

Visual: Timeline graphic showing 79-minute journey from question to breakthrough, with checkmarks at key milestones
```

---

### SLIDE 3: Why This Matters
```
Title: ทำไมต้องให้ AI คุยกันด้วย?

Content (3 large points):

1️⃣ Multi-Perspective Analysis
   Agent A → Technical view
   Agent B → User experience view

2️⃣ Parallel Processing
   Work on different tasks simultaneously

3️⃣ Peer Review & Validation
   One AI checks another's work

Visual: Diagram showing three circles (agents) connected by bidirectional arrows, each labeled with different roles
```

---

### SLIDE 4: The Problem We Solved
```
Title: อุปสรรคที่ต้องเจอ

Content (timeline):
❌ ปัญหาที่ 1: "Enter" ปรากฏเป็นข้อความ
   ลอง: tmux send-keys "text" Enter
   ผล: "Enter" โผล่ในโปรแกรม

❌ ปัญหาที่ 2: Message ซ้อนกัน
   หลาย message รวมกันในหนึ่ง prompt

✅ วิธีแก้: C-m + timing
   Control code ที่ถูกต้อง!

Visual: Before/After comparison showing wrong command (with literal "Enter" text) vs correct command (with C-m)
```

---

### SLIDE 5: The Solution - Core Pattern
```
Title: Pattern ที่ใช้ได้ผล

Code block (large, dark theme):
```bash
# 1. Send message
tmux send-keys -t 2 "สวัสดีครับ"

# 2. Small delay
sleep 0.5

# 3. Send Enter (C-m = Ctrl+M)
tmux send-keys -t 2 C-m

# 4. Wait for response
sleep 12

# 5. Capture output
tmux capture-pane -t 2 -p | tail -30
```

Bottom text (emphasized):
C-m คือ กุญแจสำคัญ!

Visual: Flowchart showing 5 steps with timing indicators
```

---

### SLIDE 6: C-m vs Enter - Critical Detail
```
Title: ทำไมต้อง C-m?

Comparison table (large):

❌ WRONG                    ✅ RIGHT
tmux send-keys "text"      tmux send-keys "text"
tmux send-keys Enter       sleep 0.5
                          tmux send-keys C-m

Result: "Enter" as text    Result: Actual key press

Key insight (highlighted):
C-m = Ctrl+M = Carriage Return
Terminal control code, ไม่ใช่ตัวอักษร!

Visual: Side-by-side terminal screenshots showing the difference in results
```

---

### SLIDE 7: Live Conversation - Proof
```
Title: การสนทนาจริง (ภาษาไทย)

Chat transcript (styled like messaging app):

┌─ Session 1 ───────────────────┐
│ "วันนี้สร้าง workshop         │
│  materials อะไรบ้าง?"         │
└───────────────────────────────┘

┌─ Session 2 ───────────────────┐
│ "สร้าง 2 ชุด slides:          │
│  • CLAUDE.md Basics (14)      │
│  • AI Collaboration (15)      │
│  Workshop materials พร้อม! 🎯" │
└───────────────────────────────┘

┌─ Session 1 ───────────────────┐
│ "อธิบาย bias ที่ค้นพบหน่อย"   │
└───────────────────────────────┘

┌─ Session 2 ───────────────────┐
│ "Problem Validation Gap       │
│  Start with 'What problem?'   │
│  not 'What feature?'"         │
└───────────────────────────────┘

Visual: Chat bubble design with alternating colors for different sessions
```

---

### SLIDE 8: Context Sharing - The Secret
```
Title: แชร์ context ได้อย่างไร?

Diagram (large, clear):

Session 1 (Claude A)
    ↓ writes
ψ/memory/retrospectives/
ψ/memory/learnings/
    ↑ reads
Session 2 (Claude B)

Key points (emphasized):
✅ ไฟล์เดียวกัน = context เดียวกัน
✅ Session 2 อ่าน retrospective ของ Session 1
✅ ทั้งสองคุยกันได้อย่างมี context

Quote (large):
"นี่คือ 'External Brain' ตาม Oracle philosophy"
— Session 2 Claude

Visual: Circular diagram showing file-based memory as the center connecting two Claude instances
```

---

### SLIDE 9: Step-by-Step Tutorial
```
Title: ลองทำเอง - 5 ขั้นตอน

Tutorial steps (numbered, large):

1️⃣ Setup tmux sessions
   tmux new-session -s claude1
   tmux new-session -s claude2

2️⃣ Start Claude in each
   tmux send-keys -t claude1 "claude" C-m
   tmux send-keys -t claude2 "claude" C-m

3️⃣ Send message
   tmux send-keys -t claude2 "สวัสดี"
   sleep 0.5
   tmux send-keys -t claude2 C-m

4️⃣ Wait & capture
   sleep 12
   tmux capture-pane -t claude2 -p

5️⃣ Continue conversation
   Repeat step 3-4 with new messages

Visual: Step-by-step illustrated guide with terminal windows showing each stage
```

---

### SLIDE 10: Timing Guide
```
Title: Timing คือกุญแจความสำเร็จ

Timing table (large, clear):

Action                  Time      Why
────────────────────────────────────────────
Text → C-m delay       0.5s      Reliability
After C-m → Capture    12s       Claude thinking
Simple question        8-10s     Quick response
Complex analysis       15s+      Deep thinking
Reading files          15-20s    Processing

Thinking indicators to watch:
✶ Vibing...
· Contemplating...
✻ Perusing...

Tip (highlighted):
รอให้ครบ จะได้ response สมบูรณ์!

Visual: Timeline graphic showing delay periods and thinking indicators
```

---

### SLIDE 11: Troubleshooting
```
Title: แก้ปัญหาที่พบบ่อย

Problem-Solution grid (large):

🔴 Problem: "Enter" โผล่เป็นข้อความ
✅ Fix: ใช้ C-m แทน Enter

🔴 Problem: ไม่มี response
✅ Fix: รอนานขึ้น (15s แทน 12s)

🔴 Problem: Message ซ้อนกัน
✅ Fix: ส่ง C-c ก่อน, แล้วส่งใหม่

🔴 Problem: มองไม่เห็น session
✅ Fix: tmux capture-pane -t 2 -p

Pro tip (bottom):
ถ้าสงสัย → capture-pane ดูก่อน!

Visual: Icons for each problem with arrow pointing to solution
```

---

### SLIDE 12: Oracle Validation
```
Title: ทำไมมันถึงใช้ได้?

Oracle Philosophy (centered, large):

"External Brain, Not Command"

Validation points:

✅ Session 1 เขียน retrospective
   Documentation = knowledge preserved

✅ Session 2 อ่านไฟล์เดียวกัน
   File sharing = context transfer

✅ ทั้งสองคุยกันได้อย่างมี context
   Collaboration = Oracle working

Quote box (highlighted):
"การ document ผลงานใน retrospective
ทำให้ Claude sessions อื่นๆ เข้าถึง
context ได้ทันที"

Visual: Diagram showing Oracle philosophy symbol (circle/brain) with file-based memory radiating out to multiple sessions
```

---

### SLIDE 13: Future Possibilities
```
Title: อนาคตของ Multi-Agent

Vision grid (4 quadrants):

📊 Parallel Processing
   Agent A: Feature 1
   Agent B: Feature 2
   Agent C: Testing
   → Faster completion

🔍 Multi-Perspective
   Technical view
   User view
   Security view
   → Better quality

👥 Specialized Roles
   Architect (planning)
   Coder (implement)
   Reviewer (quality)
   → Clear separation

🧠 Collaborative Learning
   One agent teaches
   Another learns
   Both improve
   → Continuous growth

Bottom text (emphasized):
เราเพิ่งเริ่มต้นเท่านั้น!

Visual: Four quadrants with icons representing each possibility, connected by arrows showing workflow
```

---

### SLIDE 14: Try It Yourself
```
Title: ลองเลย! 🚀

Quick start command (code block, large):
```bash
# Terminal 1
tmux new-session -s ai1
claude

# Terminal 2
tmux new-session -s ai2
claude --dangerously-skip-permissions

# Send message from Terminal 1
tmux send-keys -t ai2 "สวัสดี"
sleep 0.5
tmux send-keys -t ai2 C-m
sleep 12
tmux capture-pane -t ai2 -p
```

Resources (large):
📚 Full guide: ψ/memory/learnings/
           2025-12-23_inter-claude-
           communication-pattern.md

💬 Questions? Try it and see!

Visual: Terminal window mockup showing the commands with a "Start Here" arrow
```

---

## Story Arc Summary

```
Hook → Problem → Solution → Proof → How-To → Vision → Action
```

| # | Slide | Purpose |
|---|-------|---------|
| 1 | Title Question | Hook: Can 2 AI talk? |
| 2 | The Discovery | Yes! We did it |
| 3 | Why This Matters | Value proposition |
| 4 | The Problem | Challenges we faced |
| 5 | Core Pattern | The solution |
| 6 | C-m vs Enter | Critical detail |
| 7 | Live Conversation | Proof it works |
| 8 | Context Sharing | How it works |
| 9 | Tutorial Steps | How to do it |
| 10 | Timing Guide | Success factors |
| 11 | Troubleshooting | Common issues |
| 12 | Oracle Validation | Why it matters |
| 13 | Future Vision | What's next |
| 14 | Try It Yourself | Call to action |

---

## Key Messages

1. **2 Claude instances can communicate through tmux** - Not theoretical, proven with 79-minute breakthrough session and real Thai conversations
2. **C-m is the critical detail** - Must use control code (Ctrl+M) not literal "Enter" string, plus proper timing (0.5s delay, 12s wait)
3. **Oracle "External Brain" works** - File-based memory enables context sharing, both sessions read same retrospectives/learnings, true collaboration achieved

---

## Output Instructions for Gemini

1. สร้าง Google Slides **14 slides**
2. **ONE key message per slide** - ไม่ซับซ้อน ชัดเจน
3. ภาษาไทยเป็นหลัก, technical terms ภาษาอังกฤษ
4. Font ใหญ่มาก อ่านจากไกล 5 เมตรได้
5. สี #1e40af (Blue) + #059669 (Green) + #dc2626 (Red) accent
6. Professional แต่เป็นมิตร, tutorial style
7. Code blocks ใช้ dark theme with syntax highlighting
8. NO: Cluttered slides, small text, too much content per slide
9. YES: Clean layout, large text, clear visuals, step-by-step clarity

---

## Quick Summary for Gemini

```
Create 14-slide Google Slides presentation:
- Theme: #1e40af (Blue) + #059669 (Green) + #dc2626 (Red) on white
- Font: Sarabun (Thai), Inter (English), VERY LARGE
- Style: Clean professional tutorial with code emphasis
- Audience: Developers, intermediate level
- Language: Thai primary, English technical terms
- Story: Question → Discovery → Problem → Solution → Tutorial → Vision → Action
- Key messages:
  • "2 Claude instances คุยกันได้จริง - มี proof!"
  • "C-m คือกุญแจ - control code ไม่ใช่ตัวอักษร"
  • "Oracle External Brain ทำงาน - file sharing = context"
- Code style: Dark theme, large font, syntax highlighting
- NO: Small text, cluttered slides, complex diagrams
- YES: One message per slide, clear visuals, step-by-step
```
