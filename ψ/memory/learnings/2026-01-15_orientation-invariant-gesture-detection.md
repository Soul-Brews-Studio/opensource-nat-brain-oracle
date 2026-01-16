# Lesson Learned: Orientation-Invariant Gesture Detection

**Date**: 2026-01-15
**Context**: MQTT hand tracking integration in Oracle 3D Graph
**Source**: Session retrospective

---

## The Pattern

When detecting gestures from hand tracking data (MediaPipe landmarks), **use distance-based metrics rather than position-based checks**.

### What Failed

```typescript
// Finger-curl detection (FAILED)
// Check if fingertip is below PIP joint
if (landmarks[tip].y > landmarks[pip].y) {
  curledCount++;
}
```

This approach fails because:
- Camera orientation varies (user might be above/below camera)
- "Below" in screen coordinates doesn't mean "curled" in hand space
- Palm orientation affects Y-axis relationship

### What Worked

```typescript
// Distance-based detection (WORKED)
function detectFist(landmarks) {
  const wrist = landmarks[0];
  const fingertips = [8, 12, 16, 20];

  let totalDist = 0;
  for (const tipIdx of fingertips) {
    const tip = landmarks[tipIdx];
    const dx = tip.x - wrist.x;
    const dy = tip.y - wrist.y;
    totalDist += Math.sqrt(dx * dx + dy * dy);
  }

  const avgDist = totalDist / fingertips.length;
  return avgDist < 0.22;  // Threshold found empirically
}
```

This works because:
- Distance is orientation-invariant
- Fist = fingertips close to wrist (regardless of camera angle)
- Simple Euclidean distance, no complex math needed

---

## The Generalization

For any gesture detection algorithm:

| Approach | Reliability | Why |
|----------|-------------|-----|
| Position-based (x > y) | Low | Camera/orientation dependent |
| Distance-based | High | Invariant to rotation |
| Angle-based | Medium | Requires more landmarks |

**Rule**: When detecting hand gestures, measure distances between landmarks, not positions in screen space.

---

## Related Pattern: Coordinate Mirroring

When displaying hand position on a mini-map:
- Hand tracking data is already mirrored for "selfie view"
- Displaying it needs un-mirroring: `displayX = 1 - handX`
- Camera control needs the mirrored data (feels natural)
- Visual feedback needs un-mirrored data (matches physical hand)

---

## Tags

`gesture-detection`, `mediapipe`, `hand-tracking`, `orientation-invariant`, `mqtt`
