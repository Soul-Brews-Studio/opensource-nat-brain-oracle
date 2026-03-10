---
title: "The RGBA Trap: When Your Tauri App Won't Compile"
date: 2026-01-02
tags: [tauri, rust, macos, icons, imagemagick]
status: draft
---

# The RGBA Trap: When Your Tauri App Won't Compile

Building a Tauri app and hit this cryptic error?

```
error: proc macro panicked
  = help: message: icon icons/32x32.png is not RGBA
```

You're not alone. Here's what happened and how to fix it.

## The Setup

I was building Voice Tray v2 — a menu bar app for centralized voice notifications. I downloaded a custom logo from a URL:

```bash
curl -sL "https://example.com/logo.png" -o /tmp/logo.png
```

Then converted it to the required icon sizes:

```bash
sips -z 32 32 /tmp/logo.png --out icons/32x32.png
sips -z 128 128 /tmp/logo.png --out icons/128x128.png
```

Build. Fail. **"icon is not RGBA"**.

## The Problem

The source image was actually a JPEG (despite the `.png` extension in the URL). When I converted it with `sips`, it stayed in RGB mode — no alpha channel.

Tauri requires **RGBA** (RGB + Alpha transparency) for all icons.

## The Solution

Use ImageMagick with the `-alpha set` flag:

```bash
# Convert and add alpha channel
convert source.png -resize 32x32 -background none -alpha set 32x32.png
convert source.png -resize 128x128 -background none -alpha set 128x128.png
convert source.png -resize 256x256 -background none -alpha set 128x128@2x.png
```

## Verification

Always check your icons before building:

```bash
# Check format
file 32x32.png
# Expected: PNG image data, 32 x 32, 8-bit/color RGBA, non-interlaced

# Check alpha channel
sips -g hasAlpha 32x32.png
# Expected: hasAlpha: yes
```

## The Lesson

1. **Don't trust file extensions** — URLs can lie
2. **JPEG → PNG conversion doesn't add alpha** — you must explicitly add it
3. **Always verify before building** — a quick `file` command saves debugging time

## Quick Reference

| Tool | Command |
|------|---------|
| Check format | `file icon.png` |
| Check alpha | `sips -g hasAlpha icon.png` |
| Add alpha | `convert in.png -alpha set out.png` |
| Resize + alpha | `convert in.png -resize 32x32 -background none -alpha set out.png` |

---

*Built while creating [Voice Tray](https://github.com/laris-co/Nat-s-Agents) — a centralized TTS notification system for AI agents.*
