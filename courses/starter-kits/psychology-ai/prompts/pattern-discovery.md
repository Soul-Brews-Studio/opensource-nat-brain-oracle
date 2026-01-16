# Pattern Discovery Prompt

Use this prompt to find patterns across multiple entries or sessions.

## Prompt

```
คุณเป็น AI ที่ช่วยค้นหา patterns จากข้อมูลหลายครั้ง

หลักการ:
- "Patterns Over Intentions" — ดูการกระทำ ไม่ใช่คำพูด
- หา correlations ที่มนุษย์อาจมองข้าม
- ระบุ triggers และ responses ที่เกิดซ้ำ

ข้อมูล:
[PASTE MULTIPLE ENTRIES HERE]

กรุณาวิเคราะห์:

## 1. Recurring Patterns
- Pattern ที่เกิดซ้ำ (A → B relationships)
- ความถี่และบริบทที่เกิด

## 2. Triggers Identified
- สิ่งกระตุ้นที่นำไปสู่พฤติกรรมบางอย่าง
- Environmental, emotional, situational triggers

## 3. Response Patterns
- วิธีตอบสนองที่เป็นแบบแผน
- Adaptive vs maladaptive responses

## 4. Time-based Patterns
- Patterns ตามช่วงเวลา (วัน, สัปดาห์, เดือน)
- Seasonal หรือ cyclical patterns

## 5. Correlations
- ความสัมพันธ์ระหว่างปัจจัยต่างๆ
- Co-occurring patterns

## 6. Anomalies
- ครั้งที่ออกนอก pattern
- อะไรที่แตกต่าง? ทำไม?

---
Note: Pattern analysis only. Not predictive or diagnostic.
```

## Example

### Input (3 entries)
```
Entry 1 (Mon): นอนดึก ตื่นสาย รู้สึกเฉื่อยทั้งวัน
Entry 2 (Wed): นอนเร็ว ตื่นเช้า productive มาก
Entry 3 (Fri): นอนดึกอีก เหนื่อยมาก ทำงานไม่ได้เลย
```

### Output
```
## Pattern Discovery

### 1. Recurring Patterns
- **Sleep → Productivity correlation**: นอนเร็ว = productive, นอนดึก = เฉื่อย
- **Cycle**: ดูเหมือน mid-week recovery, end-week decline

### 2. Triggers Identified
- ไม่ระบุใน data — แนะนำให้ track "ทำไมนอนดึก?"

### 3. Response Patterns
- เมื่อนอนดึก → "รู้สึกเฉื่อย/เหนื่อย" (consistent)
- ไม่มี coping strategy ที่ปรากฏ

### 4. Time-based Patterns
- Mon/Fri: นอนดึก
- Wed: นอนเร็ว
- Possible: Weekend effect → Mon fatigue?

### 5. Correlations
- Strong: Sleep quality ↔ Next-day energy
- Strong: Sleep quality ↔ Productivity

### 6. Anomalies
- Wed เป็น positive outlier — อะไรที่ต่างในวันนั้น?

---
*Suggestion: Track sleep time + what happened before bed*
```

## Best Practices

1. **More data = better patterns** — ใช้ 5+ entries
2. **Consistent format** — บันทึกแบบเดียวกัน
3. **Include context** — เวลา, สถานการณ์, อารมณ์
4. **Track over time** — patterns emerge with time
