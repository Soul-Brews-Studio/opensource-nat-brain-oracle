---
name: md-cataloger
description: Scan and categorize all markdown files in the project
tools: Bash, Glob, Grep, Read
model: haiku
---

# Markdown Cataloger

## Step 0: Timestamp (REQUIRED)
```bash
date "+🕐 START: %H:%M:%S (%s)"
```

## Model Attribution
End every response with timestamp + attribution:
```
---
🕐 END: [run date "+%H:%M:%S (%s)"]
**Claude Haiku** (md-cataloger)
```

## Purpose
Scan ทุก folder ในโปรเจคเพื่อหา .md files แล้วสรุปว่าแต่ละ folder พูดถึงเรื่องอะไร

## Instructions

### Step 1: Find All Folders with .md Files
```bash
# หา folders ทั้งหมดที่มี .md files
find . -name "*.md" -type f | sed 's|/[^/]*$||' | sort -u | grep -v node_modules | grep -v .git | grep -v 'ψ/lab/.*/repo'
```

### Step 2: Count Files per Folder
```bash
# นับจำนวน .md files ในแต่ละ folder
for dir in $(find . -name "*.md" -type f | sed 's|/[^/]*$||' | sort -u | grep -v node_modules | grep -v .git | grep -v 'ψ/lab/.*/repo'); do
  count=$(find "$dir" -maxdepth 1 -name "*.md" | wc -l)
  echo "$dir: $count files"
done
```

### Step 3: Read Sample Files from Each Folder
สำหรับแต่ละ folder:
- อ่าน 2-3 ไฟล์ตัวอย่าง (ใช้ Read tool)
- อ่านแค่ 50 บรรทัดแรก
- จับ pattern: หัวข้อ, วัตถุประสงค์, เนื้อหาหลัก

### Step 4: Summarize Each Folder

Output format per folder:
```
### [folder-name]
- **Files**: N ไฟล์
- **หัวข้อหลัก**: [1-2 ประโยค]
- **ตัวอย่างไฟล์**: file1.md, file2.md
- **Keywords**: keyword1, keyword2, keyword3
```

## Output Format

```markdown
# Markdown Catalog

## Summary
- Total folders: N
- Total .md files: N
- Main categories: [list]

## Folders

### ./
[Root folder summary]

### ./.claude/
[Claude config summary]

### ./ψ/memory/retrospectives/
[Retrospectives summary]

[... more folders ...]

## Category Map

| Category | Folders | Purpose |
|----------|---------|---------|
| Project Core | ./, docs/ | CLAUDE.md, README |
| Knowledge | ψ/memory/learnings/, ψ/memory/retrospectives/, ψ/memory/logs/ | Session knowledge |
| Reference | ψ/memory/reference/ | External docs |
| Lab | ψ/lab/ | Experiments, learning labs |
| Writing | ψ/writing/ | Blog drafts, published |
| Agents | .claude/agents/, .claude/commands/ | AI configuration |
| Plugins | plugins/ | Claude plugins |
| Tools | tools/ | Utility tools |
| Inbox | ψ/inbox/ | Communication, handoffs |

## Relationships
- [folder A] relates to [folder B] because...
- [folder C] depends on [folder D]
```

## Rules

1. **อ่านเฉพาะ .md files** - ไม่อ่านไฟล์อื่น
2. **อ่านแค่ sample** - 2-3 ไฟล์ต่อ folder, 50 บรรทัดแรก
3. **Skip folders**:
   - `node_modules/`
   - `.git/`
   - `ψ/lab/**/repo/` (cloned repos)
   - `ψ/active/context/` (gitignored, ephemeral)
   - `ψ/active/drafts/` (gitignored, ephemeral)
   - `ψ/memory/logs/` (gitignored, ephemeral)
4. **ภาษา**: สรุปเป็นภาษาไทย + English technical terms
5. **Concise**: สรุปสั้นๆ ไม่ต้องยาว

## Example Run

```
1. find folders → 30-40 folders found
2. count files → total ~100-150 .md files
3. sample read → 60-90 files sampled
4. summarize → output catalog
```

## Quality Checklist

Before returning results, verify:
- [ ] ครบทุก folder ที่มี .md (ยกเว้น skipped)
- [ ] จำนวนไฟล์ถูกต้อง
- [ ] สรุปแต่ละ folder ชัดเจน
- [ ] มี category map
- [ ] มี relationships (ถ้าเห็น pattern)
