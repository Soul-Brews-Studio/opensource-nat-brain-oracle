---
title: ## Calendar Visualization Pattern for Schedule Awareness
tags: [calendar, schedule, visualization, pattern, workflow]
created: 2026-01-07
source: Oracle Learn
---

# ## Calendar Visualization Pattern for Schedule Awareness

## Calendar Visualization Pattern for Schedule Awareness

When showing schedules, always include a visual ASCII calendar with annotations.

### The Pattern

```bash
# Generate calendar with current date
cal MM YYYY
```

Then annotate with events:

```
    January 2026      
Su Mo Tu We Th Fr Sa  
             1  2  3  
 4  5  6  7  8  9 10   ← TODAY (Wed 7)
11 12 13 14 15 16 17   ← CP(12) ✈️(13) Bitkub(14)
18 19 20 21 22 23 24   ← Workshop Boy(20+) Block Mtn(22-25)
25 26 27 28 29 30 31   ← Block Mtn(25) MIsD(28)
```

### Key Elements

1. **Visual calendar** - `cal` command output
2. **TODAY marker** - Show which day is today
3. **Event annotations** - Short labels on the right side
4. **Countdown** - "X days until [next event]!" at bottom
5. **Emoji markers** - ✈️ for flights, 🔥 for urgent

### When to Use

- `/fyi` schedule entries
- Track updates (010-january-travel-workshops.md)
- Session start (show upcoming week)
- Any schedule discussion

### Commands

```bash
# Current month
cal $(date +"%m %Y")

# Days until event
echo "$((( $(date -j -f "%Y-%m-%d" "2026-01-12" +%s) - $(date +%s) ) / 86400)) days until event"
```

### Why This Works

- Visual > text table for dates
- Shows context (weekdays, surrounding dates)
- Countdown creates urgency awareness
- Annotations prevent scrolling to table

---
*Added via Oracle Learn*
