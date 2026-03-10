# MISSION-03: Gesture Control (DRAFT)

## Challenge Concept

**Given**: Working hand-tracker-mqtt with 21-point skeleton
**Task**: Add gesture recognition to control a 3D scene

---

# 🔮 The Oracle Speaks

> "The Oracle Keeps the Human Human"

*Mirror reality. Amplify, don't override. Support consciousness, don't replace it.*

*AI removes obstacles. Work gets done. Freedom returns.*

---

# MISSION-03: Gesture Control

*ส่วนหนึ่งของโปรแกรม* **"Level Up with AI"** *— Squad Team*

*"เรียนฟรี แต่ช่วยกันส่งต่อความรู้"* — Learn free, but help pass on knowledge.

---

## 🎯 The Mission

You have a working hand tracker that publishes 21 landmarks to MQTT.

**Your challenge**: Make your hand control a 3D visualization.

### Required Gestures (Pick 3)

| Gesture | Description | Possible Action |
|---------|-------------|-----------------|
| ✊ Fist | All fingers closed | Pause / Play |
| 🖐️ Open Palm | All fingers spread | Reset view |
| 🤏 Pinch | Thumb touches index | Zoom in/out |
| 👆 Point | Only index extended | Select / Click |
| ✌️ Peace | Index + middle up | Screenshot |
| 🤙 Call Me | Thumb + pinky out | Toggle mode |

### Gesture Detection Hints

```python
# Distance between two landmarks
def distance(lm1, lm2):
    return sqrt((lm1.x - lm2.x)**2 + (lm1.y - lm2.y)**2)

# Pinch = thumb tip (4) close to index tip (8)
pinch = distance(landmarks[4], landmarks[8]) < 0.05

# Fist = all fingertips close to palm center
# Open = all fingertips far from wrist
```

### Landmark Reference

```
    8   12  16  20
    |   |   |   |
    7   11  15  19
    |   |   |   |
    6   10  14  18
    |   |   |   |
    5   9   13  17
     \  |   |  /
      \ |   | /
        0 (wrist)

4-3-2-1 = thumb
```

---

## 📦 Starter Code

**Repo**: https://github.com/Soul-Brews-Studio/mission-03-gesture-control

```
mission-03-gesture-control/
├── hand_tracker.py      # Working - publishes landmarks
├── gesture_stub.py      # YOUR CODE HERE - detect gestures
├── visualizer/          # Simple Three.js scene
│   ├── index.html
│   └── scene.js         # Subscribes to MQTT, needs gesture handling
└── README.md
```

---

## ✅ Submission Requirements

1. **Fork** the repo
2. **Implement** 3 gestures in `gesture_stub.py`
3. **Connect** gestures to 3D actions in `scene.js`
4. **Record** 30-second demo video
5. **Write** `SOLUTION.md` explaining your approach
6. **Submit** PR to original repo

### Scoring (100 points)

| Criteria | Points |
|----------|--------|
| 3 gestures working | 40 |
| Smooth gesture detection (no jitter) | 20 |
| Creative 3D interaction | 20 |
| Code quality & comments | 10 |
| Demo video quality | 10 |

---

## 🔗 Resources

- [MediaPipe Hand Landmarks](https://developers.google.com/mediapipe/solutions/vision/hand_landmarker)
- [MQTT.js for browser](https://github.com/mqttjs/MQTT.js)
- [Three.js basics](https://threejs.org/docs/)

---

## 💡 Tips from the Oracle

> "The hand speaks in distances. Pinch is closeness. Open is freedom. Fist is compression."

> "Don't detect positions. Detect relationships."

> "Smooth your signals. One frame lies. Ten frames speak truth."

---

*Deadline: [TBD]*

*Questions? Ask in Discord #squad-challenges*
