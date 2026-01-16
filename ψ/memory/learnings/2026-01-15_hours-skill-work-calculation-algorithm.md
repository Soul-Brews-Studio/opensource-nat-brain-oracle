# Work Hours Calculation: The "Eating While Thinking" Algorithm

**Date**: 2026-01-15
**Context**: Restoring and enhancing /hours skill for work analytics

## The Problem

Git commits show timestamps, but raw window (last - first commit) can show 22+ hours which seems unrealistic.

## Algorithm Evolution

| Version | Logic | Result | Issue |
|---------|-------|--------|-------|
| v1 | Window only | ~22h/day | Includes sleep |
| v2 | Subtract all gaps > 2h | ~8h/day | Too aggressive |
| v3 | Subtract all gaps > 6h | ~13h/day | Still misses some sleep |
| v4 (final) | Subtract biggest gap if > 4h | ~10h/day | Realistic |

## The Key Insight

> **"Eating while thinking = still working"**

Small breaks (meals, walks, reading) are NOT rest. Only real sleep (> 4h gap) should be subtracted.

## Implementation

```bash
# Find biggest gap between commits
BIGGEST=$(echo "$COMMITS" | awk '
NR==1 { split($1,a,":"); prev=a[1]*60+a[2]; next }
{
  split($1,b,":"); curr=b[1]*60+b[2]
  gap=curr-prev
  if (gap > max) max=gap
  prev=curr
}
END { print max+0 }')

# Only subtract if > 4h (240 min) = real sleep
if [ $BIGGEST -gt 240 ]; then
  SLEEP_MIN=$BIGGEST
else
  SLEEP_MIN=0
fi

WORK_MIN=$((WINDOW_MIN - SLEEP_MIN))
```

## Bash 3 Compatibility

macOS default = Bash 3, which doesn't support:
- `declare -A` (associative arrays)
- Some modern syntax

**Solution**: Use separate variables instead of associative arrays:
```bash
# Instead of: declare -A months
# Use:
DEC_WORK=0; DEC_DAYS=0
JAN_WORK=0; JAN_DAYS=0
```

## Activity Detection

Extract meaningful keywords from commit messages:
1. Convert to lowercase
2. Split into words
3. Filter stopwords (fix, update, add, docs, etc.)
4. Keep words >= 4 chars
5. Count frequency, show top 3

## Results

| Metric | Value |
|--------|-------|
| Total days | 38 |
| Total hours | 394.2h |
| Avg/day | 10.3h |
| Total commits | 1,691 |
| Top day | Jan 13 (18.0h) |

## Tags

#hours #analytics #git #algorithm #bash
