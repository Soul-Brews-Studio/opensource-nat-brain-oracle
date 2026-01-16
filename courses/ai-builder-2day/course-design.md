# AI Builder Workshop - 2 Days

> "จากปัญหาของคุณ สู่ Prototype ที่ใช้ได้จริง"

---

## Philosophy

```
ไม่ใช่สอน "วิธีใช้ AI"
แต่สอน "วิธีสร้างของด้วย AI"

ผู้เรียนมาพร้อมปัญหาจริงของตัวเอง
กลับไปพร้อม Prototype ที่ทำงานได้
และความสามารถที่จะทำต่อเอง
```

---

## Target Audience

| เหมาะกับ | ไม่เหมาะกับ |
|----------|------------|
| มีปัญหา/ไอเดียที่อยากแก้ | แค่อยากรู้ AI คืออะไร |
| พร้อมลงมือทำ | ต้องการแค่ฟัง lecture |
| ไม่ต้องเขียนโค้ดเป็น | คาดหวังเรียนรู้ programming |
| มี domain expertise | ต้องการเป็น AI engineer |

**ตัวอย่างผู้เรียนในอุดมคติ:**
- สถาปนิกที่อยากทำเครื่องมือคำนวณโหลดไฟฟ้า (เหมือนถิงถิง)
- เจ้าของร้านอาหารที่อยากทำระบบจัดการ inventory
- ครูที่อยากทำเครื่องมือตรวจการบ้าน
- นักวิจัยที่อยากวิเคราะห์ข้อมูลเร็วขึ้น

---

## Learning Outcomes

หลังจบ 2 วัน ผู้เรียนจะ:

1. **มี Working Prototype** - ของจริงที่ใช้ได้ ไม่ใช่แค่ตัวอย่าง
2. **ตั้งโปรเจ็คเองได้** - Setup repo, structure, deploy
3. **Get Context ได้** - รู้วิธีหาและจัดการ context
4. **Engineer the System ได้** - ออกแบบ workflow ที่เหมาะกับงาน
5. **ทำต่อเองได้** - ไม่ต้องพึ่ง instructor

---

## Pre-Workshop (1 สัปดาห์ก่อน)

### สิ่งที่ผู้เรียนต้องเตรียม

1. **ปัญหา/ไอเดีย 1 อย่าง** ที่อยากแก้
   - เขียนมา 3-5 บรรทัด
   - ตัวอย่าง: "อยากได้เว็บช่วยคำนวณโหลดไฟฟ้าจากแบบแปลน"

2. **ตัวอย่างข้อมูล** (ถ้ามี)
   - PDF, รูป, ไฟล์ที่เกี่ยวข้อง
   - ตัวอย่าง: แบบไฟฟ้า 2-3 แผ่น

3. **Laptop** + บัญชี GitHub

### Instructor เตรียม

- ติดตั้ง Claude Code ให้ทุกเครื่อง
- Review ปัญหาของแต่ละคนล่วงหน้า
- เตรียม fallback project สำหรับคนที่ไม่มีไอเดีย

---

# Day 1: Foundation

## "AI เป็นคู่คิด ไม่ใช่เครื่องมือ"

---

### Morning (9:00 - 12:00)

#### 9:00-9:30 | Opening: The New Way

**ไม่สอน:**
- AI คืออะไร
- LLM ทำงานยังไง
- Prompt engineering theory

**สอน:**
- Demo สด: จากปัญหา → Prototype ใน 15 นาที
- (ใช้ตัวอย่าง electrical calculator ที่ทำกับถิงถิง)

**Message:**
> "นี่คือสิ่งที่คุณจะทำได้ตอนจบวันที่ 2"

---

#### 9:30-10:30 | Hands-on 1: First Contact

**ทุกคนทำพร้อมกัน:**

```
1. เปิด Claude Code
2. พิมพ์ปัญหาของตัวเอง (ที่เตรียมมา)
3. ดู AI ตอบ
4. ถาม follow-up 2-3 รอบ
```

**เป้าหมาย:** รู้สึกว่า "มันคุยรู้เรื่อง"

**Instructor สังเกต:**
- ใครติด → ช่วย
- ใครไปได้ → ปล่อย
- จด pattern ที่เห็น

---

#### 10:30-10:45 | Break

---

#### 10:45-11:30 | Concept: Context is Everything

