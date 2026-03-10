# Gemini 2.5 Pro Prompt: tmux for Beginners Tutorial

## Instructions for Gemini

สร้าง Google Slides presentation **10 slides** สำหรับสอน tmux พื้นฐาน สำหรับมือใหม่

**Event**: Workshop/Tutorial - tmux Basics
**Presenter**: Nat (Laris.co)
**Audience**: Developers, beginners (no tmux experience)
**Duration**: 15 นาที

---

## Design Specifications

```
Theme: Clean professional tutorial
Primary Color: #1e40af (Deep Blue - technology)
Secondary Color: #059669 (Green - success)
Accent Color: #dc2626 (Red - important)
Background: #ffffff (White - clean)
Font Thai: Sarabun
Font English: Inter
Font Size: VERY LARGE (readable from 5 meters)
Layout: ONE concept per slide
Visual: Screenshots + diagrams + code blocks
Code style: Dark theme with syntax highlighting
```

---

## SLIDE CONTENT

### SLIDE 1: Title
```
Title (massive, centered):
"tmux สำหรับมือใหม่"

Subtitle:
Terminal Multiplexer Tutorial
เริ่มต้นใช้งาน tmux อย่างง่าย

Visual: Clean terminal window graphic with tmux logo/icon
[IMAGE PLACEHOLDER: User will add tmux screenshot or logo]
```

---

### SLIDE 2: What is tmux?
```
Title: tmux คืออะไร?

Definition (large, clear):
tmux = Terminal Multiplexer

คือโปรแกรมที่ให้คุณ:
• เปิดหลาย terminal ในหน้าต่างเดียว
• แยก terminal เป็นหลายส่วน (panes)
• ทำงานต่อได้ แม้ disconnect
• ควบคุม terminal อื่นๆ ได้

Key benefit (highlighted):
เปิด terminal ครั้งเดียว → ใช้ได้หลายอย่าง!

Visual: Diagram showing one terminal window splitting into multiple panes
[IMAGE PLACEHOLDER: User will add diagram/screenshot of tmux split screen]
```

---

### SLIDE 3: Why Use tmux?
```
Title: ทำไมต้องใช้ tmux?

Benefits (3 big points):

1️⃣ Session Persistence
   ปิด terminal → งานยังทำต่อ
   ต่อกลับมาได้ทุกที่

2️⃣ Multi-Tasking
   เปิดหลาย terminal พร้อมกัน
   ไม่ต้องสลับหน้าต่าง

3️⃣ Remote Control
   ส่งคำสั่งไปยัง session อื่นได้
   → ทำให้ AI 2 ตัวคุยกันได้!

Visual: Three icons/illustrations showing each benefit
[IMAGE PLACEHOLDER: User will add benefit illustrations]
```

---

### SLIDE 4: Basic Concepts
```
Title: 3 Concepts สำคัญ

Hierarchy diagram (large, clear):

Session (วงใหญ่สุด)
  ↓
  └─ Window (วงกลาง)
       ↓
       └─ Pane (วงเล็ก)

Explanation:
• Session = งานหนึ่งๆ (เช่น "project-a")
• Window = แท็บในงานนั้น (เช่น "code", "test", "logs")
• Pane = แบ่งหน้าจอในแท็บ (เช่น ซ้าย-ขวา)

Example (bottom):
1 Session → 3 Windows → แต่ละ Window มี 2 Panes

Visual: Nested boxes showing Session > Window > Pane hierarchy
[IMAGE PLACEHOLDER: User will add hierarchy diagram]
```

---

### SLIDE 5: Essential Commands - Part 1
```
Title: คำสั่งพื้นฐาน (ต้องรู้!)

Command table (large, clear):

การทำงาน              คำสั่ง
─────────────────────────────────────
สร้าง session        tmux
สร้าง session + ตั้งชื่อ  tmux new -s myname
ดู session ทั้งหมด    tmux ls
เข้า session          tmux attach -t myname
ออกจาก session       Ctrl+b, d
ปิด session          exit (ในนั้น)

Pro tip (highlighted):
Ctrl+b = Prefix key (กดก่อนคำสั่งอื่นๆ)

Visual: Terminal showing these commands in action
[IMAGE PLACEHOLDER: User will add command examples screenshot]
```

---

### SLIDE 6: Essential Commands - Part 2
```
Title: คำสั่งเพิ่มเติม (ใช้บ่อย)

ใน tmux session กด Prefix (Ctrl+b) แล้วตาม:

แบ่งหน้าจอ:
% = แบ่งซ้าย-ขวา (vertical)
" = แบ่งบน-ล่าง (horizontal)

สลับ pane:
Arrow keys = เลือก pane
o = สลับ pane ถัดไป

Window:
c = สร้าง window ใหม่
n = window ถัดไป
p = window ก่อนหน้า
, = ตั้งชื่อ window

Visual: Keyboard graphic showing key combinations
[IMAGE PLACEHOLDER: User will add keyboard shortcut diagram]
```

---

### SLIDE 7: Creating Your First Session
```
Title: สร้าง Session แรก - ทีละขั้น

Step-by-step (numbered, large):

1️⃣ เปิด Terminal
   พิมพ์: tmux new -s workshop

2️⃣ คุณจะเห็น
   ✅ แถบสถานะด้านล่าง (สีเขียว)
   ✅ ชื่อ session "workshop"
   ✅ Terminal ใหม่พร้อมใช้!

3️⃣ ลองแบ่งหน้าจอ
   กด: Ctrl+b แล้วกด %
   → หน้าจอแบ่งซ้าย-ขวา

4️⃣ ลอง detach
   กด: Ctrl+b แล้วกด d
   → กลับมาที่ terminal เดิม

5️⃣ ต่อกลับ
   พิมพ์: tmux attach -t workshop

Code example (bottom):
tmux new -s workshop    # สร้าง
tmux attach -t workshop # กลับมา

Visual: Step-by-step screenshots showing progression
[IMAGE PLACEHOLDER: User will add tutorial screenshots]
```

