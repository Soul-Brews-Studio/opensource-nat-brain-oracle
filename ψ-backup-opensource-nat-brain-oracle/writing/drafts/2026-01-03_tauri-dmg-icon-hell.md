# The Tauri DMG Icon Hell — A Guide for Future AI

**Created**: 2026-01-03 09:50 GMT+7
**Status**: 📝 Draft
**Author**: Human + Claude Opus 4.5
**Target**: Future AI agents helping with Tauri/macOS app polish

---

## 🎯 TL;DR

Tauri's DMG bundler creates ugly installers. This guide shows how to fix:
1. App icons that fail with "not RGBA" errors
2. Hidden `.VolumeIcon.icns` showing in DMG
3. Applications folder showing as broken/empty icon

**Time to fix**: ~30 minutes if you know the steps, ~2 hours if debugging blind.

---

## 🔥 The Problem

You built a Tauri app. The icon looks great in Figma/Antigravity/whatever. You run `bun tauri build --bundles dmg` and get:

1. **Build fails**: `icon icons/32x32.png is not RGBA`
2. **DMG opens**: Shows `.VolumeIcon.icns` as visible file (ugly!)
3. **Applications folder**: Empty rounded rectangle instead of proper folder icon

The user opens your DMG and thinks "this looks amateur."

---

## 🛤️ The Journey

### Problem 1: "Not RGBA" Build Error

**What happened**: Source image was JPEG (even with .png extension). Tauri requires PNG with alpha channel.

**The trap**: ImageMagick's default PNG output isn't RGBA.

```bash
# WRONG - creates RGB PNG
magick source.jpg -resize 32x32 output.png

# RIGHT - forces RGBA
magick source.jpg -resize 32x32 -alpha on PNG32:output.png
```

**Full icon generation script**:
```bash
SRC="source-image.jpg"  # Can be JPEG or PNG
ICONS="src-tauri/icons"

# All required sizes with RGBA
magick "$SRC" -resize 32x32 -alpha on PNG32:"$ICONS/32x32.png"
magick "$SRC" -resize 32x32 -alpha on PNG32:"$ICONS/icon.png"
magick "$SRC" -resize 128x128 -alpha on PNG32:"$ICONS/128x128.png"
magick "$SRC" -resize 128x128 -alpha on PNG32:"$ICONS/icon_128x128.png"
magick "$SRC" -resize 256x256 -alpha on PNG32:"$ICONS/128x128@2x.png"
magick "$SRC" -resize 256x256 -alpha on PNG32:"$ICONS/icon_256x256.png"
magick "$SRC" -resize 512x512 -alpha on PNG32:"$ICONS/icon_512x512.png"
magick "$SRC" -resize 1024x1024 -alpha on PNG32:"$ICONS/icon_1024x1024@2x.png"

# macOS .icns (requires iconset folder)
mkdir -p /tmp/icon.iconset
magick "$SRC" -resize 16x16 -alpha on PNG32:/tmp/icon.iconset/icon_16x16.png
magick "$SRC" -resize 32x32 -alpha on PNG32:/tmp/icon.iconset/icon_16x16@2x.png
magick "$SRC" -resize 32x32 -alpha on PNG32:/tmp/icon.iconset/icon_32x32.png
magick "$SRC" -resize 64x64 -alpha on PNG32:/tmp/icon.iconset/icon_32x32@2x.png
magick "$SRC" -resize 128x128 -alpha on PNG32:/tmp/icon.iconset/icon_128x128.png
magick "$SRC" -resize 256x256 -alpha on PNG32:/tmp/icon.iconset/icon_128x128@2x.png
magick "$SRC" -resize 256x256 -alpha on PNG32:/tmp/icon.iconset/icon_256x256.png
magick "$SRC" -resize 512x512 -alpha on PNG32:/tmp/icon.iconset/icon_256x256@2x.png
magick "$SRC" -resize 512x512 -alpha on PNG32:/tmp/icon.iconset/icon_512x512.png
magick "$SRC" -resize 1024x1024 -alpha on PNG32:/tmp/icon.iconset/icon_512x512@2x.png
iconutil -c icns /tmp/icon.iconset -o "$ICONS/icon.icns"

# Windows .ico
magick "$SRC" -resize 256x256 -alpha on -define icon:auto-resize=256,128,64,48,32,16 "$ICONS/icon.ico"
```

---

### Problem 2: .VolumeIcon.icns Visible in DMG

**What happened**: Tauri creates this file but doesn't hide it. macOS shows it because the hidden flag isn't set.

**The fix**: Post-process the DMG.

