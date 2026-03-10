---
title: **ถิงถิง Project Update: Vision-based Electrical Load Calculator**
tags: [tingting, vision-ai, pdf-parsing, electrical, floor-plan]
created: 2026-01-04
source: Call with Tingting (2026-01-04)
---

# **ถิงถิง Project Update: Vision-based Electrical Load Calculator**

**ถิงถิง Project Update: Vision-based Electrical Load Calculator**

Revised approach:
- Input: PDF floor plan ที่มี
  - ตำแหน่งดวงโคม (lighting fixtures)
  - ตำแหน่งสวิตช์ (switches)
  - ตำแหน่งปลั๊ก (outlets)
- AI อ่านแบบแปลน → detect symbols → คำนวณโหลด

Technical requirement:
- PDF to image conversion
- Symbol detection (architectural electrical symbols)
- AI Vision (Claude/GPT-4V) or trained CV model
- Calculate load from detected fixtures

---
*Added via Oracle Learn*
