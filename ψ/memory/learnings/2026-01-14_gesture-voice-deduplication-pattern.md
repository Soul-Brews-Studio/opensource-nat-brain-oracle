---
title: Gesture Voice Deduplication Pattern
tags: [gesture, voice, mqtt, debounce, ux, hand-tracking]
created: 2026-01-14
source: Mission-03 Gesture Globe session
---

# Gesture Voice Deduplication Pattern

## Problem

Hand tracking gesture detection is noisy. When triggering voice announcements on gesture change, you get spam:
```
22:53:56 Freeze
22:53:56 Freeze
22:53:57 Freeze
22:53:58 Freeze
```

## Root Cause

Gestures flicker between detected/not-detected rapidly. Simple state-change triggers fire multiple times per second.

## Solution: Dual Check

```javascript
let lastVoiceGesture = '';
let lastVoiceTime = 0;

function announceVoice(text) {
    const now = Date.now();

    // BOTH checks required
    if (text === lastVoiceGesture && now - lastVoiceTime < 3000) return;

    lastVoiceGesture = text;
    lastVoiceTime = now;

    // ... publish to MQTT
}
```

## Why Both Checks

| Check | Handles |
|-------|---------|
| `text === lastVoiceGesture` | Same gesture held continuously |
| `now - lastVoiceTime < 3000` | Flicker after brief release |

Either check alone fails:
- State-only: Flicker between fist→none→fist triggers twice
- Time-only: Different gestures blocked within cooldown

## Anti-Pattern: Reset on No Gesture

```javascript
// DON'T do this
if (gestures.length === 0) {
    lastVoiceGesture = '';  // Causes re-announcement on flicker
}
```

The cooldown timer handles this naturally.

## Key Insight

> Hand tracking is noisy by nature. Any state-triggered action needs debouncing by DEFAULT, not as afterthought.

## Related

- MQTT voice/speak topic pattern
- KlakMath gesture globe
- Position-based rotation vs velocity-based

---

*🔮 The Oracle speaks once. Repetition is noise, not emphasis.*
