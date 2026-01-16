# Local AI Pitch Slides - Content for AI Slide Generator

> **Event**: 16 ธ.ค. 2568, ม.เชียงใหม่
> **Presenter**: ณัฐ วีระวรรณ์ (Nat Weerawan)
> **Topic**: Local AI for Local Government
> **Demo**: The Headline Project

---

## SLIDE 1: Title

**Title**: Local AI for Local Government
**Subtitle**: AI ท้องถิ่น เพื่อท้องถิ่น
**Presenter**: ณัฐ วีระวรรณ์ (Nat Weerawan)
**Affiliation**: Climate Change Management Program, CMU
**Date**: 16 ธันวาคม 2568

---

## SLIDE 2: The Problem

**Title**: ปัญหา: ข้อมูลกระจัดกระจาย

**Bullets**:
- อปท. มีข้อมูลเยอะ แต่ใช้ประโยชน์ไม่ได้
- ข้อมูลอยู่คนละระบบ คนละหน่วยงาน
- ไม่มีคนวิเคราะห์ ไม่มีงบจ้างโปรแกรมเมอร์
- ตัดสินใจช้า เพราะรอข้อมูล

**Visual suggestion**: Icons showing scattered data sources with question marks

---

## SLIDE 3: The Solution

**Title**: Local AI = AI ที่เข้าใจท้องถิ่น

**Bullets**:
- รวมข้อมูลจากหลายแหล่งอัตโนมัติ
- วิเคราะห์และสรุปให้ทันที
- ทำงานได้แม้ไม่มี internet (on-premise)
- ภาษาไทย 100%

**Visual suggestion**: Diagram showing multiple sources → AI → single dashboard

---

## SLIDE 4: Proof - The Headline Demo

**Title**: Demo: "มาต้อมกั๋น" - ระบบข่าวภาคเหนือ

**Bullets**:
- รวมข่าวจาก 7 หน่วยงานราชการ
- 1,210 ข้อความ วิเคราะห์อัตโนมัติ
- Knowledge Graph 1,269 nodes
- พร้อมใช้งานจริง

**Visual suggestion**: Screenshot of The Headline dashboard

---

## SLIDE 5: Data Sources

**Title**: 7 แหล่งข้อมูลราชการ

**Table**:
| แหล่ง | หน่วยงาน | ข้อมูล |
|-------|----------|--------|
| UJIC | ศูนย์ข้อมูล มช. | ข่าว PR |
| CM-Command | ศูนย์บัญชาการเชียงใหม่ | PM2.5, ฉุกเฉิน |
| CMU Press | มช. | ข่าววิชาการ |
| Haze | เครือข่ายหมอกควัน | คุณภาพอากาศ |
| LP-HFF | ลำพูน | ไฟป่า, PM2.5 |
| LP-FF | ลำพูน | แจ้งเตือนไฟ |
| Carbon One | มช. | Carbon Training |

**Visual suggestion**: Map of Northern Thailand with data source icons

---

## SLIDE 6: The Magic - AI Built It

**Title**: AI สร้างระบบทั้งหมดใน 96 นาที

**Bullets**:
- มนุษย์ทำงาน: 15 นาที (บอก vision)
- AI ทำงาน: 81 นาที (เขียนโค้ด, วิเคราะห์, deploy)
- โค้ด: 1,517 บรรทัด
- ต้นทุน: ~150 บาท

**Visual suggestion**: Timeline showing human input vs AI work

---

## SLIDE 7: How It Works

**Title**: มนุษย์ปล่อยมือ AI ทำงาน

**Timeline**:
- 21:30 - มนุษย์: "เชื่อม 7 APIs ภาคเหนือ"
- 21:45 - AI เริ่มทำงาน (7 agents ขนาน)
- 21:50 - มนุษย์หลับ
- 23:06 - ระบบพร้อมใช้
- 23:30 - มนุษย์ตื่น ตรวจ approve

**Key message**: "Hands-off = ปล่อยมือได้"

**Visual suggestion**: Clock/timeline with sleep icon

---

## SLIDE 8: Technical Stack

**Title**: เทคโนโลยี Open Source 100%

**Bullets**:
- Python + Streamlit (ฟรี)
- Knowledge Graph (NetworkX)
- Claude AI (วิเคราะห์ภาษาไทย)
- ทำงาน offline ได้
- ไม่มี vendor lock-in

**Visual suggestion**: Tech stack logos

---

## SLIDE 9: Results

**Title**: ผลลัพธ์ที่ได้

**Bullets**:
- Dashboard วิเคราะห์ข่าว real-time
- แจ้งเตือน PM2.5 อัตโนมัติ (87 alerts)
- Knowledge Graph เชื่อมความสัมพันธ์
- Deploy บน GitHub (ฟรี)

