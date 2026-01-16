# 🎯 Squad Team Challenge #1: Make Your Claude Code Talk

**Subtitle**: Your first mission - set up Oracle Voice Tray and hear your AI assistant speak

**Tags**: claude-code, tauri, rust, voice-assistant, macos, text-to-speech, automation, squad-team, workshop

**Estimated read time**: 5 min

---

## The Challenge

Ever wanted your Claude Code to actually *talk* to you? Not just text - real voice notifications when tasks complete?

That's exactly what we're building in this first Squad Team challenge.

**Oracle Voice Tray** is a macOS menu bar app that gives your Claude Code agents a voice. When your AI finishes a task, you hear it. Simple as that.

![Oracle Voice Tray in menu bar](IMAGE: Screenshot of Oracle Voice Tray icon in macOS menu bar)

## What You'll Learn

- Setting up a Tauri 2.0 app from source
- Rust basics through a real project
- HTTP and MQTT protocols for app communication
- Claude Code hooks system

## The Mission

1. Clone the repo
2. Build and run Oracle Voice Tray
3. Send a voice message via HTTP
4. Integrate with your Claude Code setup

Full instructions: [MISSION-01-SETUP.md](https://github.com/Soul-Brews-Studio/oracle-voice-tray/blob/main/docs/MISSION-01-SETUP.md)

---

## Prompt for AI Assistant

Copy this prompt to Claude Code to get started:

```
I want to set up Oracle Voice Tray on my machine. This is a Tauri 2.0 menu bar app that provides text-to-speech for Claude Code agents.

Repository: https://github.com/Soul-Brews-Studio/oracle-voice-tray

Please help me:
1. Clone the repository
2. Install prerequisites (Rust, Node.js, platform-specific dependencies)
3. Build and run the app
4. Test the voice functionality
5. Integrate with my Claude Code setup

My operating system is: [macOS / Windows / Linux]

Guide me step by step and verify each step works before moving to the next.
```

![Claude Code terminal](IMAGE: Screenshot of Claude Code running the setup)

---

## Quick Test Commands

After installation, test with these:

```bash
# Check if app is running
curl http://127.0.0.1:37779/status

# Send a voice message
curl -X POST http://127.0.0.1:37779/speak \
  -H "Content-Type: application/json" \
  -d '{"text":"Hello from Squad Team!","voice":"Samantha","agent":"Test"}'

# Try different voices (macOS)
curl -X POST http://127.0.0.1:37779/speak \
  -d '{"text":"I am Daniel","voice":"Daniel"}'
```

![Terminal showing curl command](IMAGE: Screenshot of successful curl response)

---

## Success Criteria

- [ ] App appears in menu bar
- [ ] "Test Voice" button works
- [ ] `curl http://127.0.0.1:37779/speak` sends voice

## Bonus Challenges

| Level | Challenge | Difficulty |
|-------|-----------|------------|
| 2 | Full Claude Code hook integration | ⭐⭐ |
| 3 | MQTT connection with Mosquitto | ⭐⭐⭐ |
| 4 | Build your own polished DMG | ⭐⭐⭐ |
| 5 | Cross-platform support (Linux/Windows) | ⭐⭐⭐⭐ |

---

## Troubleshooting

### "App is damaged and can't be opened" (macOS)

```bash
# Copy to Applications first, then remove quarantine
cp -R "/Volumes/Oracle Voice Tray/Oracle Voice Tray.app" /Applications/
xattr -cr "/Applications/Oracle Voice Tray.app"
open "/Applications/Oracle Voice Tray.app"
```

### Port 37779 already in use

```bash
lsof -i :37779
kill -9 <PID>
```

---

## Share Your Journey

**Required**: Write about your experience on [Medium Soul Brews Studio Hub](https://medium.com/soul-brews-studio-hub).

เรียนฟรี แต่ช่วยกันส่งต่อความรู้ - Learn free, but share knowledge back.

---

## Resources

- [GitHub Issue #1](https://github.com/Soul-Brews-Studio/oracle-voice-tray/issues/1) - Challenge details
- [MISSION-01-SETUP.md](https://github.com/Soul-Brews-Studio/oracle-voice-tray/blob/main/docs/MISSION-01-SETUP.md) - Full setup guide
- [Tauri 2.0 Prerequisites](https://v2.tauri.app/start/prerequisites/) - Official docs
- [Medium Soul Brews Studio Hub](https://medium.com/soul-brews-studio-hub) - Submit your blog

---

# 🇹🇭 Thai Version / ภาษาไทย

## ความท้าทาย

เคยอยากให้ Claude Code พูดกับคุณจริงๆ ไหม? ไม่ใช่แค่ข้อความ - แต่เป็นเสียงแจ้งเตือนเมื่องานเสร็จ?

นั่นคือสิ่งที่เราจะสร้างใน Squad Team challenge แรกนี้

**Oracle Voice Tray** คือแอป menu bar บน macOS ที่ให้เสียงกับ Claude Code agents ของคุณ เมื่อ AI ทำงานเสร็จ คุณจะได้ยิน ง่ายแค่นั้น

## สิ่งที่จะได้เรียนรู้

- ตั้งค่าแอป Tauri 2.0 จาก source
- พื้นฐาน Rust ผ่านโปรเจคจริง
- HTTP และ MQTT protocols
- ระบบ Claude Code hooks

## Prompt สำหรับ AI Assistant

```
ผมต้องการติดตั้ง Oracle Voice Tray บนเครื่อง นี่คือแอป Tauri 2.0 menu bar ที่ให้ text-to-speech สำหรับ Claude Code agents

Repository: https://github.com/Soul-Brews-Studio/oracle-voice-tray

ช่วยผม:
1. Clone repository
2. ติดตั้ง prerequisites (Rust, Node.js, dependencies ตาม platform)
3. Build และรันแอป
4. ทดสอบ voice functionality
5. เชื่อมต่อกับ Claude Code setup ของผม

ระบบปฏิบัติการ: [macOS / Windows / Linux]

แนะนำทีละขั้นตอน และตรวจสอบว่าแต่ละขั้นตอนทำงานก่อนไปขั้นต่อไป
```

## เกณฑ์ความสำเร็จ

- [ ] แอปปรากฏใน menu bar
- [ ] ปุ่ม "Test Voice" ทำงาน
- [ ] `curl http://127.0.0.1:37779/speak` ส่งเสียงได้

## แชร์ประสบการณ์ของคุณ

**จำเป็น**: เขียนเกี่ยวกับประสบการณ์ของคุณบน [Medium Soul Brews Studio Hub](https://medium.com/soul-brews-studio-hub)

เรียนฟรี แต่ช่วยกันส่งต่อความรู้ 🚀

---

## Image Checklist (for publishing)

- [ ] Hero image: Oracle Voice Tray icon or menu bar screenshot
- [ ] Screenshot: Claude Code terminal running setup
- [ ] Screenshot: Successful curl response in terminal
- [ ] Screenshot: Voice Tray popup window with timeline
- [ ] Optional: GIF of voice notification in action
