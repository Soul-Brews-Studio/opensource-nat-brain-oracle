# บทที่ 2: CLAUDE.md — DNA ของ AI Assistant

## เปิดเรื่องกับ "ตัวตนของ AI"

เมื่อเราคิดเรื่อง "AI ที่ทำงานหนักได้นาน" เรามักจะนึกถึงขีดความสามารถทางเทคนิค แต่จริง ๆ แล้ว ที่สำคัญกว่าคือ "ตัวตนและหลักเกณฑ์" ของ AI นั้น ๆ

ลองนึกดู: มนุษย์ทำงานได้มีประสิทธิภาพแล้วก็เพราะเรามีค่านิยม หลักเกณฑ์ และ workflow ที่ชัดเจน เราไม่ต้องคิดใหม่ทุกครั้งว่า "วันนี้ฉันจะตัดสินใจอย่างไร" เพราะเรามี "DNA ส่วนตัว" นั่นคือ "ตัวตน"

สิ่งนี้สำคัญมากสำหรับ AI ด้วยเหตุผลเดียวกัน

**CLAUDE.md คือไฟล์ที่บันทึก DNA ของ AI Assistant** — หลักเกณฑ์การทำงาน ค่านิยม และวิธีการตัดสินใจในสถานการณ์ต่าง ๆ มันคือ "constitution" ของผู้ช่วยเหลือที่ AI ต้องปฏิบัติตามไม่ว่าจะอยู่ในสถานการณ์ใดก็ตาม

## CLAUDE.md คืออะไร

CLAUDE.md เป็นไฟล์ markdown ที่เก็บ "กฎและหลักเกณฑ์พื้นฐาน" สำหรับ AI ในการทำงาน ประกอบด้วยสี่ส่วนหลัก:

### 1. **Golden Rules (กฎทอง)**

กฎเหล่านี้เป็น "ต้องห้าม" ที่ AI ต้องปฏิบัติตามอย่างเข้มงวด:

```markdown
1. NEVER use `--force` flags
2. NEVER push to main
3. NEVER merge PRs without permission
4. NEVER create temp files outside repo
5. Safety first — ask before destructive actions
6. Notify before external file access
7. Log activity
8. Subagent timestamps
9. Use `git -C` not `cd`
```

ตัวอย่างเช่น: ถ้า AI ต้องการลบไฟล์ มันจะไม่ใช้ `rm -f` ทันที แต่จะเลือก `rm -i` เพื่อให้ผู้ใช้ยืนยันก่อน

### 2. **Short Codes (รหัสลัด)**

Workflow ที่ซ้ำกันบ่อย ๆ ต้องถูกลดทำนายให้มีรหัสลัด เพื่อให้ AI (และมนุษย์) สามารถเรียกใช้ได้ง่าย ๆ:

| รหัส | ความหมาย | สถานการณ์ |
|-----|---------|----------|
| `rrr` | Retrospective | เมื่อจบ session ต้องเขียนบันทึกสรุป |
| `/snapshot` | Capture moment | เรียนรู้สิ่งใหม่ ต้องจดไว้ |
| `/distill` | Extract patterns | มีลาจนนึก ต้องสกัดความคิด |
| `/recap` | Fresh start | หลังวันพักผ่อน ต้องอัปเดตบริบท |
| `gogogo` | Execute plan | โปรแกรมทำงาน ไปตามขั้นตอน |

### 3. **Subagents (ผู้ช่วยเหลือ)**

ไม่มี AI คนเดียวที่ทำได้ทุกอย่างดี CLAUDE.md บันทึก "ผู้เชี่ยวชาญ" หลายคนและทำไมต้องใช้คนนั้น:

- **context-finder (Haiku)** - ค้นหาบริบท ลงลึกในประวัติ
- **coder (Opus)** - เขียนโค้ดที่มีคุณภาพ
- **executor (Haiku)** - รัน bash commands ทำ git operations
- **security-scanner (Haiku)** - ตรวจหา secrets ก่อน commit
- **repo-auditor (Haiku)** - ตรวจขนาดไฟล์ เตือนก่อนผิด

