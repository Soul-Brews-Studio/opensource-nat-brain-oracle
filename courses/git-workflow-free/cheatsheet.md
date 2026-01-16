# Git Cheatsheet - ฉบับ 3 คำสั่ง

> "แค่นี้ก็พอใช้กับ AI แล้ว"

---

## Setup (ทำครั้งเดียว)

```bash
# 1. ติดตั้ง Git
# Mac: brew install git
# Windows: Download from git-scm.com

# 2. ตั้งค่าตัวตน
git config --global user.name "ชื่อคุณ"
git config --global user.email "email@example.com"

# 3. Clone repo จาก GitHub
git clone https://github.com/username/repo.git
```

---

## Daily Workflow (3 คำสั่งเท่านั้น!)

```bash
# 1. เพิ่มไฟล์ทั้งหมด
git add .

# 2. บันทึกการเปลี่ยนแปลง
git commit -m "สิ่งที่ทำ"

# 3. ส่งขึ้น GitHub
git push
```

**แค่นี้จริงๆ!**

---

## Flow

```
AI สร้างโค้ด → git add . → git commit -m "msg" → git push → Done!
```

---

## Bonus Commands (ถ้าอยากรู้เพิ่ม)

| คำสั่ง | ทำอะไร |
|--------|--------|
| `git status` | ดูว่ามีอะไรเปลี่ยน |
| `git pull` | ดึงโค้ดล่าสุดจาก GitHub |
| `git log --oneline` | ดูประวัติ |

---

## ถ้าเจอปัญหา

| ปัญหา | วิธีแก้ |
|-------|--------|
| push ไม่ได้ | ลอง `git pull` ก่อน |
| ไม่รู้ว่าอยู่ตรงไหน | `git status` |
| อยากเริ่มใหม่ | Clone ใหม่ |

---

## Remember

> "ไม่ต้องกลัว ไม่มีอะไรพังง่ายๆ"
> "AI เขียนโค้ดให้ คุณแค่ push"

---

*Git Workflow for AI Builders - FREE Course*
*3 commands = add, commit, push*
