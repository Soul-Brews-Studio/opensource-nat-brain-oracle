# บทที่ 3: Multi-Agent Patterns — ศิลปะการใช้หลาย AI พร้อมกัน

## บทนำ

เมื่อ 3 เดือนที่แล้ว ฉันเห็นตัวเองนั่งอยู่หน้าคอมพิวเตอร์ เพื่อค้นหาชื่อสกุลของ 5 คนที่ได้พูดคุยในแชท ทำให้เสียเวลา 40 นาที ตรวจสอบไฟล์ กรองข้อมูล และแยกแยะ "ใคร-เป็นใคร" ในอพยพ 1,243 บรรทัด

วันนี้ ฉันสามารถ **ส่ง 5 agents ไปพร้อมกัน** ได้ใน 2 นาที แต่ละคนดูแลชุดข้อมูล 1 ชุด ได้ผลลัพธ์เดียวกัน

ความแตกต่างนี้คือเรื่องของ **วิธีการใช้หลาย AI พร้อมกัน**

---

## ทำไมต้องใช้หลาย Agents

### ปัญหา: Bottleneck กำลังมนุษย์

```
ผมคนเดียว × 6 ชั่วโมง = งานเสร็จ
```

แม้แต่ AI ที่ฉลาดที่สุด ก็จำกัดด้วยว่า **อ่านและประมวลผล sequential** — ไฟล์ต่อไฟล์ ไลน์ต่อไลน์ ทีละชิ้น

ปัญหาจะเกิดตอน:
- **งานซ้ำๆ** (edit 50 ไฟล์ด้วย pattern เดียวกัน)
- **ข้อมูล bulk** (1,243 บรรทัดจาก 7 API)
- **หลายมุมมอง** (critique จาก 10 จุดมองต่างๆ)
- **หลายโปรเจค** (10 repos ที่ต้องอัปเดต)

ที่นี่ **AI คนเดียวต้องการ 6 ชั่วโมง** ขาดจำนวน **6 อ้อย**

### วิธีแก้: Parallel Agents

```
5 Haiku agents × 2 นาที
= งานเสร็จใน 1/180 เวลาเดิม
```

ไม่ใช่เรื่องของ AI คนเดียวที่ต้องเร็วกว่า แต่เป็นการใช้ **หลาย AI พร้อมกัน** เหมือน team สิ่งก่อสร้าง ทำงาน parallel บนส่วนต่างๆ

---

## Parallel vs Sequential — เมื่อไหร่ใช้อะไร

### ผัง Decision

```
          ↙ มี dependencies? ↘
         ❌                ✅
         │                 │
    PARALLEL          SEQUENTIAL
    (5 agents × 2min) (1 agent × 10min)
```

### ตัวอย่าง: การใช้ Parallel

**Task**: แยก 7 ไฟล์ API จาก 7 data source ที่ไม่เกี่ยวข้อง

```
Subagent 1 → data/haze-api.json     (ข้อมูลแสบ)
Subagent 2 → data/flood-api.json    (น้ำท่วม)
Subagent 3 → data/heat-api.json     (ความร้อน)
Subagent 4 → data/air-api.json      (บริสุทธิ์)
Subagent 5 → data/rain-api.json     (ฝน)
Subagent 6 → data/wind-api.json     (ลม)
Subagent 7 → data/fire-api.json     (ไฟป่า)

ผลลัพธ์: 433 ไฟล์ใน ~2 นาที ✅
```

**ทำไม Parallel**?
- ไฟล์ 7 ชุดไม่เกี่ยวข้องกัน
- ไม่มี dependencies ระหว่าง agents
- ปล่อยให้ทำพร้อมๆ กัน

---

### ตัวอย่าง: การใช้ Sequential

**Task**: หาชื่อสกุล ต้องรอ deduplication

```
Subagent 1 → สร้าง raw names จาก API
     ↓ (รอให้เสร็จ)
Main Agent → deduplicate ("วรรณพร" = "Varnporn"?)
     ↓ (รอให้เสร็จ)
Subagent 2 → สร้างไฟล์ final
```

**ทำไม Sequential**?
- ข้อมูล dedup ต้องรอ raw data
- Main agent ต้อง verify ก่อน subagent ถัดไป
- ไม่สามารถทำขนานได้

---

## Haiku vs Opus — เมื่อไหร่ใช้อะไร

### ตารางเปรียบเทียบ

| ด้าน | Haiku | Opus |
|------|-------|------|
| **ความเร็ว** | 2x-3x เร็วกว่า | ช้ากว่า |
| **ความฉลาด** | 7/10 | 9.5/10 |
| **ราคา** | $0.08 / 1M tokens | $1.2 / 1M tokens |
| **อ่านไฟล์** | ✅ เร็ว | ❌ ช้า |
| **เขียนโค้ด** | ✅ ดี | ✅ ดีกว่า |
| **ตัดสินใจ** | ⚠️ ต้อง verify | ✅ เชื่อถือ |

### Rule of Thumb

```
งาน bulk        → Haiku (parallel)
งาน complex     → Opus (sequential)
งาน repetitive  → Haiku (7 agents)
งาน 1 ครั้ง     → Opus (quality)
```

---

## Case Study: Lion Air Surname Demo

### บริบท
Workshop ที่ SIIT ธรรมศาสตร์รังสิต นั่งหน้าผู้คนราว 50 คน ต้องหาชื่อสกุลจากบันทึกหนังสือเดินทาง 5 คน แล้วคืนผลลัพธ์โดยถูกต้องใน **5 นาที**

### Workflow (5 Agents Parallel)

