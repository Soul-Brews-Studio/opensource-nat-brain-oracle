---
title: Web Audio API for Game Sounds
tags: [web-audio, game-dev, sound, html5]
created: 2026-01-16
source: Pluto game iteration 3
---

# Web Audio API for Game Sounds

## Basic Setup

```javascript
let audioCtx = null;

function initAudio() {
    if (audioCtx) return;
    audioCtx = new (window.AudioContext || window.webkitAudioContext)();
}

// Must init on user interaction (click/touch) due to autoplay policy
canvas.addEventListener('touchstart', () => initAudio());
```

## Sound Pattern: Oscillator + Gain

```javascript
function playSound() {
    const osc = audioCtx.createOscillator();
    const gain = audioCtx.createGain();
    osc.connect(gain);
    gain.connect(audioCtx.destination);

    const now = audioCtx.currentTime;

    // Configure
    osc.type = 'sine'; // sine, square, sawtooth, triangle
    osc.frequency.setValueAtTime(440, now);
    gain.gain.setValueAtTime(0.3, now);
    gain.gain.exponentialRampToValueAtTime(0.001, now + 0.5);

    osc.start(now);
    osc.stop(now + 0.5);
}
```

## Sound Recipes

| Sound | Type | Frequency | Technique |
|-------|------|-----------|-----------|
| Collect | sine | C-E-G arpeggio | Step frequency up |
| Explosion | sawtooth | 150→30 Hz | Ramp down + noise |
| Pour | triangle | 200-300 Hz | Random, short |
| UI click | sine | 300-400 Hz | Quick decay |

## Arpeggio Pattern

```javascript
osc.frequency.setValueAtTime(523, now);      // C5
osc.frequency.setValueAtTime(659, now + 0.1); // E5
osc.frequency.setValueAtTime(784, now + 0.2); // G5
```

## Explosion with Noise

```javascript
// Main tone - descending
osc.frequency.setValueAtTime(150, now);
osc.frequency.exponentialRampToValueAtTime(30, now + 0.3);

// Add noise burst (second oscillator)
const noise = audioCtx.createOscillator();
noise.type = 'square';
noise.frequency.setValueAtTime(80, now);
```

## Autoplay Policy

- Chrome/Safari block audio until user interaction
- Init AudioContext on first click/touch
- Resume if suspended: `audioCtx.resume()`
- Add sound toggle button for UX

## Performance Tips

- Create new oscillators per sound (they're cheap)
- Don't reuse oscillators (can only start once)
- Throttle frequent sounds (pour: 100ms interval)

---

*No external libraries needed — Web Audio API is built into browsers*
