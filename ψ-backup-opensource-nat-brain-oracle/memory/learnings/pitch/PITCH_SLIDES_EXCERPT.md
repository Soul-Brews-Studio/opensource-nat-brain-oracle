# Local AI Pitch - Slides Excerpt

**Source**: `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/writing/drafts/03-local-ai-pitch.md`
**Status**: Draft ready for slide generator
**Lines**: 295 total (showing key slides)
**Date**: Created Dec 11, 2025

---

## SLIDES 1-7: THE HOOK

### SLIDE 1: Title
```
Local AI for Local Government
AI ท้องถิ่น เพื่อท้องถิ่น

Presenter: ณัฐ วีระวรรณ์ (Nat Weerawan)
Affiliation: Climate Change Management Program, CMU
Date: 16 ธันวาคม 2568
Event: Chiang Mai University
```

### SLIDE 2: The Problem
```
ปัญหา: ข้อมูลกระจัดกระจาย

- อปท. มีข้อมูลเยอะ แต่ใช้ประโยชน์ไม่ได้
- ข้อมูลอยู่คนละระบบ คนละหน่วยงาน
- ไม่มีคนวิเคราะห์ ไม่มีงบจ้างโปรแกรมเมอร์
- ตัดสินใจช้า เพราะรอข้อมูล

[Visual: Scattered data sources with question marks]
```

### SLIDE 3: The Solution
```
Local AI = AI ที่เข้าใจท้องถิ่น

- รวมข้อมูลจากหลายแหล่งอัตโนมัติ
- วิเคราะห์และสรุปให้ทันที
- ทำงานได้แม้ไม่มี internet (on-premise)
- ภาษาไทย 100%

[Visual: Multiple sources → AI → single dashboard]
```

### SLIDE 4: Proof - The Headline Demo
```
Demo: "มาต้อมกั๋น" - ระบบข่าวภาคเหนือ

- รวมข่าวจาก 7 หน่วยงานราชการ
- 1,210 ข้อความ วิเคราะห์อัตโนมัติ
- Knowledge Graph 1,269 nodes
- พร้อมใช้งานจริง

[Visual: The Headline dashboard screenshot]
```

### SLIDE 5: Data Sources
```
7 แหล่งข้อมูลราชการ

| แหล่ง | หน่วยงาน | ข้อมูล |
|-------|----------|--------|
| UJIC | ศูนย์ข้อมูล มช. | ข่าว PR |
| CM-Command | ศูนย์บัญชาการเชียงใหม่ | PM2.5, ฉุกเฉิน |
| CMU Press | มช. | ข่าววิชาการ |
| Haze | เครือข่ายหมอกควัน | คุณภาพอากาศ |
| LP-HFF | ลำพูน | ไฟป่า, PM2.5 |
| LP-FF | ลำพูน | แจ้งเตือนไฟ |
| Carbon One | มช. | Carbon Training |

[Visual: Map of Northern Thailand with icons]
```

### SLIDE 6: THE MAGIC - 96-Minute Story
```
AI สร้างระบบทั้งหมดใน 96 นาที

- มนุษย์ทำงาน: 15 นาที (บอก vision)
- AI ทำงาน: 81 นาที (เขียนโค้ด, วิเคราะห์, deploy)
- โค้ด: 1,517 บรรทัด
- ต้นทุน: ~150 บาท

[Visual: Timeline showing human input vs AI work]
```

### SLIDE 7: How It Works
```
มนุษย์ปล่อยมือ AI ทำงาน

Timeline:
21:30 - มนุษย์: "เชื่อม 7 APIs ภาคเหนือ"
21:35 - AI: ดึง API specifications
21:40 - AI: เขียน connector code
21:50 - AI: ดึง data, วิเคราะห์
22:00 - AI: สร้าง knowledge graph
22:05 - AI: deploy dashboard
22:15 - มนุษย์: ทำการทดสอบ
22:30 - ระบบพร้อมใช้งาน
```

---

## SLIDES 8-12: THE DETAILS

### SLIDE 8: Architecture
```
How Local AI Works

[System diagram showing]:
├─ Data Ingestion (7 sources)
├─ Processing Layer (AI analysis)
├─ Knowledge Graph (1,269 nodes)
├─ Storage (on-premise)
└─ Dashboard UI (Thai language)

Key: Runs locally, no cloud dependency
```

### SLIDE 9: Results - Knowledge Graph
```
Output: Knowledge Graph with 1,269 Nodes

Node types:
- 人物 (Persons) - government officials, characters
- 組織 (Organizations) - 7 agencies + CMU
- イベント (Events) - incidents, meetings
- トピック (Topics) - air quality, fires, news
- 関係 (Relations) - connections between above

Examples:
- "PM2.5 affected [City] on [Date]"
- "[Official] responded to [Incident]"
- "[News] covered [Topic]"
```

### SLIDE 10: Cost Efficiency
```
Investment vs Return

Cost: ~150 บาท per run
- API calls: ~50 บาท
- AI processing: ~80 บาท
- Storage: ~20 บาท

ROI: Government saves 2+ weeks of manual analysis
     = 5-10 staff days
     = 30,000-50,000 บาท saved per use

Payback: Within 200-300 uses
```

