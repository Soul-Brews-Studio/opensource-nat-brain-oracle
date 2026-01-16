# DMG & App Icon Polish - Learnings

**Date**: 2026-01-03
**Context**: Voice Tray v2 icon update + DMG installer polish

---

## Tauri Icon Requirements

| Issue | Solution |
|-------|----------|
| JPEG disguised as PNG | Convert properly: `magick input.jpg PNG32:output.png` |
| "Not RGBA" error | Use `PNG32:` prefix or `-alpha on` flag |
| All sizes needed | 32, 128, 256, 512, 1024 + .icns + .ico |

```bash
# Convert JPEG to RGBA PNG for Tauri
magick source.jpg -resize 32x32 -alpha on PNG32:icons/32x32.png
```

---

## macOS DMG Polish

### Problem 1: .VolumeIcon.icns visible
```bash
chflags hidden "/Volumes/app-name/.VolumeIcon.icns"
```

### Problem 2: Applications folder broken icon
Symlinks don't show folder icon. Fix:

```bash
# 1. Remove symlink, create alias via AppleScript
rm "/Volumes/app-name/Applications"
osascript -e 'tell application "Finder" to make new alias file at disk "app-name" to folder "Applications" of startup disk'

# 2. Apply system Applications folder icon
brew install fileicon
fileicon set "/Volumes/app-name/Applications" /tmp/applications-icon.png
```

Where applications-icon.png comes from:
```bash
sips -s format png "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/ApplicationsFolderIcon.icns" --out /tmp/applications-icon.png
```

### DMG Edit Workflow
```bash
# 1. Convert to read-write
hdiutil convert app.dmg -format UDRW -o /tmp/app-rw.dmg
hdiutil attach /tmp/app-rw.dmg

# 2. Make fixes (icons, positions, hidden files)
chflags hidden "/Volumes/app/.VolumeIcon.icns"
# ... other fixes

# 3. Convert back to read-only compressed
sync
hdiutil detach "/Volumes/app"
hdiutil convert /tmp/app-rw.dmg -format UDZO -o app-fixed.dmg
```

---

## Tauri DMG Config

```json
{
  "bundle": {
    "macOS": {
      "dmg": {
        "appPosition": { "x": 180, "y": 170 },
        "applicationFolderPosition": { "x": 480, "y": 170 },
        "windowSize": { "width": 660, "height": 400 }
      }
    }
  }
}
```

Note: Tauri's default DMG bundler has issues - manual post-processing often needed.

---

## Key Insight

Professional DMG presentation requires manual fixes:
1. Hide system files (chflags hidden)
2. Replace symlink with alias + icon
3. Position items via AppleScript or config

The default Tauri DMG bundler creates functional but ugly installers.

---

**Tags**: tauri, dmg, macos, icons, imagemagick
