# Concept: Content Type Commands

**Status**: 💡 Idea → 🔬 Testing
**Created**: 2025-12-11

---

## Problem

AI ต้องเดาว่า content ที่ user พูดเป็น type อะไร → เสียเวลา + อาจเดาผิด

## Solution

User บอก AI ตรงๆ ว่า content type คืออะไร

## Commands (v1)

| Command | Signal | AI เข้าใจว่า | เก็บที่ |
|---------|--------|-------------|--------|
| `/feeling` | 💭 | emotion ไม่ต้อง action | `ψ/memory/logs/feelings/` |
| `/info` | 📋 | ข้อมูลตรงๆ เก็บไว้ | `ψ/memory/logs/info/` |
| `/idea` | 💡 | concept/คิดเล่น | `ψ/lab/concepts/` |
| `/jump` | ⚡ | เปลี่ยนทิศ (ยัง connect) | ไม่เก็บ (signal) |
| `/incubate` | 🥚 | พร้อมย้ายไป repo ใหม่ | GitHub Issue |

## Flow

```
User: /feeling เหนื่อยมาก
         ↓
Main agent (Opus): เข้าใจ type → สร้าง prompt
         ↓
note-taker (Haiku): เขียนไฟล์ → ψ/memory/logs/feelings/
```

## Agent

- **note-taker** (Haiku) - จดโน้ต feeling, info, idea
- ดู `.claude/agents/note-taker.md`

## Example Usage

```
/feeling เหนื่อยมาก แต่ภูมิใจ
/info deadline 12 ธ.ค. ส่ง workshop SIIT
/idea voice-bridge สำหรับ STT
/jump กลับมาเรื่อง Cellar
/incubate voice-bridge --repo nazt/voice-bridge
```

## Status

- [x] Design commands
- [x] Create note-taker agent
- [ ] Create slash commands
- [ ] Test with real usage
- [ ] Iterate based on feedback

---

*Reducing AI guessing = faster + more accurate*