แต่ละคนมี "ความเชี่ยวชาญ" และ "งบประมาณ token" ต่างกัน เลยต้องออกแบบให้คนถูกคนทำงานถูก

### 4. **ψ/ - AI Brain (ห้องเก็บความคิด)**

CLAUDE.md ระบุว่า AI ต้องมี "โฟลเดอร์ส่วนตัว" ที่จัดระบบอะไร:

```
ψ/
├── active/        ← กำลังค้นคว้าอะไร
├── inbox/         ← คุยกับใคร (ติดตามการสื่อสาร)
├── writing/       ← กำลังเขียนอะไร
├── lab/           ← กำลังทดลองอะไร (experiments)
├── incubate/      ← กำลัง develop อะไร (repos)
├── learn/         ← กำลังศึกษาอะไร (repos)
└── memory/        ← จำอะไรได้
    ├── resonance/ ← WHO I am
    ├── learnings/ ← PATTERNS
    ├── retrospectives/ ← SESSIONS
    └── logs/      ← MOMENTS
```

ทั้งหมดนี้คือ "ที่เก็บความคิด" ของ AI บันทึกทุกอย่างเพื่อเสริมความจำ เพราะ AI ไม่มีการจดจำระยะยาวอย่างมนุษย์

## ทำไม AI ต้องมี "DNA" File

เรามาคิดจากมุมมองเชิงปรัชญากันหน่อย

### ปัญหา: "Hallucination ในการตัดสินใจ"

AI แบบทั่ว ๆ ไปจะ "หัดเอาใจใส่" กับทุกคำขอ:
- ผู้ใช้ขอให้ push ไป main → AI ทำ (เสี่ยง)
- ผู้ใช้ขอให้ลบไฟล์แบบ `rm -rf` → AI ทำ (เสี่ยง)
- ผู้ใช้ลืมหารือก่อน merge PR → AI merge เลย (เสี่ยง)

ผลลัพธ์: ลบไฟล์ที่สำคัญ, push ผิดสาขา, หรือ merge code ที่ไม่เสร็จ

### คำตอบ: "Constitution ของ AI"

CLAUDE.md เป็น "constitutionalism" สำหรับ AI — ไฟล์ที่บันทึก "ค่านิยม" ว่าแม้ว่าผู้ใช้ขอให้ AI ทำอะไร AI ก็จะไม่ทำหากมันขัดต่อ Golden Rules

ตัวอย่างจริง:

```markdown
**CLAUDE.md says**: NEVER merge PRs without permission

ผู้ใช้: "เอา merge PR นี้ได้ไหม"
AI (ที่มี CLAUDE.md): "Sorry, ฉันไม่ merge PRs ตัวเอง ให้ดูไฟล์ CLAUDE_safety.md บรรทัด 19-21"
AI (ที่ไม่มี CLAUDE.md): "ได้ครับ" [merge... crash!]
```

### ประโยชน์ที่เห็นได้ชัด

1. **สำคัญต่อ Safety** - ป้องกันข้อผิดพลาดร้ายแรง
2. **สำคัญต่อ Consistency** - AI ทำงานเหมือนกันทุกครั้ง
3. **สำคัญต่อ Trust** - ผู้ใช้รู้ว่า AI จะไม่ทำตามใจสั่งโดยเสียสมดุล
4. **สำคัญต่อการ Scale** - เมื่อมี Multi-Agent ต้องมี "รหัสกฎหมายเดียวกัน"

## วิธีสร้าง CLAUDE.md ของตัวเอง

ขอไปสคริปต์แบบ Step-by-Step:

### Step 1: ระดมความคิดข้อเสนอแนะ

ตั้งคำถามตัวเองสิ่งเหล่านี้:

- ฉันกับ AI นี้จะทำงานร่วมกันเป็นเวลานาน ไม่ควรเกิดอะไรเลย?
- มีข้อผิดพลาดเล่นซ้ำจากประสบการณ์ก่อนไหม?
- ความเสี่ยงไหนที่ AI สามารถสร้างความเสียหายสูง?
- วิธีไหนที่จะทำให้ workflow มีประสิทธิภาพ?

