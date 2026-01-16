# Handoff: Hand Tracker Rust - Camera + Gesture Complete

**Date**: 2026-01-14 19:41
**Context**: 84%
**Location**: BM's Home (Bang Phli) → In Car (voice commands)

## What We Did

### hand-tracker-mqtt (Rust)
- ✅ Camera capture with nokhwa (640x480)
- ✅ Horizontal mirror for selfie view
- ✅ Skin color detection
- ✅ Gesture detection (fist=zoom in, open=zoom out)
- ✅ Bounding box overlay (yellow)
- ✅ Skin pixels overlay (green dots)
- ✅ FPS display (~30 FPS)
- ✅ MQTT publishing to `hand/position`
- ✅ Published to Soul-Brews-Studio

### Repo
- **URL**: https://github.com/Soul-Brews-Studio/hand-tracker-mqtt
- **Latest commit**: `9688aa1` - FPS display, bounding box overlay, ONNX runtime

## Current Limitation

- Skin detection catches **face + hand** (not just hand)
- No ML model for proper hand pose detection (21 landmarks)
- Would need MediaPipe ONNX models for ml5.js-style detection

## Next Session Options

1. **Add MediaPipe ONNX** in Rust (~2-4 hours)
   - Palm detection + hand landmarks
   - Anchor decoding + NMS required

2. **Python bridge** (faster)
   - MediaPipe Python → MQTT → Rust receives
   - Easier to implement

3. **Browser ml5.js** → MQTT
   - Already have code from Graph3D session
   - Just needs MQTT subscriber in Rust

## Key Files

| File | Location |
|------|----------|
| Rust app | `~/Code/github.com/laris-co/hand-tracker-mqtt/` |
| Symlink | `ψ/incubate/hand-tracker-mqtt` |
| Palm model | `models/palm_detection_lite.onnx` |

## Run Commands

```bash
# Run hand tracker
~/Code/github.com/laris-co/hand-tracker-mqtt/target/release/hand-tracker-mqtt

# Subscribe to MQTT
mosquitto_sub -t "hand/position" -v
```

## Session Stats

- Duration: ~5 hours total (14:50 - 19:41)
- Voice-driven development from car
- Multiple rebuilds and iterations
- ~30 FPS achieved
