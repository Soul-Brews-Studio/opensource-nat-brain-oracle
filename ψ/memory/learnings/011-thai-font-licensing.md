---
title: "Thai Font Licensing - Open Source Only"
tags: [learning, fonts, licensing, legal, thai]
created: 2025-12-11
number: "011"
---

# Learning 011: Thai Font Licensing

> ใช้เฉพาะ Open Source Thai Fonts เพื่อหลีกเลี่ยงปัญหาลิขสิทธิ์

## Rule

**เสมอ**: ระบุใน prompt ว่าใช้ open source fonts เท่านั้น

```
Font: Use open source Thai fonts only (Noto Sans Thai, Prompt, Kanit, or similar OFL-licensed fonts)
```

---

## ฟอนต์ที่ใช้ได้ (Open Source)

| ฟอนต์ | License | ที่มา |
|-------|---------|-------|
| **Noto Sans Thai** | OFL | Google |
| **Noto Serif Thai** | OFL | Google |
| **IBM Plex Thai** | OFL | IBM |
| **TH Sarabun New** | GPL | SIPA/รัฐบาล |
| **Pridi** | OFL | Google Fonts |
| **Mitr** | OFL | Google Fonts |
| **Prompt** | OFL | Google Fonts |
| **Kanit** | OFL | Google Fonts |
| **Sarabun** | OFL | Google Fonts |
| **Chakra Petch** | OFL | Google Fonts |
| **Chonburi** | OFL | Google Fonts |
| **Garuda** | GPL | NECTEC |
| **Norasi** | GPL | NECTEC |
| **Kinnari** | GPL | NECTEC |

---

## ฟอนต์ห้ามใช้ (Commercial)

| ฟอนต์ | เหตุผล |
|-------|--------|
| **PSL** (ทุกตัว) | ลิขสิทธิ์ PSL |
| **DB** (ทุกตัว) | ลิขสิทธิ์ DB |
| **TH** (ยกเว้น TH Sarabun) | ตรวจสอบก่อนใช้ |
| **Helvetica Thai** | ลิขสิทธิ์ Linotype |
| **Angsana** (บางเวอร์ชัน) | ตรวจสอบก่อนใช้ |
| ฟอนต์จาก f0nt.com | ไม่ชัดเจนเรื่อง license |

---

## License ที่ปลอดภัย

| License | เชิงพาณิชย์ | แก้ไขได้ |
|---------|------------|----------|
| **SIL OFL** | ✅ | ✅ |
| **Apache 2.0** | ✅ | ✅ |
| **GPL** | ✅ | ✅ |
| **Public Domain** | ✅ | ✅ |

---

## แหล่งดาวน์โหลดที่เชื่อถือได้

1. **Google Fonts** - https://fonts.google.com/?subset=thai
2. **13 ฟอนต์ SIPA** - https://www.nstda.or.th/home/news_post/thai-font/
3. **Thai Font Collection** - https://github.com/jeffmcneill/thai-font-collection
4. **Thaifaces** - https://thaifaces.com/

---

## Standard Prompt Addition

สำหรับทุก image prompt ที่มี Thai text:

```
Font requirement: Use open source Thai fonts ONLY.
Allowed: Noto Sans Thai, Prompt, Kanit, Mitr, Pridi, Sarabun, IBM Plex Thai
Forbidden: PSL, DB, Helvetica Thai, or any commercial Thai fonts
```

---

## Context

- **เหตุผล**: หลีกเลี่ยงปัญหาลิขสิทธิ์และค่าปรับ
- **ใช้กับ**: Antigravity, Leonardo, DALL-E, Midjourney
- **เมื่อไหร่**: ทุกครั้งที่มี Thai text ในรูป

---

*Created: 2025-12-11*
*Source: Web research on Thai font licensing*
