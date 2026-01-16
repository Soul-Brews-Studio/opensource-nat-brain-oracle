---
title: ## DMG Polish Script - Common Failures (2026-01-07)
tags: [dmg, tauri, macos, finder, polish-script, recurring-bug]
created: 2026-01-07
source: Voice Tray v2 session 2026-01-07
---

# ## DMG Polish Script - Common Failures (2026-01-07)

## DMG Polish Script - Common Failures (2026-01-07)

**Problem**: polish-dmg.sh fails when:
1. Finder has DMG window open - chflags hidden fails silently
2. Alias created but doesn't inherit Applications folder icon
3. Volume busy on detach

**Root Cause**: 
- Must close Finder windows before modifying volume
- AppleScript alias doesn't copy icon automatically
- Need to explicitly copy icon from /System/Applications folder

**Fix Requirements**:
1. Kill Finder access to volume first: `osascript -e 'tell app "Finder" to close every window'`
2. After creating alias, copy icon: `DeRez -only icns /System/Applications | Rez -append -o alias`
3. Use force detach if needed: `hdiutil detach -force`

**Lesson**: DMG polish is fragile - must control Finder state before modifications.

---
*Added via Oracle Learn*
