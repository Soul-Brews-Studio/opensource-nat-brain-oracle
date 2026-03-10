---
title: ## Oracle Voice Tray - GitHub Download & Install Workflow
tags: [oracle-voice-tray, github, download, install, macos, gatekeeper, workflow]
created: 2026-01-07
source: Voice Tray install session 2026-01-07 - WORKING
---

# ## Oracle Voice Tray - GitHub Download & Install Workflow

## Oracle Voice Tray - GitHub Download & Install Workflow

**Tested and Working** (2026-01-07)

### One-Liner Install Command
```bash
curl -L -o ~/Downloads/Oracle-Voice-Tray.dmg "https://github.com/Soul-Brews-Studio/oracle-voice-tray/releases/download/v0.2.1/Oracle-Voice-Tray-v0.2.1.dmg" && \
hdiutil attach ~/Downloads/Oracle-Voice-Tray.dmg -nobrowse && \
cp -R "/Volumes/Oracle Voice Tray/Oracle Voice Tray.app" /Applications/ && \
xattr -cr "/Applications/Oracle Voice Tray.app" && \
open "/Applications/Oracle Voice Tray.app"
```

### Step-by-Step
1. **Download**: `curl -L -o ~/Downloads/Oracle-Voice-Tray.dmg <github-release-url>`
2. **Mount**: `hdiutil attach ~/Downloads/Oracle-Voice-Tray.dmg -nobrowse`
3. **Copy**: `cp -R "/Volumes/Oracle Voice Tray/Oracle Voice Tray.app" /Applications/`
4. **Remove quarantine**: `xattr -cr "/Applications/Oracle Voice Tray.app"`
5. **Open**: `open "/Applications/Oracle Voice Tray.app"`

### Key Points
- DMG is **read-only** - must copy to Applications first
- `xattr -cr` removes Gatekeeper quarantine (app is unsigned)
- `-nobrowse` flag prevents Finder from auto-opening DMG
- App runs in **menu bar** (tray icon)

### Test After Install
```bash
curl -X POST http://127.0.0.1:37779/speak \
  -H "Content-Type: application/json" \
  -d '{"text":"Install successful!","agent":"Test"}'
```

**Release URL**: https://github.com/Soul-Brews-Studio/oracle-voice-tray/releases/tag/v0.2.1

---
*Added via Oracle Learn*