---

### SLIDE 8: Sending Keys - Advanced Usage
```
Title: ส่งคำสั่งไปยัง Session อื่น

Why this matters (large):
คุณสามารถควบคุม tmux session อื่นได้!

Basic pattern:
tmux send-keys -t [session-name] "[command]" C-m

Real example (code block):
# ส่งคำสั่งไปยัง session "ai1"
tmux send-keys -t ai1 "echo สวัสดี" C-m

# C-m = กด Enter
# -t = target session

Use cases:
✅ Automation - รันคำสั่งอัตโนมัติ
✅ Multi-session control - ควบคุมหลาย session
✅ AI communication - ให้ AI คุยกัน!

Visual: Diagram showing command flow from one session to another
[IMAGE PLACEHOLDER: User will add send-keys flow diagram]
```

---

### SLIDE 9: Practical Example
```
Title: ตัวอย่างการใช้งานจริง

Scenario (large):
เปิด 2 sessions: หนึ่งเขียนโค้ด, อีกอันทดสอบ

Commands (step-by-step):
# Session 1: Development
tmux new -s dev
# เขียนโค้ดที่นี่

# Terminal ใหม่
# Session 2: Testing
tmux new -s test
# รันการทดสอบที่นี่

# ส่งคำสั่ง reload จาก session อื่น
tmux send-keys -t test "npm test" C-m

# สลับกลับไปกลับมา
tmux attach -t dev
tmux attach -t test

Benefit (highlighted):
ไม่ต้องสลับหน้าต่าง ควบคุมทั้งหมดจากที่เดียว!

Visual: Two-panel screenshot showing dev and test sessions
[IMAGE PLACEHOLDER: User will add real-world example screenshot]
```

---

### SLIDE 10: Quick Reference Card
```
Title: Quick Reference - ท่องจำเลย!

Two-column cheat sheet (large, clear):

พื้นฐาน                     คำสั่ง
────────────────────────────────────
สร้าง session              tmux new -s name
ดู sessions               tmux ls
เข้า session              tmux attach -t name
ออกจาก session            Ctrl+b, d

ใน session (Ctrl+b + ...)
────────────────────────────────────
แบ่งซ้าย-ขวา              %
แบ่งบน-ล่าง               "
สลับ pane                 Arrow keys
Window ใหม่               c
Window ถัดไป              n

ขั้นสูง
────────────────────────────────────
ส่งคำสั่ง                 send-keys -t name "cmd" C-m
จับภาพหน้าจอ             capture-pane -t name -p

Resource (bottom):
📖 Full guide: man tmux
🌐 Cheat sheet: tmuxcheatsheet.com

Visual: Print-friendly reference card layout
[IMAGE PLACEHOLDER: User will add cheat sheet graphic]
```

---

## Story Arc Summary

```
Intro → What/Why → Concepts → Commands → Practice → Advanced → Reference
```

| # | Slide | Purpose |
|---|-------|---------|
| 1 | Title | Introduction |
| 2 | What is tmux? | Definition & core concept |
| 3 | Why use tmux? | Benefits & motivation |
| 4 | Basic Concepts | Session/Window/Pane hierarchy |
| 5 | Commands Part 1 | Essential commands |
| 6 | Commands Part 2 | Additional shortcuts |
| 7 | First Session | Hands-on tutorial |
| 8 | Sending Keys | Advanced automation |
| 9 | Practical Example | Real-world usage |
| 10 | Quick Reference | Cheat sheet |

---

## Key Messages

1. **tmux = Terminal Multiplexer** - One terminal window, multiple sessions, persistent even after disconnect
2. **3 Levels: Session > Window > Pane** - Understand hierarchy to master tmux navigation and organization
3. **send-keys enables automation** - Control other sessions programmatically, foundation for AI communication

---

## Output Instructions for Gemini

1. สร้าง Google Slides **10 slides**
2. **ONE concept per slide** - ไม่ซับซ้อน เรียนรู้ทีละขั้น
3. ภาษาไทยเป็นหลัก, technical terms อังกฤษ
4. Font ใหญ่มาก อ่านจากไกล 5 เมตรได้
5. สี #1e40af (Blue) + #059669 (Green) + #dc2626 (Red)
6. Clean, beginner-friendly
7. Code blocks dark theme, large font
8. **[IMAGE PLACEHOLDER] marks** - User will add images later
9. NO: Overwhelming details, small text, too many commands at once
10. YES: Progressive learning, clear examples, practical focus

---

## Quick Summary for Gemini

```
Create 10-slide Google Slides presentation:
- Theme: #1e40af (Blue) + #059669 (Green) + #dc2626 (Red) on white
- Font: Sarabun (Thai), Inter (English), VERY LARGE
- Style: Clean beginner tutorial
- Audience: Complete tmux beginners
- Language: Thai primary, English technical
- Story: What is tmux → Why use it → Basic concepts → Commands → Practice → Advanced
- Key messages:
  • "tmux = Terminal Multiplexer สำหรับ multi-tasking"
  • "Session > Window > Pane - เข้าใจ hierarchy"
  • "send-keys ทำให้ควบคุม session อื่นได้"
- Include [IMAGE PLACEHOLDER] markers for user images
- Progressive learning: Start simple → Build up
- NO: Too much info at once, complex examples
- YES: One concept per slide, clear visuals, hands-on
```
