# Workshop Template

ใช้เป็น template สำหรับสร้าง workshop ใหม่

---

## Metadata

```
**ส่งให้**: [ชื่อผู้รับ]
**วันที่ร่าง**: [YYYY-MM-DD]
**Speaker Bio**: [link to bio]
```

---

## Header Block

```markdown
> # [ชื่อ Workshop]
> ## [Tagline ภาษาอังกฤษ]
> [Tagline ภาษาไทย]

*[One-liner benefit]*
```

---

## Schedule Table Format

**ใช้ 3 columns เสมอ**: `เวลา | หัวข้อ | รายละเอียด`

```markdown
### 🌅 Morning: [Theme] (09:00 - 12:00)

| เวลา | หัวข้อ | รายละเอียด |
|------|--------|------------|
| 09:00-09:30 | **[Topic]** | [Description] |
| 09:30-10:30 | **[Topic]** | [Description] |
| 10:30-10:45 | Break | |
| 10:45-12:00 | **[Topic]** | [Description] |

### 🍜 Lunch Break (12:00 - 13:00)

### 🌆 Afternoon: [Theme] (13:00 - 16:30)

| เวลา | หัวข้อ | รายละเอียด |
|------|--------|------------|
| 13:00-15:00 | **[Topic]** | [Description] |
| 15:00-15:15 | Break | |
| 15:15-16:00 | **[Topic]** | [Description] |
| 16:00-16:30 | **Show & Share** | โชว์ผลงาน + feedback |
```

---

## Standard Sections

### Prerequisites
```markdown
## Prerequisites (สิ่งที่ต้องเตรียมมา)

### ต้องติดตั้งมาก่อน
1. **[Tool 1]** - [install command]
2. **[Tool 2]** - [how to get]

### ความรู้พื้นฐาน
- [Skill 1]
- [Skill 2]
- ไม่ต้องมีประสบการณ์ [X] มาก่อน
```

### Key Takeaways
```markdown
## Key Takeaways

ผู้เข้าร่วมจะได้:
1. ✅ [Outcome 1]
2. ✅ [Outcome 2]
3. ✅ [Outcome 3]
4. ✅ มี [deliverable] กลับไปใช้งานต่อ
```

### Footer
```markdown
---

*Draft version - ปรับแก้ได้ตามต้องการ*

**See also**: [link to related files]
```

---

## Multi-Day Workshop

แยกเป็นไฟล์:
- `draft.md` — Day 1
- `day2-*.md` — Day 2 (ใช้ format เดียวกัน)
- `reference.md` — Teaching content & patterns

Day 2+ header:
```markdown
**ต่อจาก**: [draft.md](draft.md) (Day 1: [Title])

*สำหรับผู้ที่ผ่าน Day 1 มาแล้ว*
```

---

## Folder Structure

```
projects/
├── INDEX.md
└── YYYY-MM-workshop-name/
    ├── draft.md          ← Day 1
    ├── day2-*.md         ← Day 2 (optional)
    └── reference.md      ← Teaching patterns
```

---

*Created: 2025-12-12*
