---
title: Voice-Driven Development - Rust Camera App
tags: [voice, development, rust, camera, gesture, remote]
created: 2026-01-14
source: Hand tracker session from car
---

# Voice-Driven Development - Rust Camera App

## The Pattern

User in car (voice input) → AI implements on remote Mac → User tests and gives feedback

## What Worked

1. **Natural language commands**: "ภาพกลับด้านซ้ายขวา" → Mirror fix
2. **Quick iterations**: 4 builds in 13 minutes
3. **Immediate feedback**: "framerate slow" → Reduce resolution

## Technical Learnings

### Camera Resolution Matters
- Start with 640x480, not 1920x1080
- Lower resolution = faster processing
- Can always add high-res option later

### Skin Detection (Simple)
```rust
if r > 100 && g > 50 && b > 30 && r > g && r > b && (r - b) > 15
```
- Works in good lighting
- Fails with similar-colored backgrounds

### Gesture via Spread
- Spread = average distance of pixels from centroid
- Low spread (< 0.3) = fist (compact)
- High spread (> 0.5) = open hand (dispersed)

## Voice Development Tips

1. **Confirm understanding**: Repeat back the request
2. **Show progress**: "รันแล้ว! 640x480 @ 30fps"
3. **Quick feedback**: Build release, not debug
4. **Handle failures**: App closing? Explain why

## Limitations

- Can't see user's screen
- Shell resets after commands
- Background apps may close unexpectedly

---

*Learning captured: 2026-01-14 18:45*
