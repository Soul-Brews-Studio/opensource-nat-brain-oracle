---
title: ## Tauri Tray Icon Transparency Fix
tags: [tauri, imagemagick, transparency, tray-icon, png, alpha-channel, menu-bar]
created: 2026-01-03
source: Voice Tray v2 - Lips Icon Implementation
---

# ## Tauri Tray Icon Transparency Fix

## Tauri Tray Icon Transparency Fix

**Problem**: AI-generated icons from Antigravity often come as JPEG disguised as PNG with dark backgrounds, causing menu bar icons to show black squares instead of transparent outlines.

**Solution**: Use ImageMagick to extract white lines with transparency using brightness-based alpha:

```bash
magick "$SOURCE" -resize 32x32 \
  \( +clone -colorspace Gray -level 50%,100% \) \
  -alpha off -compose CopyOpacity -composite \
  PNG32:"$OUTPUT"
```

**Key insights**:
1. Check source file format: `file image.png` may reveal JPEG
2. Checkered background in viewer ≠ actual transparency
3. Use `-level 50%,100%` to threshold brightness for alpha channel
4. Icons embedded with `include_bytes!` require full rebuild (`bun tauri build`), not just `cargo build`

**Context**: Voice Tray v2 dynamic lips icon implementation (Jan 2026)

---
*Added via Oracle Learn*
