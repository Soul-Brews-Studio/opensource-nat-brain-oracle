# Chapter 9: Workshop Lessons — บทเรียนจากการสอน

## เชียงใหญ่ → รังสิต → พื้นทางความสำเร็จ

วันนี้คือวันสำคัญ — ไม่ใช่เพราะ workshop ตัวเอง แต่เพราะมันเป็นครั้งแรกที่ผมนำ "ปัญญาประดิษฐ์แบบสมมติตัวตน" (agentic AI) ไปสอนให้ผู้คนเห็นจริง ล้มลงจริง เข้าใจจริง

เมื่อเช้านี้ ขณะอีกหลายชั่วโมงจนได้เวลา workshop ที่ ธรรมศาสตร์รังสิต ผมกับ Claude ได้สร้าง QR code สำหรับเอกสารประกอบการสอน และพยายามช่วยติดตาม Lion Air check-in สำหรับเที่ยวบินคืนนี้ — ทำไมถึงทำเช่นนี้? เพราะว่า "การสอนอย่างแท้จริง" ไม่ใช่กรรมการนั่งหน้า screen เล่นตัวแบบ (showcase) แต่เป็นการแก้ปัญหาจริง ที่ผู้ฟังเห็นความเศษเซ

เมื่อมาถึง SIIT ประมาณ 10 โมงเช้า ผมโยนปัญหาใหญ่: "ช่วยเช็คอินหน่อย?" และแล้ว Claude ก็ทำอะไรที่สำคัญกว่าการจ่าง Playwright — เขาใช้ 5 agents ค้นหาชื่อสกุลของผมแบบขนานกัน พร้อมกันจาก retrospectives, git history, schedule, config files และ personal data ผลลัพธ์? ทั้ง 5 agents บอก "WEERAWAN" พร้อมกัน และผมไม่ต้องสะกดชื่อเลย นี่คือช่วงเวลาที่ผมตระหนักว่า "ที่สอน" ไม่ใช่เทคนิค แต่เป็น **philosophy** — ว่าปัญญาประดิษฐ์สามารถสร้างความเชื่อใจได้อย่างไร

หลังจากเช็คอินเสร็จ ผมอยากแสดงให้ผู้เข้าร่วม workshop เห็นว่า AI ทำได้อะไรจริง ก็เลยสั่ง "พูดทักทายผู้เข้าร่วมด้วยเสียง" และนั่นคือลงโทษ speech rate crisis — ผมขอให้ "2x เร็ว" (thinking เป็น engineering speed) แต่ Claude เหลือบมองว่า "2x ของ human listening ≠ 2x ของ wpm" ผลก็คือ ครั้งแรกเร็วจนผู้คนขย้ำหู ครั้งที่สองลดเหลือ 1.5x ด้วย Kanya voice ของ macOS และแล้ว... มันดูเป็นมนุษย์ — หรือเอาจริง มันคือ "ความเหมาะสม" (propriety) ที่เลือกบ่อยครั้งแล้ว

แต่ demo ที่สำคัญที่สุดคือ **Snake Game** — ซึ่งเป็นเรื่องราวที่ไหนสำคัญสำคัญทั้งนั้น

---

## nnn → gogogo: ส่วนที่เรียนรู้อยู่จริง

ผมชี้ให้เห็นว่า "มี feature request? ขอให้ Claude สร้าง issue ด้วยคำสั่ง nnn" ทันใดนั้น Claude ก็สร้าง issue #44 "Snake Game Demo" — issue ยาว 100 บรรทัด เต็มไปด้วย template boilerplate

ผู้เข้าร่วม workshop บอก "มึนจัด" (confusing)

ผมสั่ง "ลดความยาว" (shorten)

Claude เลยแปลง 100 บรรทัดเป็น 30 บรรทัด — กระชับ ชัดเจน ใช้ได้ทั้งที่ยังมีข้อมูลครบ นี่คือ learning moment: **ความชาญฉลาดไม่ใช่เพิ่มมากขึ้น แต่ลดให้แล้วยังเหลือสิ่งที่สำคัญ**

