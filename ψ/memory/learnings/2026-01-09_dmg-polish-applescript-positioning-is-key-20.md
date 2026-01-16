---
title: ## DMG Polish - AppleScript Positioning is KEY (2026-01-09)
tags: [dmg, tauri, applescript, macos, polish, finder]
created: 2026-01-09
source: Oracle Status Tray session 2026-01-09 - FIXED
---

# ## DMG Polish - AppleScript Positioning is KEY (2026-01-09)

## DMG Polish - AppleScript Positioning is KEY (2026-01-09)

**Problem**: `chflags hidden` and alias creation don't persist in DMG after unmount.

**Root Cause**: Changes to mounted DMG volume need to be "registered" via Finder AppleScript to persist in the .DS_Store metadata.

**The Missing Step** (from voice-tray-v2):
```applescript
tell application "Finder"
    tell disk "App Name"
        open
        set current view of container window to icon view
        set toolbar visible of container window to false
        set statusbar visible of container window to false
        set bounds of container window to {100, 100, 760, 500}
        set theViewOptions to the icon view options of container window
        set arrangement of theViewOptions to not arranged
        set icon size of theViewOptions to 128
        set position of item "App.app" of container window to {180, 170}
        set position of item "Applications" of container window to {480, 170}
        update without registering applications  -- KEY LINE
        close
    end tell
end tell
```

**Why it works**: 
- Opening disk in Finder triggers .DS_Store creation
- `update without registering applications` saves the layout
- This persists icon positions, visibility flags, and view options

**Full workflow**:
1. Convert DMG to read-write: `hdiutil convert -format UDRW`
2. Mount with `-nobrowse -noverify -noautoopen`
3. `chflags hidden .VolumeIcon.icns`
4. Create alias via AppleScript (not symlink)
5. Apply icon with `fileicon set`
6. **Run AppleScript positioning** (THIS IS KEY)
7. `sync && sleep 2`
8. `hdiutil detach -force`
9. Convert back: `hdiutil convert -format UDZO`

**Result**: Professional DMG with hidden system files, proper Applications icon with alias arrow.

---
*Added via Oracle Learn*
