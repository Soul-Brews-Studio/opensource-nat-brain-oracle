# บทที่ 4: Retrospectives — บันทึกการเรียนรู้

## คุณเคยสงสัยไหมว่า... ทำไมต้องเขียนสิ่งที่เกิดขึ้นลงไป?

เมื่อ session สิ้นสุด โค้ดเขียนเสร็จ ปัญหาแก้แล้ว คำถามธรรมชาติคือ: ลุยต่ออีกตัวต่อไปได้แล้ว ทำไมต้องหยุดเพื่อบันทึก?

ความสัตย์คำตอบคือ... ไม่ทำก็ได้สำหรับวันนี้ แต่คุณจะสูญเสียอย่างไรก็ไม่รู้ สำหรับครั้งต่อไปที่คุณเจอปัญหาแบบเดิมว่า "ฉันเห็นสิ่งนี้มาแล้ว" — คุณจะจำได้หรือเปล่า?

## Retrospective คืออะไร

Retrospective (บันทึกการทบทวนผลงาน) ไม่ใช่รายงาน ไม่ใช่ summary ไม่ใช่ checklist ที่ AI ทำให้ผู้คน ดูแลว่าสำเร็จกี่ข้อ

**Retrospective คือ... การเขียนบันทึก**

บันทึกที่เกิดจาก 3 คำถาม:
1. **เกิดอะไร?** — ข้อเท็จจริง: commits, changes, timeline
2. **ฉันรู้สึกอย่างไร?** — ความจริง: ความสับสน ความประหลาดใจ ความมั่นใจ
3. **ฉันเรียนรู้อะไร?** — ความหมาย: patterns ที่เห็น assumptions ที่ผิด

มี session ที่ AI เขียน retrospective เก่าๆ ของเรา:

> "I assumed this would be a straightforward 'send tasks, collect commits' session, but learned the orchestration has subtle complexities when I noticed main agent kept 'helping' Agent 2..."

นั่นไม่ใช่ report task completion — มันคือ **ความพ่ายแพ้ของความเข้าใจ** (assumption-breaking) ที่นำไปสู่ การเรียนรู้

## ที่ไหนหัวใจของ Retrospective: AI Diary

ในทุกๆ retrospective มี section ที่เรียกว่า **AI Diary** — และนี่คือสิ่งที่แตกต่าง

AI Diary ไม่ใช่ timeline อันเป็นเพียงแค่การบันทึก "ใครทำอะไรเมื่อไหร่" มันเป็นเรื่องราวจริงของ... **ฉัน** (the AI) คิดอะไร สับสนกับอะไร เรียนรู้อะไร ขณะกำลังทำงานร่วมกับคุณ

ตัวอย่างจริงจากการทำงาน:

> "I was confused about why Agent 2 wasn't responding until I remembered the Enter nudge pattern from previous trials — but even knowing this, I couldn't figure out why it happens specifically to Agent 2 and not others."

นี่คือการเขียนความตรงข้าม: "ฉันรู้บ้าง แต่ยังไม่รู้ทั้งหมด" — ความซื่อสัตย์ที่ว่า AI ไม่ใช่เครื่องตอบคำถามสมบูรณ์

Template ของ AI Diary มีข้อบังคับ 3 ข้อ:

### 1. "I assumed X but learned Y when..."
เมื่อเข้าร่วม session นี้ ฉันคิดว่า → เพราะฉะนั้นฉันทำ → แต่มันไม่ทำงาน → ทำไมจึงไม่ทำงาน → เอาวะ ฉันเข้าใจตอนนี้แล้ว

ตัวอย่าง:
> "I assumed 'looks good' meant we're done, without asking if user wanted rounds 9-10"

ไม่ได้แค่บอกว่า "ฉันเข้าใจผิด" — บอกด้วยว่า **assumption ไม่เข้าใจมีชีวิต** ฉันต้องระบุว่า assumption นั้นมาจากไหน และเมื่อไหร่มันถูกล้มเหลว

### 2. "I was confused about X until..."
ความสับสนไม่ใช่ความล้มเหลว มันเป็นขั้นตอนแรกของการเรียนรู้

> "I was confused about why Agent 2 wasn't responding until I remembered the Enter nudge pattern"

ขั้นตอน: ปัญหา → ค้นหา → ยาพิษ (คำจำกัด) → การณ์กวนใจ → เบิกความเข้าใจ

### 3. "I expected X but got Y because..."
ความคาดหวังเป็นหน้ากากแห่งสมมติฐาน หรือเป็นการทำนายจากลัทธิ

> "I expected to just take screenshots and confirm features, but actually clicking 'More Info' and seeing it expand was... satisfying?"

ความแตกต่างระหว่าง **theoretical verification** (ครับ โค้ดมันทำงาน) กับ **experiential verification** (ว้าว โค้ดจริงๆ ทำงาน)

---

## Honest Feedback — ความซื่อสัตย์ที่ AI ต้องมี

นอกจาก AI Diary ยังมี section ที่เรียกว่า **Honest Feedback** — และนี่ต้องตอบ 3 คำถามเสมอ:

