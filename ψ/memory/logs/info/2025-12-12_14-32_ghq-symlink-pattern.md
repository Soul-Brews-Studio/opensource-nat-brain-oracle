# Info: ghq + symlink pattern

**Time**: 2025-12-12 14:32
**Type**: info

---

ถ้ามี repo อยู่แล้วทำ symlink ดีไหม แต่ถ้ายังไม่มีเราก็ควรทำ symlink เพราะว่าเราใช้ ghq ในการโหลด repo - ลองเช็คดูก่อนว่ามันทำความเข้าใจกับมันก่อน

## Key Insights

- ghq จัดการ git repos ใน ~/Code/github.com/...
- ถ้า repo อยู่ที่อื่น ใช้ symlink เข้ามา
- ก่อนทำอะไรกับ external repo ควรเช็คว่า ghq track อยู่ไหม

---

*Context: การทำงานกับ claude-voice-notify repo ที่อยู่นอก Nat-s-Agents*