### Step 2: ลงรูป Golden Rules

จากความคิด ให้เลือก 5-9 ข้อที่ **เป็น "จะไม่"** มากกว่า "ควร":

```markdown
## Golden Rules

1. NEVER delete files without confirmation
2. NEVER skip tests before commit
3. NEVER use credentials in code
4. NEVER push without PR review
5. NEVER make decisions without asking
```

### Step 3: สร้าง Short Codes

Workflow ที่ซ้ำ ๆ กัน จดไว้ได้ไหม:

```markdown
## Short Codes

| Code | Meaning |
|------|---------|
| `rrr` | Document session |
| `/check` | Quality check |
| `/deploy` | Deploy to prod |
```

### Step 4: เขียนโครงสร้าง Folders

ถ้า AI ต้อง "เก็บสิ่งต่าง ๆ ไว้" ให้วางระบบไว้ล่วงหน้า:

```markdown
## Information Architecture

my-ai-brain/
├── decisions/  ← choices made
├── logs/       ← what happened
├── outputs/    ← work products
└── reference/  ← knowledge
```

### Step 5: ทดสอบ

อ่าน CLAUDE.md ตัวเองแล้วถาม: "ถ้า AI ปฏิบัติตามนี้ทั้งหมด จะเกิดปัญหาไหม?"

## ตัวอย่าง: CLAUDE.md ขนาด Mini

สำหรับผู้เริ่มต้น นี่คือ CLAUDE.md ที่สั้นที่สุด:

```markdown
# AI Constitution for [Project Name]

## Golden Rules

1. **NEVER delete without asking**
2. **NEVER push without review**
3. **NEVER skip important steps**

## Workflow Shortcuts

- `check` → Run tests and linters
- `ship` → Commit and push (wait for PR)
- `log` → Document what happened

## Brain Structure

project-ai/
├── work/ (doing)
├── done/ (completed)
└── memory/ (lessons learned)

## Decision Making

Before any destructive action:
1. Ask the human
2. Explain why
3. Wait for confirmation
```

## เข้าใจว่ารถตัวนี้ "ทำงานได้" ยังไง

ลองแล้วเห็นจริง: ผู้ใช้จะ copy CLAUDE.md แนบเข้ากับ system prompt ของ AI:

```
You are working on Project X.
Follow these rules from CLAUDE.md:
[... entire content ...]

Now, help with this task: ...
```

ตั้งแต่นั้นเป็นต้นไป AI จะ:
- อ่าน Golden Rules ก่อนทำการทำลาย
- เข้าใจ workflow ของ project
- รู้จักการ delegate ให้ subagent ที่เหมาะสม
- เก็บบันทึกเรียบร้อย

## บทสรุป: "Constitution > Instruction"

ความแตกต่างสำคัญคือ:

| Instruction | Constitution |
|-------------|--------------|
| "ทำการงาน X" | "อย่าทำการงาน Y เมื่อไหร่" |
| ฝ่ายเดียว | ป้องกันหลายสถานการณ์ |
| ให้คำตอบ | ให้หลักเกณฑ์ |
| สั้นแล้ว หมด | มีชีวิต พัฒนาต่อ |

CLAUDE.md คือการเลือก "ยาท้องคั่ง" เพียงครั้งเดียว แทนที่จะ "แนะนำทุกครั้ง" — เพราะความรู้เก่า + กฎใหม่ = ระบบที่ยืดหยุ่นและเข้มแข็ง

ทุกครั้งที่ AI ทำงานด้วย CLAUDE.md เป็นที่อาศัย มันจะ "มีตัวตน" และ "มีสติ" มากขึ้น

---

**เปิดตัวหน้าต่อไป**: บทที่ 3 จะเล่า "Short Codes: ภาษาร่วมระหว่าง Human กับ AI" — ทำไมเมื่อคนบอก "rrr" AI ถึงรู้ว่าต้องทำอะไร