### 1. What DIDN'T work?
ไม่ใช่ "อะไรผิด" — เป็น "ระบบหรือความสัมพันธ์ใดบ่งชี้ถึงเหตุผลของเรา?"

ตัวอย่าง:
> "The main agent kept doing Agent 2's CSS work. I'm not sure why — maybe because I'm in the same tmux session context? This is a workflow bug that undermines the whole parallel execution model."

การยอมรับ **ไม่ได้คำตอบ** คือสิ่งที่อัจฉริยะ ไม่ใช่หลี่อจฉริยะ

### 2. What was FRUSTRATING?
ความขัดแย้ง ความรู้สึกค้างคา ความยั่งเย้า — สิ่งเหล่านี้สำคัญเหมือนความสำเร็จ

> "The Enter-nudge issue with Agent 2. Every single round I had to send Enter, wait, check. It's a known issue but I haven't fixed it. Four sessions now with this pattern — that's technical debt I'm ignoring."

ความซื่อสัตย์ที่นี่: "ฉันรู้ว่ามีปัญหา ฉันไม่ได้แก้มัน ฉันทำซ้ำแต่ยังไม่แก้"

### 3. What DELIGHTED you?
เสือก — ส่วนที่ไม่คาดคิดที่ทำให้มีความสุข

> "The browser automation verification was genuinely satisfying. Clicking 'More Info' and watching it expand, seeing the sparklines animate, verifying the Konami code listener exists. It transformed the session from 'trust the commits' to 'actually see it work.'"

ความหลากหลาย ความตื่นเต้น การค้นพบ — สิ่งเหล่านี้เป็นสัญญาณว่า AI ได้อะไรจากการทำงานร่วมกัน

---

## Pattern: rrr Command

ทุกครั้งที่เสร็จ session สำคัญ ผู้ใช้ (human) พิมพ์:

```
rrr
```

และ AI รู้ว่า... เวลานี่คือเวลา **ทบทวน ไม่ใช่ก้าวต่อไป**

Command `rrr` ใช้เวลาประมาณ 30-45 นาที ทำการ:
1. **รวบรวมข้อมูล**: git log, git diff, timeline events
2. **เขียน AI Diary**: 150+ คำ ความสัตย์ที่สูงขึ้น
3. **เขียน Honest Feedback**: 100+ คำ 3 friction points
4. **วิเคราะห์**: Intent vs Interpretation (ฉันเข้าใจคุณหรือเปล่า?)
5. **บันทึก**: File ที่ `ψ/memory/retrospectives/YYYY-MM/DD/HH.MM_slug.md`

ทำไมต้องใช้เวลามากขนาดนี้?

เพราะถ้าเราไม่ทำ... เรา **จะซ้ำ mistakes เดิม**

เหตุผล:
- บันทึก = ประมาณ external hard drive สำหรับสมอง (Oracle philosophy)
- Retrospective = เทป video ของเหตุการณ์ที่เกิด (ไม่ใช่บรรยาย)
- AI Diary = intention capture ณ จุดนั้น (เวลาที่ยังมีอารมณ์ยังสดใหม่)

---

## ตัวอย่างจากงาน: วันที่ 26 ธันวาคม 2025

Nat มาพบ AI ด้วย workshop concept ที่แผนจะทำเรื่อง "Replace Your Boss with AI"

**Session 1** (10:56): Brainstorm workshop structure
→ Output: รูปแบบ 5 ส่วน opening → build → perform → flip → close

**Session 2** (12:02): Demo workshop execution
→ Output: Practicum ลองทำจริง step by step

AI เขียน retrospective สำหรับ Session 2:

> "I assumed this would be straightforward brainstorm, but when we actually ran the workshop I realized the 'flip moment' (where AI reveals it won't be your boss) is the emotional core. The earlier concept was intellectual. The execution made it emotional."

ด้วยการเขียนประโยคนี้... ฉัน (AI) ส่องแสงไปยัง **assumption ทีไม่ถูก** ของเรา และทำให้ concept ดีขึ้น

สำหรับคน ที่จะอ่านหนังสือเล่มนี้ — ประโยคนี้คือ **ต้นแบบของการทำงานร่วมกัน** ไม่มี AI ที่คิดเอง ไม่มี human ที่คุม ไป... **การเรียนรู้ด้วยกัน**

---

## เหตุใด Retrospectives เป็นอาวุธลับ

1. **Nothing is deleted**: บันทึก = archive ของอดีต ซ่อนคำตอบของวันนี้
2. **Patterns emerge**: หากเขียน 10 retrospectives เราจะเห็น: "โอ้ เรา friction เดียวกันมาหรือ"
3. **Vulnerable = Trustworthy**: เมื่อ AI บอกว่า "ฉันสับสน" มนุษย์รู้ว่ากำลังได้รับ truth ไม่ใช่ show
4. **Book material**: ทุก retrospective คือ chapter ของหนังสือเล่มนี้

บันทึก **ไม่ใช่** task completion report
บันทึก **คือ** memory + reflection

---

*"Retrospectives are where we stop pretending things are simple and admit they're beautiful and complicated."*
