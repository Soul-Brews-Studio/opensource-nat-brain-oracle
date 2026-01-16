---
title: ## DMG Polish COMPLETE SOLUTION - Tauri macOS (2026-01-09)
tags: [dmg, tauri, macos, polish, installer, applescript, finder, alias, symlink, VolumeIcon, fileicon, hdiutil]
created: 2026-01-09
source: Oracle Status Tray session 2026-01-09 - COMPLETE SOLUTION
---

# ## DMG Polish COMPLETE SOLUTION - Tauri macOS (2026-01-09)

## DMG Polish COMPLETE SOLUTION - Tauri macOS (2026-01-09)

**Search terms**: dmg polish, tauri dmg, macos installer, VolumeIcon hidden, Applications icon broken, symlink alias, professional dmg

---

**PROBLEM**: Tauri's default DMG looks ugly:
- `.VolumeIcon.icns` visible
- Applications folder shows broken/empty icon
- Changes don't persist after unmount

**ROOT CAUSE**: 
1. Symlinks don't inherit icons (need alias)
2. Changes to read-only DMG don't persist
3. Must use AppleScript to trigger .DS_Store save

**COMPLETE WORKFLOW**:
```bash
# 1. Convert to read-write
hdiutil convert "$DMG" -format UDRW -o /tmp/rw.dmg

# 2. Mount with nobrowse
hdiutil attach /tmp/rw.dmg -mountpoint "/Volumes/$NAME" -nobrowse -noverify -noautoopen

# 3. Hide system files
chflags hidden "/Volumes/$NAME/.VolumeIcon.icns"

# 4. Create alias (not symlink!)
osascript -e 'tell application "Finder" to make new alias file at POSIX file "/Volumes/$NAME" to folder "Applications" of startup disk'

# 5. Apply icon
fileicon set "/Volumes/$NAME/Applications" /tmp/applications-icon.png

# 6. KEY STEP - AppleScript positioning (triggers .DS_Store save!)
osascript <<EOF
tell application "Finder"
    tell disk "$NAME"
        open
        set current view of container window to icon view
        set icon size of icon view options of container window to 128
        set position of item "$NAME.app" of container window to {180, 170}
        set position of item "Applications" of container window to {480, 170}
        update without registering applications
        close
    end tell
end tell
EOF

# 7. Convert back to compressed
hdiutil detach "/Volumes/$NAME" -force
hdiutil convert /tmp/rw.dmg -format UDZO -o final.dmg
```

**KEY INSIGHT**: `update without registering applications` is the magic line that persists all visual changes!

**Reference**: voice-tray-v2/docs/blog-dmg-polish.md

---
*Added via Oracle Learn*