```
                    Main (Opus)
                        ↓
        ┌───────────────┼───────────────┐
        ↓               ↓               ↓
    Haiku 1         Haiku 2         Haiku 3
    (scan names)    (extract ID)    (match rules)

    ↓               ↓               ↓
    ┌───────────────┴───────────────┐
                    ↓
            Main: deduplicate
                    ↓
              Final Result
              5 full names ✅
```

### สิ่งที่เกิดขึ้น

**ก่อนใช้ multi-agent** (Sequential Opus):
- 40 นาที หาชื่อสกุล
- ต้องตรวจสอบไฟล์หลาย ครั้ง
- ผลลัพธ์ช้า

**หลังใช้ multi-agent** (5 Parallel Haiku):
- 2 นาที ได้ผลลัพธ์
- 5 perspectives พร้อมกัน
- ความแม่นยำ ✅

---

## ภาพแนวคิด: Parallel Agent Pattern

```
Input: 1,243 รายการข้อมูล

       ↙ Split ↘ (no dependencies)

    ├─ Haiku 1: Extract Names
    ├─ Haiku 2: Parse Dates
    ├─ Haiku 3: Match IDs
    ├─ Haiku 4: Deduplicate
    └─ Haiku 5: Verify

    (รัน parallel ~2 min)

       ↙ Collect ↘

    Main (Opus):
    - Synthesize results
    - Handle conflicts
    - Return final output

Output: 5 perfect names
        433 markdown files
        Complete knowledge graph ✅
```

---

## Key Principles

### ✅ ใช้ Parallel เมื่อ

1. **No dependencies** — ไฟล์ A ไม่ต้องรอ B
2. **Bulk work** — งาน 5+ ชิ้นขึ้นไป
3. **Same pattern** — ทุก agent ทำงาน similar
4. **Haiku enough** — งานไม่ต้องญาณ ultra-smart

### ❌ ใช้ Sequential เมื่อ

1. **Has dependencies** — B รอ A เสร็จ
2. **Complex decisions** — ต้อง Opus quality
3. **Main synthesis** — Main agent ต้องคิด
4. **Conflict resolution** — ต้องมนุษย์หรือ Opus ตัดสินใจ

---

## ปัญหาที่เจออย่างแท้จริง

### 1. Write Conflicts

```
Subagent A ← เขียน: daily/2025-12-13.md
Subagent B ← เขียน: daily/2025-12-13.md

ผลลัพธ์: Content ของ A หาย (last writer wins)
```

**วิธีแก้**: Prefix filenames
```
Subagent A → daily/haze_2025-12-13.md
Subagent B → daily/flood_2025-12-13.md
Main       → daily/INDEX.md (aggregate)
```

### 2. No Global Context

```
Haiku 1 → "วรรณพร" (name 1)
Haiku 2 → "Varnporn" (name 2)

ทั้งสองไม่รู้ว่า "วรรณพร" = "Varnporn"
```

**วิธีแก้**: Main agent deduplicate
```
Subagents → Create source-specific files
Main      → Build deduplication layer
           Check: "วรรณพร" ≈ "Varnporn"? ✅
```

### 3. Format Consistency

```
Haiku 1 → [[senders/Name]]
Haiku 2 → [Name]
Haiku 3 → # Name

Inconsistent across 433 files ❌
```

**วิธีแก้**: Explicit format in prompt
```
"Write links in this exact format:
[[senders/Display Name|ID]]
Use this format for ALL 433 files"
```

---

## Cost vs Speed Analysis

### Real Numbers (Dec 14, 2025)

| Approach | Time | Cost | Result |
|----------|------|------|--------|
| **Sequential** (1 Opus) | 14 min | $0.15 | ✅ |
| **Parallel** (7 Haiku) | 2 min | $0.05 | ✅ |
| **Savings** | 12 min faster | 67% cheaper | Same quality |

**Verdict**: Parallel = **6x faster + 67% cheaper**

---

## สรุป: เมื่อไหร่ใช้หลาย Agents

```
❌ โอเค ไม่ใช่ multi-agent task
   - งาน 1 ไฟล์เดียว
   - ต้อง complex logic
   - ต้องตัดสินใจ

✅ ใช่ multi-agent task
   - งาน 5+ files/items
   - pattern เดียวกัน
   - Haiku ทำได้
   - ไม่มี dependencies
```

### คำสอนสำคัญ

> **"ไม่ใช่ AI ต้องเร็วขึ้น แต่ใช้หลาย AI พร้อมกัน"**

เมื่อทำงาน bulk — อย่าถามว่า "AI ตัวนี้ทำได้ไหม" แต่ถาม **"ฉันใช้หลาย AI พร้อมกันได้ไหม"**

---

## บริบท: จาก Haiku ที่เรียนรู้

ระหว่างเดือนธันวาคม ฉันสร้าง 12 learning patterns เกี่ยวกับวิธีใช้ subagents:

1. **Subagent Delegation Pattern** — แจกงาน + ตรวจ (Dec 13)
2. **Parallel Vault Generation** — 433 ไฟล์ใน 2 นาที (Dec 14)
3. **10-Perspective Critique** — parallel review เพื่อหาจุดบ่อน (Dec 16)
4. **Soul-Init Pattern** — อ่านไฟล์กระจายแทน sequential (Dec 15)

ทั้งหมด converge ที่บทเรียนเดียว: **แจกงาน ไม่ใช่ batch**

---

*บทถัดไป: Agent Sync — วิธีให้ 5 agents ทำงานบน repo เดียว โดยไม่ชนกัน*
