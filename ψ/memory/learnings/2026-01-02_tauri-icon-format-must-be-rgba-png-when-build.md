---
title: ## Tauri Icon Format: Must Be RGBA PNG
tags: [tauri, icons, rgba, png, imagemagick, macos]
created: 2026-01-02
source: Voice Tray v2 Development
---

# ## Tauri Icon Format: Must Be RGBA PNG

## Tauri Icon Format: Must Be RGBA PNG

When building Tauri apps, icons must be:
- PNG format with RGBA color mode (not RGB)
- Use `convert` (ImageMagick) with `-alpha set` flag
- Or ensure source has alpha channel

**Error**: `icon X is not RGBA` at compile time

**Fix**:
```bash
# ImageMagick
convert source.png -resize 32x32 -background none -alpha set output.png

# Verify
file output.png  # Should show "8-bit/color RGBA"
sips -g hasAlpha output.png  # Should be "yes"
```

**Common trap**: JPEG → PNG conversion loses alpha. Must explicitly add it.

---
*Added via Oracle Learn*