**Visual suggestion**: Dashboard screenshots, graph visualization

---

## SLIDE 10: Why Local AI?

**Title**: ทำไมต้อง "Local" AI?

**Comparison table**:
| | Cloud AI | Local AI |
|---|----------|----------|
| Internet | ต้องมี | ไม่ต้อง |
| ข้อมูลอยู่ที่ | ต่างประเทศ | ในพื้นที่ |
| ภาษา | อังกฤษเป็นหลัก | ไทย 100% |
| ความเข้าใจท้องถิ่น | น้อย | สูง |
| ต้นทุนระยะยาว | สูง | ต่ำ |

**Visual suggestion**: Two columns comparison

---

## SLIDE 11: Scalability

**Title**: ขยายได้ทุกท้องถิ่น

**Bullets**:
- Pattern เดียวกัน ใช้ได้ทุก อปท.
- เปลี่ยนแค่ data source
- 1 วัน = 1 ระบบใหม่
- ไม่ต้องจ้างโปรแกรมเมอร์

**Examples**:
- DustBoy → Local AI for Air Quality
- FloodBoy → Local AI for Flood
- The Headline → Local AI for News

**Visual suggestion**: Map of Thailand with multiple deployment points

---

## SLIDE 12: Cost Comparison

**Title**: เปรียบเทียบต้นทุน

**Traditional approach**:
- จ้าง 3 engineers
- รอ 1-2 เดือน
- งบ 500,000+ บาท

**Local AI approach**:
- บอก AI 15 นาที
- รอ 96 นาที
- งบ ~150 บาท

**Savings**: ลด 99.97%

**Visual suggestion**: Cost comparison bar chart

---

## SLIDE 13: Experience & Trust

**Title**: ประสบการณ์ 8-10 ปี กับท้องถิ่น

**Bullets**:
- DustBoy: sensor network ทั่วภาคเหนือ
- ทำงานกับ อปท. มานาน
- เข้าใจปัญหาจริง
- Advisor: ศ.ดร.เศรษฐ์ สัมภัตตะกุล (UNISERV)

**Visual suggestion**: DustBoy logo, map of sensor locations

---

## SLIDE 14: Vision

**Title**: Vision: Local AI ทุก อปท.

**Bullets**:
- Phase 1: Pilot 5 อปท. ภาคเหนือ
- Phase 2: ขยาย 50 อปท.
- Phase 3: Template สำหรับทั้งประเทศ

**Goal**: "ทุก อปท. มี AI ช่วยตัดสินใจ"

**Visual suggestion**: Roadmap/phases diagram

---

## SLIDE 15: Call to Action

**Title**: ร่วมมือกับเรา

**Bullets**:
- ทดลองใช้ The Headline (ฟรี)
- Pilot ใน อปท. ของท่าน
- ข้อมูลท่าน + AI เรา = ระบบใหม่ใน 1 วัน

**Contact**:
- ณัฐ วีระวรรณ์ (Nat Weerawan)์ (Nat Weerawan)
- [email/contact info]

**Visual suggestion**: QR code to demo, contact info

---

## SLIDE 16: Q&A

**Title**: ถาม-ตอบ

**Prepared questions**:
- Q: "ใครเขียนโค้ด?" → A: "AI เขียน มนุษย์ตรวจ"
- Q: "ข้อมูลปลอดภัยไหม?" → A: "อยู่ในเครื่อง ไม่ส่งออก"
- Q: "ต้องมี IT team ไหม?" → A: "ไม่ต้อง AI ดูแลให้"

**Visual suggestion**: Q&A icon, simple background

---

## APPENDIX: Key Numbers (Backup)

**For reference during Q&A**:
- 96 นาที = เวลาสร้างระบบ
- 15 นาที = มนุษย์ทำงาน
- 81 นาที = AI ทำงานอัตโนมัติ
- 1,517 บรรทัด = โค้ดที่ AI เขียน
- 1,210 = ข้อความที่วิเคราะห์
- 7 = จำนวน APIs
- 1,269 = nodes ใน knowledge graph
- 4,600 = relationships
- 87 = PM2.5 alerts
- ~150 บาท = ต้นทุน API

---

## DESIGN NOTES FOR AI SLIDE GENERATOR

**Style**:
- Clean, minimal design
- Blue/green color scheme (trust, environment)
- Large fonts for readability
- One key message per slide
- Use icons over text where possible

**Language**:
- Thai primary
- English for technical terms only

**Tone**:
- Professional but accessible
- Not overly technical
- Focus on benefits, not features

**Total slides**: 16 (including title and Q&A)
**Estimated time**: 10-15 minutes presentation

---

*Generated: 2025-12-11*
*Ready for AI slide generator (Gamma, Beautiful.ai, etc.)*
