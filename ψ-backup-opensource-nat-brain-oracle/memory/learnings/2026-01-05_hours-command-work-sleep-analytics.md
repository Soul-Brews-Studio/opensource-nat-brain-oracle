# /hours Command: Work + Sleep Analytics

**Date**: 2026-01-05

## What We Learned

### Git Log Gotchas

- `git log --reverse` may include commits from other days due to timezone edge cases
- **Fix**: Use `| sort | head -1` instead of `--reverse | head -1`
- `--date=format:'%H:%M'` is correct, NOT `--format="%H:%M"` (gives commit hash!)

### Sleep Detection from Commits

- Sleep = gap between last commit today → first commit tomorrow
- Works as **proxy** but not ground truth
- Real sleep data exists in Garmin (2,823 nights!)

### Brewing Day Concept

- 🍺 = dual meaning: actual beer brewing + ideas fermenting
- Detected when sleep gap > 12 hours
- Pattern: High intensity work → Brewing day → Better output

### Work Hours Calculation

- Window = End - Start (raw time range)
- Actual = Window - gaps > 2h (remove rest periods)
- Example: Jan 2 showed 23h window but 18h actual (5h sleep gap)

## Key Stats (Dec 9 - Jan 5)

| Metric | Value |
|--------|-------|
| Total work hours | ~323h |
| Average/day | ~11.5h |
| Total commits | 1,322 |
| Brewing days | 5 |
| Sleep average | ~9h (estimated) |

## How Things Connect

```
Git commits → Work hours estimate
     ↓
Garmin data → Actual sleep (ground truth)
     ↓
FusionSolar → Energy usage (brewing detection?)
     ↓
Holistic productivity view
```

## Next Steps

1. Integrate Garmin sleep into /hours (replace estimates)
2. FusionSolar scraper for energy patterns
3. Cross-correlate: sleep quality → commit volume

## Tags

`hours` `sleep` `analytics` `brewing` `garmin` `productivity`