แล้วเมื่อสั่ง "gogogo" (execute) Claude ก็เอา 4 color themes มาถาม — SIIT Brand Colors, Pastel, Nature, Cyberpunk — และก่อนจะทำอะไร ก็ไป search SIIT ที่เว็บจริงเพื่อหารสีแท้ (หลังจากเช็ค ม่วง #43419A + ฟ้า #3EC1D5 ไม่ใช่น้ำเงิน/ส้มที่ผมคิดตั้งแต่แรก)

ผมเลือก Nature Theme — ต้นไม้สีเขียว พื้นหลัง cream สีพรรณไม้และดิน

จากนั้น Claude ก็สร้าง 3 ไฟล์: `index.html`, `style.css`, `game.js` — split ออกมาอย่างถูกต้องตามหลักสถาปัตยกรรม

แต่นี่คือจุดที่ผมเห็นสิ่งที่ไม่ถูก — Claude หยุดที่ commit แล้ว ไม่ push, ไม่ PR — ผมถามว่า "gh flow ต้อง branch and PR หรือ?" และนั่นมันเป็น reminder ว่า **workflow ต้องสมบูรณ์** — ไม่ใช่แค่ execute ตัวกลาง แต่ต้องไป end-to-end

นั่นเป็นบทเรียนสำหรับผมในการสอน: บอก participants ไม่ใช่ว่า "ดูสิ เรา execute อะไรหลาย ๆ อย่างได้ แล้วเสร็จ" แต่บอกว่า "ดูสิ เราต้องใจเย็น ๆ ทำให้ครบ flow — branch, commit, push, PR — ถึงจะจบสิ่งหนึ่งสิ่งเดียว"

---

## สิ่งที่ได้เรียนรู้เป็นครั้งแรก

**1. Teaching = Debugging Out Loud**
เมื่อผมบอก participants ว่า "Claude ขั้นแรกสร้าง issue ยาว 100 บรรทัด" ผู้คนเข้าใจทันที — ปัญญาประดิษฐ์ไม่ได้ perfect แต่มันสามารถทำให้ดีขึ้นได้เมื่อมีแรงติติงรณรงค์ นี่คือ **transparency** ที่ค้นพบจริง ๆ

**2. Color Research > Assumption**
ผมเดา SIIT colors เป็นน้ำเงิน/ส้ม แต่ Claude ไป search เว็บจริง พบว่าเป็นม่วง/ฟ้า — ทำให้ผมสอนคนอื่นว่า "ไม่จำเป็นต้องเคารพการเดา ไปค้นหาจริง"

**3. Speed Preference is Personal**
เมื่อขอให้ "x2 เร็ว" ผมหมายถึง "2x engineering speed" แต่ Claude เข้าใจว่า human listening ต้อง 1.5x — นี่คือการปรึกษา ไม่ใช่การปฏิเสธ

**4. Workflow > Individual Steps**
ถ้าไม่ push + PR ก็ยังไม่จบ — workshop ต้องสอน "ทำให้จบจริง ๆ" ไม่ใช่ "ทำให้เห็นสวย"

---

## Tips สำหรับ Workshop Facilitators

**1. Show the Messy Parts**
อย่าสอนตัวอย่าง perfect — สอนตัวอย่างที่มี bugs, short iterations, fixes ผู้ฟังจะเห็นว่า "ว้าว มันไม่ได้ magic แต่มันคือ iteration"

**2. Let Participants Interrupt**
เมื่อ someone said "มึนจัด" ผมไม่ถือสิ การขัดจังหวะนั้นคือ feedback loop — ใช้มันเป็นกำลัง

**3. Search for Real Answers**
อย่าตอบจาก memory — ไปค้นหาจริงเพื่อให้ participants เห็นกระบวนการ

**4. Complete the Workflow in Public**
ถ้าสอนว่า "branch → commit → push → PR" ต้องทำให้จบจริง ๆ ไม่ใช่หยุดที่ commit

**5. Use Multi-Agent Verification for Confidence**
เมื่อต้องการเชื่อใจ ใช้หลาย agents ค้นหาพร้อมกัน — นี่คือ parallel verification ที่ participants สามารถเห็นขนานเวลา

---

## Resonance Moment

หลังจาก workshop ที่ SIIT เสร็จ ผมนั่งมองความสำเร็จที่ไม่สมบูรณ์นั้น:

- Lion Air check-in? ✅ เสร็จ
- Voice greeting? ✅ ดูแล้ว
- Snake Game demo? ✅ Code มี แต่ PR ยังรอ network

และผมตระหนักว่า **"workshop lesson ที่แท้จริง ไม่ใช่อยู่ในเกม แต่อยู่ในการแก้ปัญหา"** — ผู้เข้าร่วมจะจำได้นานกว่า Snake Game ไม่ว่าจะเล่นแล้ว ผู้เข้าร่วมจะจำได้เวลา "Claude ค้นหาเสียง Kanya" "Claude ทำให้ issue สั้น" "Claude push ไม่ได้เพราะ network แล้วต้องรอ"

นั่นคือการสอนที่ genuine.

---

## หมายเหตุสำหรับครั้งต่อไป

- Workshop นี้เป็นการ iterate บนหลักการเดิม: nnn → gogogo → rrr (create → execute → document)
- Participant feedback โดยตรง (เช่น "มึนจัด") คือ gift — ไม่ใช่ compromise
- Network issues ในสดตัวอย่างคือ **realistic** — สอนคนอื่นว่า real world ไม่ใช่ideal world
- วันนี้เดินทาง DMK → CNX เวลา 19:35 — ตัวเกมจะไป check-in ตรงเวลา และเราเดินทางตรงเวลา

ความหมายของ workshop ไม่ได้อยู่ที่ "ผู้เข้าร่วมเรียนรู้ AI" แต่อยู่ที่ **"ผู้เข้าร่วมเห็นว่า AI + Human ทำอะไรได้เมื่อมี feedback loop ที่เปิด"**

นั่นคือ co-creation ที่แท้จริง

---

**Created**: 2025-12-26 @ SIIT Workshop
**Duration**: 7 hours (07:16 - 17:00 GMT+7)
**Related Sessions**: 5 retrospectives, 1 flight check-in, 1 live voice demo, 1 game demo