**สอน 3 เรื่อง:**

1. **Context Window** - AI จำได้แค่ในบทสนทนา
2. **Good Input = Good Output** - ยิ่งให้ข้อมูลดี ยิ่งได้คำตอบดี
3. **Iteration** - ไม่ต้องถูกตั้งแต่ครั้งแรก

**Demo:**
- ถามแบบไม่มี context → ได้คำตอบกว้าง
- ถามแบบมี context (upload file, ให้ตัวอย่าง) → ได้คำตอบเฉพาะ

**Activity:**
- ทุกคน upload ไฟล์ตัวอย่างของตัวเอง
- ถาม AI เกี่ยวกับไฟล์นั้น
- สังเกตความแตกต่าง

---

#### 11:30-12:00 | Hands-on 2: Define Your Project

**Template ที่ทุกคนกรอก:**

```markdown
## My Project

**ปัญหา:** [1-2 ประโยค]

**ใครใช้:** [target user]

**Input:** [อะไรเข้า]

**Output:** [อะไรออก]

**ตัวอย่าง:**
- Input: [ตัวอย่างจริง]
- Output ที่อยากได้: [อธิบาย]
```

**AI ช่วยทำ:**
- Review และถามคำถาม clarify
- แนะนำ scope ที่เหมาะกับ 2 วัน

---

### Lunch (12:00-13:00)

---

### Afternoon (13:00-17:00)

#### 13:00-14:30 | Build Session 1: MVP

**เป้าหมาย:** ได้ version แรกที่ทำงานได้

**Flow:**
```
1. Instructor demo การสร้าง project ใหม่ (10 min)
2. ทุกคนทำตาม กับ project ของตัวเอง (20 min)
3. AI ช่วย generate code/structure (30 min)
4. Run และดูผล (20 min)
5. แชร์ปัญหา/ถาม (10 min)
```

**Instructor role:**
- เดินดู ช่วยคนติด
- ไม่ต้องสอน เน้นให้ทำ
- ถ้าติดมาก → pair กับคนที่ไปได้

---

#### 14:30-14:45 | Break

---

#### 14:45-16:00 | Build Session 2: Iterate

**เป้าหมาย:** ปรับปรุง MVP จาก feedback

**Flow:**
```
1. Test กับ input จริง
2. หา bug / สิ่งที่ขาด
3. บอก AI ให้แก้
4. Test อีกรอบ
5. Repeat
```

**Key Teaching:**
> "Development คือ loop: Build → Test → Fix → Repeat"
> "AI ทำให้ loop นี้เร็วมาก"

---

#### 16:00-16:30 | Show & Tell

**ทุกคนแชร์ (2-3 นาที/คน):**
- ทำอะไร
- ได้อะไร
- ติดตรงไหน

**Instructor:**
- Celebrate wins
- Note common problems สำหรับวันพรุ่งนี้

---

#### 16:30-17:00 | Day 1 Wrap

**สรุป:**
- วันนี้ได้อะไร
- พรุ่งนี้จะทำอะไร

**Homework (optional):**
- ทดลองใช้ต่อที่บ้าน
- จดสิ่งที่อยากทำเพิ่ม

---

# Day 2: Independence

## "ไม่ใช่แค่ใช้ แต่เป็นเจ้าของระบบ"

---

### Morning (9:00 - 12:00)

#### 9:00-9:30 | Review & Reset

**ถามรอบห้อง:**
- ทำอะไรต่อที่บ้าน?
- เจออะไรใหม่?
- ติดอะไร?

**Reframe:**
> "วันนี้เราจะเปลี่ยนจาก 'ผู้ใช้' เป็น 'ผู้สร้างระบบ'"

---

#### 9:30-10:30 | Concept: System Engineering

**สอน 4 เรื่อง:**

1. **Project Structure**
   - ทำไมต้องมี folder structure
   - Git basics (commit, push)
   - GitHub as backup + share

2. **Context Management**
   - CLAUDE.md / instructions
   - ทำไม AI ลืม → วิธีให้จำ
   - Handoff / notes

3. **Workflow Design**
   - Input → Process → Output
   - Where does AI help?
   - Where do humans decide?

4. **Iteration Patterns**
   - MVP → Test → Improve
   - When to stop

