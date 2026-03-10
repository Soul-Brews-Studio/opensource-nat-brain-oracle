# Idea: claude-voice-notify

**Status**: MIGRATED ✓
**Repo**: https://github.com/laris-co/claude-voice-notify (private)
**Issues**:
- #1 — Context/onboarding
- #2 — Vision: System tray + SQLite

---

## Migration Complete

Voice notification system fully moved to separate repo.

This project now uses **symlinks**:
```
scripts/
├── agent-start-notify.sh    → ~/Code/.../claude-voice-notify/scripts/
├── agent-complete-notify.sh → ~/Code/.../claude-voice-notify/scripts/
└── agent-voices.toml        → ~/Code/.../claude-voice-notify/scripts/
```

## Install in Other Projects

```bash
ln -s ~/Code/github.com/laris-co/claude-voice-notify/scripts ./scripts
```

## Future Vision (Issue #2)

Transform to system tray app with SQLite:
- Multi-project support (one app receives from all Claude sessions)
- Notification history in SQLite
- Proper speech queue
- Cross-platform (Linux/Windows)

Tech: Go + systray → Tauri
