---
title: ## DMG Polish Script - Working Solution (2026-01-07)
tags: [dmg, tauri, macos, fileicon, polish-script, working-solution]
created: 2026-01-07
source: Voice Tray v2 session 2026-01-07 - WORKING
---

# ## DMG Polish Script - Working Solution (2026-01-07)

## DMG Polish Script - Working Solution (2026-01-07)

**Problem**: Tauri DMG installer looks ugly with:
1. `.VolumeIcon.icns` visible
2. Applications symlink shows broken/empty icon
3. Icon positions sometimes wrong

**Working Solution** (`scripts/polish-dmg.sh`):

### Key Steps:
1. **Extract Applications icon first**:
   ```bash
   sips -s format png "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/ApplicationsFolderIcon.icns" --out /tmp/applications-icon.png
   ```

2. **Mount with `-nobrowse`** (prevents Finder auto-open):
   ```bash
   hdiutil attach "$DMG" -mountpoint "/Volumes/$NAME" -nobrowse -noverify -noautoopen
   ```

3. **Hide .VolumeIcon.icns**:
   ```bash
   chflags hidden "/Volumes/$NAME/.VolumeIcon.icns"
   ```

4. **Create alias (not symlink)** via AppleScript:
   ```bash
   osascript -e 'tell application "Finder" to make new alias file at POSIX file "/Volumes/$NAME" to folder "Applications" of startup disk'
   ```

5. **Apply icon with fileicon** (brew install fileicon):
   ```bash
   fileicon set "/Volumes/$NAME/Applications" /tmp/applications-icon.png
   ```

6. **Set positions via AppleScript** (THIS IS THE KEY STEP!):
   ```bash
   osascript <<EOF
   tell application "Finder"
       tell disk "$NAME"
           open
           set current view of container window to icon view
           set toolbar visible of container window to false
           set statusbar visible of container window to false
           set bounds of container window to {100, 100, 760, 500}
           set theViewOptions to the icon view options of container window
           set arrangement of theViewOptions to not arranged
           set icon size of theViewOptions to 128
           set position of item "$NAME.app" of container window to {180, 170}
           set position of item "Applications" of container window to {480, 170}
           update without registering applications
           close
       end tell
   end tell
   EOF
   ```
   **Why this is KEY**: Opening disk in Finder triggers .DS_Store creation.
   `update without registering applications` saves the layout and hidden flags!

7. **Convert DMG to read-write FIRST, then back to read-only**:
   ```bash
   hdiutil convert "$DMG" -format UDRW -o /tmp/rw.dmg  # Before changes
   # ... make changes ...
   hdiutil convert /tmp/rw.dmg -format UDZO -o final.dmg  # After changes
   ```

### Critical Lessons:
- **Always close Finder windows first** - prevents "resource busy"
- **Use `-nobrowse` flag** - prevents Finder from interfering
- **Symlinks don't show icons** - must use alias + fileicon
- **fileicon is essential** - `brew install fileicon`
- **Add cleanup trap** - `trap "rm -rf $TEMP_DIR" EXIT`

**Result**: Professional DMG with blue Applications folder + alias arrow, clean layout.

---
*Added via Oracle Learn*
