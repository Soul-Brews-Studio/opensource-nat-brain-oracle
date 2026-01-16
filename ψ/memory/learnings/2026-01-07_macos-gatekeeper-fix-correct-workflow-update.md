---
title: ## macOS Gatekeeper Fix - Correct Workflow (Updated)
tags: [macos, gatekeeper, xattr, dmg, read-only, quarantine]
created: 2026-01-07
source: Voice Tray v0.2.1 install fix 2026-01-07
---

# ## macOS Gatekeeper Fix - Correct Workflow (Updated)

## macOS Gatekeeper Fix - Correct Workflow (Updated)

**Problem**: "App is damaged and can't be opened" after download

**Wrong approach**: Running `xattr -cr` on app inside DMG
- DMG is read-only filesystem
- `xattr` fails with "Read-only file system" error

**Correct workflow**:
```bash
# 1. Copy to Applications first
cp -R "/Volumes/App Name/App.app" /Applications/

# 2. Then remove quarantine
xattr -cr "/Applications/App.app"

# 3. Open
open "/Applications/App.app"
```

**Root cause**: Unsigned/unnotarized app + Gatekeeper quarantine

**Permanent fix**: Sign with Apple Developer certificate ($99/year)

---
*Added via Oracle Learn*