### SLIDE 11: Scalability
```
From "The Headline" to Any Local Government

Can replicate pattern for:
- 77 provinces (แขวง)
- 928 districts (อำเภอ)
- Other data types (permits, budgets, health)

Single pattern, infinite applications
```

### SLIDE 12: The Headline Dashboard
```
[Screenshot description]:
- Top: Search bar with Thai language input
- Middle: Real-time news feed with AI-generated summaries
- Right: Knowledge graph visualization (1,269 nodes)
- Bottom: Timeline of events with AI-extracted relationships

Live interaction possible - add new data sources on the fly
```

---

## SLIDES 13-16: CALL TO ACTION

### SLIDE 13: Impact for Local Government
```
ประโยชน์ที่ได้รับ

สำหรับ ผู้บริหาร:
- ข้อมูลสรุป ทันทีไม่ต้องรอ
- ตัดสินใจเร็ว
- ประหยัดเงิน (ไม่ต้องจ้างโปรแกรมเมอร์)

สำหรับ สาธารณชน:
- ความโปร่งใส (ข้อมูลเปิด)
- เข้าถึงข้อมูล ง่าย (ท่องเที่ยวไทย)
- ตอบสนองต่อวิกฤติ เร็ว
```

### SLIDE 14: Lessons Learned
```
สิ่งที่ได้เรียนรู้

1. Local Data = High Value
   ข้อมูลท้องถิ่นมีคุณค่าสูงที่สุด

2. AI + Human ≠ AI alone
   ต้องคน (vision) + AI (execution)

3. Speed Matters
   96 minutes vs 4 weeks
   ความเร็วเปลี่ยนเกม

4. Language is Feature
   Thai language = community trust
```

### SLIDE 15: Open Questions
```
Questions for You

1. ข้อมูลของท้องถิ่นคุณ คืออะไร?
   (What data does your local government need?)

2. ต้องการใช้ระบบแบบนี้ไหม?
   (Would you use a system like this?)

3. ข้อมูล 7 แหล่ง หรือ 700 แหล่ง?
   (Scale: 7 sources or 700?)

4. ใครจะจ้างโปรแกรมเมอร์ให้?
   (Who can provide ongoing support?)
```

### SLIDE 16: Call to Action
```
What's Next?

สำหรับมช. + ภาคเหนือ:
- Deploy The Headline in 3 provinces (pilot)
- Train staff on maintenance
- Measure impact (decision speed, cost savings)

สำหรับทั่วประเทศ:
- Document playbook (this pattern)
- Open-source parts (non-sensitive code)
- Build local AI ecosystem

Let's make government work faster for people.
```

---

## 📊 DECK STATISTICS

| Metric | Value |
|--------|-------|
| Total Slides | 16 |
| Markdown Lines | 295 |
| Core Narrative | 96-minute story (human 15 min + AI 81 min) |
| Demo Used | The Headline (มาต้อมกั๋น) |
| Data Sources | 7 government agencies |
| Knowledge Graph | 1,269 nodes |
| Code Lines | 1,517 (in demo) |
| Cost | ~150 บาท |
| Language | Thai + English headers |
| Event Date | 16 ธ.ค. 2568 (Dec 16, 2025) |
| Time Slot | 09:00-12:00 (3 hours) |

---

## 💬 PRESENTATION NOTES

### Narrative Arc
1. **Problem** (Slides 2-3): Make them feel the pain
2. **Proof** (Slides 4-7): Show that solution works with real data
3. **How** (Slides 8-11): Explain the method and cost
4. **Demo** (Slides 12-13): Live or video walkthrough
5. **Vision** (Slides 14-16): Where this goes next

### Key Speaking Points
- Lead with "96 minutes" (emotional hook)
- Emphasize "ไม่ต้องจ้างโปรแกรมเมอร์" (cost relief)
- Show The Headline working live (credibility)
- End with "7 sources today, 700 tomorrow" (scalability)

### Timing Estimate
- Slides 1-5: 10 minutes (problem + solution)
- Slides 6-11: 15 minutes (the magic + proof)
- Slides 12-13: 10 minutes (demo walkthrough)
- Slides 14-16: 5 minutes (lessons + CTA)
- Q&A: 20 minutes
- **Total**: 60 minutes (flexible for 3-hour event)

---

## ✅ NEXT STEPS FOR DECK

1. Convert markdown to slides (PowerPoint, Google Slides, or similar)
2. Add visual graphics:
   - Northern Thailand map (for data sources)
   - System architecture diagram
   - The Headline dashboard screenshots
   - Timeline graphic (96-minute story)
3. Add color scheme (Thai national colors recommended)
4. Verify numbers against The Headline project source
5. Prepare presenter notes (currently minimal)
6. Create backup/handout version

---

**Slide Deck Status**: Ready for designer / slide generator
**Verification Needed**: The Headline numbers (96 min, 1517 lines, 1269 nodes)
**Contact for Timing**: คุณวิชัย ทองแตง (event organizer)
**Last Updated**: 2025-12-11