**Demo:**
- แสดง Nat-s-Agents structure
- แสดง /recap, /trace, Oracle
- อธิบายว่า "นี่คือวิธีที่ผมทำงานกับ AI"

---

#### 10:30-10:45 | Break

---

#### 10:45-12:00 | Hands-on 3: Structure Your Project

**ทุกคนทำ:**

```
1. สร้าง GitHub repo (private)
2. สร้าง folder structure
3. เขียน README.md
4. สร้าง docs/plan.md
5. Commit & push
```

**AI ช่วย:**
- Generate structure
- Write documentation
- Explain git commands

**เป้าหมาย:**
- ทุกคนมี repo ของตัวเอง
- มี plan ชัดเจน
- รู้วิธี commit/push

---

### Lunch (12:00-13:00)

---

### Afternoon (13:00-17:00)

#### 13:00-15:00 | Build Session 3: Complete MVP

**เป้าหมาย:** Finish what you started

**Instructor:**
- ช่วยคนที่ติด
- Pair programming ถ้าจำเป็น
- ไม่สอนใหม่ เน้นให้ทำเสร็จ

**ถ้าเสร็จเร็ว:**
- เพิ่ม feature
- ทำ documentation
- ช่วยเพื่อนที่ยังไม่เสร็จ

---

#### 15:00-15:15 | Break

---

#### 15:15-16:15 | Demo Day

**ทุกคน present (5 นาที/คน):**

1. **ปัญหาที่แก้** (30 sec)
2. **Demo ของจริง** (2 min)
3. **สิ่งที่เรียนรู้** (1 min)
4. **Next steps** (30 sec)
5. **Q&A** (1 min)

**Instructor:**
- ถ่ายวิดีโอ (ให้ผู้เรียนเก็บ)
- Celebrate ทุกคน
- Note patterns

---

#### 16:15-17:00 | Closing: The Journey Continues

**สรุป:**

1. **What you built** - ทุกคนมี prototype
2. **What you learned** - ไม่ใช่แค่ tool แต่เป็น mindset
3. **What's next** - ทำต่อยังไง

**แจก:**
- Resource list (links, docs)
- Community access (Discord/Line group)
- Follow-up support (optional)

**Message:**
> "AI ไม่ได้มาแทนคุณ มันมาช่วยให้คุณทำในสิ่งที่เคยทำไม่ได้
> ตอนนี้คุณมี skill ที่จะสร้างอะไรก็ได้
> ไปสร้างมันเถอะ"

---

## Materials Needed

### For Instructor

| Item | Purpose |
|------|---------|
| Slides (minimal) | Day 1 opening, Day 2 concepts only |
| Demo project | Electrical calculator example |
| Troubleshooting guide | Common problems + solutions |
| Backup projects | For people without ideas |

### For Students

| Item | When |
|------|------|
| Problem statement | Pre-workshop |
| Sample data | Pre-workshop |
| Laptop + GitHub | Day 1 |
| Their project repo | Day 2 |

---

## Class Size

| Size | Pros | Cons |
|------|------|------|
| 5-8 | Personal attention | Less diversity |
| 10-15 | Good energy | Some may fall behind |
| 15+ | Need TA | Hard to help everyone |

**Recommended:** 8-12 with 1 TA

---

## Pricing Consideration

**Value delivered:**
- Working prototype (normally costs ฿50,000-200,000 to build)
- Skills to build more
- Community access

**Suggested range:** ฿15,000-25,000 / person / 2 days

---

## Success Metrics

| Metric | Target |
|--------|--------|
| Completion rate | 90%+ have working prototype |
| NPS | 8+ |
| Continue building | 50%+ continue after 1 week |
| Referral | 30%+ refer others |

---

## Post-Workshop

1. **Week 1:** Check-in message
2. **Week 2:** Office hours (optional, paid)
3. **Month 1:** Survey + showcase
4. **Ongoing:** Community support

---

## Key Principles

1. **Learn by doing** - ไม่มี lecture ยาว
2. **Real problems** - ไม่ใช่ตัวอย่างสมมติ
3. **Finish something** - ต้องได้ของจริง
4. **Independence** - ต้องทำต่อเองได้
5. **Community** - ไม่ใช่จบแล้วจบเลย

---

*Designed: 2026-01-04*
*Based on: Tingting session - from idea to MVP in 15 min*
