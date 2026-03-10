# Info: n8n AI Agent Tutorial (CodeBangkok)

**Time**: 2026-01-08 10:30
**Type**: info

---

## Video Summary: "n8n - AI Agent" by CodeBangkok

### Overview
n8n (Node Automation) - Low Code tool for Workflow Automation ช่วยลดงาน Backend, Security, API ให้เหลือแค่โฟกัส Logic และการเชื่อมต่อ AI

### 3 Phases ของ AI Solution
1. **Build** - สร้าง Workflow
2. **Deploy** - นำขึ้น Production
3. **Operate** - ดูแลและ Monitor ระบบ

### AI Agent Setup (3 ส่วนหลัก)

#### 1. Chat Model (สมอง)
- เลือก LLM provider (OpenAI, Gemini)
- API Key: OpenAI หรือ Gemini มี Free Tier
- ค่าใช้จ่ายคิดตาม Token - เลือก Model ให้เหมาะกับงาน

#### 2. Memory (ความจำ)
- LLM เป็น Stateless โดยธรรมชาติ
- ต้องเพิ่ม Node Memory (Simple Memory)
- กำหนด Context Window Length (จำนวนข้อความย้อนหลัง)

#### 3. Tools (เครื่องมือ)
- **Time Tool** - ตอบเรื่องเวลาปัจจุบัน
- **Google Search (SerpAPI)** - ค้นหาข้อมูล Real-time
- **Gmail** - ส่งอีเมล (ต้อง OAuth2)
- **HTTP Request** - เชื่อมต่อ API ภายนอก (เช่น Weather API)

### Timestamps สำคัญ
- [00:00] แนะนำ n8n
- [03:34] สร้าง Trigger
- [08:16] เพิ่ม AI Agent Node
- [23:43] Memory setup
- [41:29] Tools setup
- [32:08] Deploy
- [45:20] Operate (Executions/Logs)

---

*Context: Video summary/notes from CodeBangkok YouTube tutorial on n8n AI Agent Low Code automation*
*Source: https://www.youtube.com/watch?v=A9MFuu8FJ3w*
