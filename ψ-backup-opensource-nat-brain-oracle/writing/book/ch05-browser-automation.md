# บทที่ 5: Browser Automation — AI ที่ใช้เว็บได้

## Playwright MCP คืออะไร

Playwright คือเครื่องมือ browser automation ที่ให้ AI ควบคุมเว็บบราวเซอร์ได้เหมือนคนทั่วไป ผ่าน MCP (Model Context Protocol) เว็บเบราวเซอร์กลายเป็น "interface" ของ AI ที่สามารถคลิก กรอกฟอร์ม นำทาง และอ่านข้อมูลได้

สิ่งที่ Playwright ทำได้:
- **Navigate**: ไปยัง URL ที่ต้องการ
- **Fill forms**: กรอกข้อมูลลงในช่องอินพุต
- **Click buttons**: คลิกปุ่มและลิงก์
- **Read content**: อ่านข้อความจากเพจ
- **Handle tabs**: จัดการหลาย tab ที่เปิดพร้อมกัน
- **Wait for elements**: รอให้ส่วนของเพจโหลดเสร็จ

ความสำคัญคือว่า AI ไม่ได้แค่อ่านข้อมูล — มันสามารถ **ทำ** งานที่ต้องอยู่บนเว็บได้

## ตัวอย่างจริง: Lion Air Web Check-in

วันที่ 26 ธันวาคม 2025 ระหว่างเข้าร่วม workshop ที่ธรรมศาสตร์รังสิต ฉันต้องเช็คอิน Lion Air สำหรับเที่ยวบิน SL520 DMK→CNX เวลา 19:35 น. แทนที่จะออกจากเด็สค์เพื่อเช็คอินเองบนแล็ปท็อป ฉันก็แค่บอก "ช่วยเช็คอินให้หน่อย" และให้ AI ทำสำหรับฉัน

เนื่องจากเว็บเช็คอิน Lion Air ต้องใช้ Booking Reference และ Last Name ฉันไม่ได้พูดชื่อสกุลออกมา ฉันเพียงแค่บอก "ใช้ 5 agents ลองหานามสกุล" — AI ก็ใช้การค้นหาแบบขนาน (parallel search) ดึงข้อมูลจากภูมิหลัง เอกสาร Git history และไฟล์คอนฟิก และเมื่อทั้ง 5 agents ตอบกลับ "WEERAWAN" ฉันก็รู้ได้ว่าถูก แล้ว AI ก็เช็คอินให้ฉันสำเร็จภายในเวลา 10 นาที

## Flow: Navigate → Fill → Click → Success

นี่คือขั้นตอนที่ Playwright ทำไป:

```
1. Navigate to lionairthai.com/en/Check-in/Web-Check-in
   → Old URL returned 404 (website changed structure)

2. Recovered: Clicked "Web Check-in" link from main page
   → Got new URL with correct path

3. Selected Thai Lion Air (SL) carrier
   → New tab opened

4. Filled Booking Reference: OXTKAH
   → Form field recognized, text entered

5. Filled Last Name: WEERAWAN
   → Data from parallel agent search

6. Retrieved booking
   → Passenger details displayed

7. Confirmed Hazmat info
   → Safety check passed

8. Check-in complete!
   → ✅ Seat assigned: 16A
```

นี่คือสิ่งที่ยากที่สุด: เว็บเช็คอิน Lion Air เปิดในแท็บใหม่ ไม่ใช่ไป URL เดียว ดังนั้น Playwright ต้องจัดการการสลับแท็บและติดตามข้อมูลผ่านการสลับบริบท (context switch) ประเภทนี้คืออะไรที่ browser automation ต้องรับมือ — ความซับซ้อนของเว็บจริง ไม่ใช่เว็บง่ายๆ

## ข้อจำกัดและความระวัง

Browser automation มีอำนาจแต่มีเขตแดนที่ต้องรู้:

**ข้อจำกัดทางเทคนิค:**
- URL เปลี่ยนตลอดเวลา (Lion Air เปลี่ยนเส้นทาง) → ต้องมี error handling
- Website ช้า → ต้อง wait for elements แล้วไม่ใช่รีด URL เข้า
- JavaScript ที่ซับซ้อน (Lottie animations) → บางครั้งบล็อก interaction

**ข้อจำกัดทางความปลอดภัย:**
- ไม่ควรเก็บ booking reference ไว้ในโค้ด → เสี่ยง leak
- ไม่ควร automate OTP หรือ password entry → ความเสี่ยงผิดพลาดสูง
- ต้องมี audit trail → ใครทำอะไร และเมื่อไร

**ข้อจำกัดทางการออกแบบ:**
- บางเว็บปิด browser automation → Cloudflare, anti-bot checks
- Session timeouts → ต้อง handle gracefully
- CAPTCHA → ยังไม่สามารถ solve ได้โดยอัตโนมัติ

ความระวังที่สำคัญ: Browser automation ไม่ได้มีความสามารถไม่จำกัด มันเหมือนกับมนุษย์ที่ใช้เว็บบราวเซอร์ — มีข้อจำกัด ประสบอุปสรรค และต้องมีความยืดหยุ่น

## ความหมายสำหรับ Co-Creation

ที่น่าสนใจคือว่า Playwright ไม่ได้ทำให้ AI "independent" มากขึ้น มันทำให้ AI สามารถทำงาน **ที่มนุษย์อยากให้ทำ** ขณะที่มนุษย์ทำงานอื่นๆ ในกรณีของฉัน ฉันสามารถอยู่ในห้องประชุม workshop ในขณะที่ AI เช็คอินให้ ความร่วมมือที่ดี ไม่ใช่ AI ที่อิสระ

Playwright ยังสอนให้เราเห็นว่า AI ต้อง **recover gracefully** เมื่อสิ่งต่างๆ ไม่ทำงาน ไม่ได้คว่ำ (fail hard) เมื่อ URL ใหม่ AI ก็หาลิงก์ที่ถูก เมื่อข้อมูลลัดหายไป AI ก็ใช้ parallel agent search ชั่วสั้น สิ่งนี้เรียกว่า "graceful degradation" และมันมีค่ามากกว่าความสมบูรณ์แบบที่อิดโอลิสติก

---

**Chapter Complete** | 400 words | Demo-focused | Real flight example | Code flow + lessons

---

## ที่มา

- **Lion Air Check-in Session**: [Session Retrospective 2025-12-26 10:56](../../memory/retrospectives/2025-12/26/10.56_tu-rangsit-workshop-checkin.md)
- **Playwright Technology**: Anthropic MCP for Browser Automation
- **Parallel Agent Pattern**: /trace command with 5 concurrent Haiku agents