```bash
# Convert DMG to read-write
hdiutil convert app.dmg -format UDRW -o /tmp/app-rw.dmg
hdiutil attach /tmp/app-rw.dmg

# Hide the icon file
chflags hidden "/Volumes/app-name/.VolumeIcon.icns"
chflags hidden "/Volumes/app-name/.fseventsd"
chflags hidden "/Volumes/app-name/.DS_Store"

# Convert back to read-only compressed
sync
hdiutil detach "/Volumes/app-name"
hdiutil convert /tmp/app-rw.dmg -format UDZO -o app-fixed.dmg
```

---

### Problem 3: Applications Folder Broken Icon

**What happened**: Tauri creates a symlink to /Applications. Symlinks don't inherit the folder's icon - they show as generic/broken.

**The trap**: Creating an alias via AppleScript doesn't automatically show the icon either.

**The solution**: Create alias + manually set icon using `fileicon` tool.

```bash
# Install fileicon if needed
brew install fileicon

# Mount DMG read-write (see above)

# Remove symlink, create proper alias
rm "/Volumes/app-name/Applications"
osascript -e 'tell application "Finder" to make new alias file at disk "app-name" to folder "Applications" of startup disk'

# Get system Applications folder icon
sips -s format png "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/ApplicationsFolderIcon.icns" --out /tmp/applications-icon.png

# Apply icon to alias
fileicon set "/Volumes/app-name/Applications" /tmp/applications-icon.png
```

---

## ✅ The Complete Fix Script

```bash
#!/bin/bash
# fix-tauri-dmg.sh - Run after `bun tauri build --bundles dmg`

APP_NAME="your-app-name"
DMG_PATH="src-tauri/target/release/bundle/dmg/${APP_NAME}_*.dmg"
DMG=$(ls $DMG_PATH | head -1)

echo "Fixing: $DMG"

# 1. Convert to read-write
rm -f /tmp/app-rw.dmg
hdiutil convert "$DMG" -format UDRW -o /tmp/app-rw.dmg
hdiutil attach /tmp/app-rw.dmg

VOLUME="/Volumes/$APP_NAME"

# 2. Hide system files
chflags hidden "$VOLUME/.VolumeIcon.icns" 2>/dev/null
chflags hidden "$VOLUME/.fseventsd" 2>/dev/null
chflags hidden "$VOLUME/.DS_Store" 2>/dev/null

# 3. Fix Applications folder icon
if [ -L "$VOLUME/Applications" ]; then
  rm "$VOLUME/Applications"
  osascript -e "tell application \"Finder\" to make new alias file at disk \"$APP_NAME\" to folder \"Applications\" of startup disk"

  # Get and apply icon
  sips -s format png "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/ApplicationsFolderIcon.icns" --out /tmp/applications-icon.png
  fileicon set "$VOLUME/Applications" /tmp/applications-icon.png
fi

# 4. Set icon positions via AppleScript
osascript <<EOF
tell application "Finder"
    tell disk "$APP_NAME"
        open
        set current view of container window to icon view
        set toolbar visible of container window to false
        set statusbar visible of container window to false
        set bounds of container window to {100, 100, 760, 500}
        set viewOptions to the icon view options of container window
        set arrangement of viewOptions to not arranged
        set icon size of viewOptions to 100
        set position of item "${APP_NAME}.app" to {180, 180}
        set position of item "Applications" to {480, 180}
        close
        open
        delay 1
        close
    end tell
end tell
EOF

# 5. Finalize
sync
hdiutil detach "$VOLUME"
rm "$DMG"
hdiutil convert /tmp/app-rw.dmg -format UDZO -o "$DMG"
rm /tmp/app-rw.dmg

echo "Done: $DMG"
```

---

## 🧠 The Pattern

### Key Insights

1. **Tauri's bundler is functional, not polished** - It creates working DMGs but they look amateur
2. **PNG32 prefix is magic** - ImageMagick needs explicit RGBA instruction
3. **Symlinks ≠ Aliases** - macOS treats them differently for icons
4. **fileicon tool is essential** - Brew install it, use it

### Tauri Config That Helps (But Doesn't Fully Fix)

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

This sets positions but doesn't fix the icon issues.

---

## 📖 Context for Future AI

### When User Says

| User Says | They Mean |
|-----------|-----------|
| "DMG looks ugly" | Hidden files showing, broken icons |
| "Icon not RGBA" | Need PNG32: prefix |
| "Applications folder broken" | Symlink → alias + fileicon |
| "Polish the installer" | Run the full fix script above |

### Time Estimates

| Task | Time |
|------|------|
| Generate all icon sizes | 2 min |
| Fix DMG (if you know steps) | 5 min |
| Debug from scratch | 1-2 hours |

### Dependencies

```bash
brew install imagemagick fileicon
```

---

## 🏷️ Tags

`tauri` `dmg` `macos` `icons` `imagemagick` `fileicon` `installer` `polish`

---

*From a 2-hour debugging session compressed into 5-minute fix.*
*Future AI: just run the script.*
