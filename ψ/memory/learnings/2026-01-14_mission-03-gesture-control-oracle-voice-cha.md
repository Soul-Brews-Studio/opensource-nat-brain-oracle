---
title: ## MISSION-03: Gesture Control + Oracle Voice (Challenge Complete)
tags: [mission-03, gesture-control, squad-challenge, klakmath, oracle-voice, mqtt, mediapipe, three.js, transfer-learning]
created: 2026-01-14
source: MISSION-03 Challenge Session 2026-01-14
---

# ## MISSION-03: Gesture Control + Oracle Voice (Challenge Complete)

## MISSION-03: Gesture Control + Oracle Voice (Challenge Complete)

### What We Built (2026-01-14)

**Repo**: https://github.com/Soul-Brews-Studio/mission-03-gesture-control

**Challenge Structure**:
- Hand tracker (MediaPipe → MQTT)
- Gesture detector (landmarks → gesture names)
- 3D Globe visualizer (KlakMath sphere layout)
- Oracle Voice integration (MQTT → TTS)

### Key Features

1. **KlakMath Patterns**: xxhash, hashOnSphere for deterministic node placement
2. **Position-based Rotation**: Hand X position = rotation speed (farther from center = faster)
3. **Palm Size Zoom**: Distance from camera controls zoom
4. **Lightning Storm**: 15 ambient + 60 thunder-only lightnings
5. **Oracle Voice**: Two hands = Oracle awakens and speaks
6. **Voice Deduplication**: 3s cooldown prevents spam

### Transfer Learning Concepts

| Concept | From | Applied To |
|---------|------|------------|
| KlakMath | Oracle Graph3D | Gesture Globe |
| MQTT Voice | Voice Tray | Gesture announcements |
| Position-based control | Hand tracking | Globe rotation |
| Palm size detection | MediaPipe | Zoom control |

### Files to Implement (Students)

1. `gesture_detector.py` - detect_fist(), detect_open_palm(), detect_pinch(), detect_point(), detect_peace()
2. `visualizer/app.js` - handleGesture() switch cases

---
*Added via Oracle Learn*
