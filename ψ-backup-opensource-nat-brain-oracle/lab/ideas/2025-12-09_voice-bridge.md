# Voice Bridge App

**Status**: Idea
**Created**: 2025-12-09 12:15 (GMT+7)

---

## Timeline

| Time | Update |
|------|--------|
| 12:15 | Initial idea — Tauri app for voice-to-terminal |
| 12:20 | Moved to separate file for independent tracking |

---

## Concept

A desktop app that:
- Listens to voice continuously (background)
- Transcribes locally (no AI cost)
- Stores in local database
- Injects text into terminal seamlessly

---

## Architecture

```
┌────────────────────────────────────────────────────────┐
│              TAURI VOICE APP (always listening)        │
├────────────────────────────────────────────────────────┤
│  Voice → Speech-to-Text → Database (local)             │
│                    │                                   │
│                    ▼                                   │
│  Tagged by: tmux session / terminal pane               │
│  (lighter than per-conversation tagging)               │
│                    │                                   │
│                    ▼                                   │
│  Inject into terminal via:                             │
│    - AppleScript (macOS native)                        │
│    - tmux send-keys (direct to pane)                   │
└────────────────────────────────────────────────────────┘
```

---

## Why

- Current: Voice-to-text goes through AI (wastes tokens)
- Wanted: Capture voice locally, only send text to AI
- Benefit: Seamless voice workflow without AI transcription cost

---

## Tech Stack (TBD)

- **Framework**: Tauri (Rust + Web)
- **Speech-to-Text**: Local model (Whisper? Vosk?)
- **Database**: SQLite (local)
- **Injection**: AppleScript / tmux send-keys

---

## Related

- VibeVoice (Microsoft) — TTS, not STT, but related voice tech
- This repo's Oracle pattern — voice feeds into the system

---

## Next Steps

- [ ] Research local STT options (Whisper, Vosk, etc.)
- [ ] Prototype tmux send-keys injection
- [ ] Decide: separate repo or build here first?
