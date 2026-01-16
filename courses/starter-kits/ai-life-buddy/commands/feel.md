# /feel — Log Emotion

Log this feeling: $ARGUMENTS

## Instructions

1. Create a feeling log file at `ψ/memory/logs/feelings/[YYYY-MM-DD]_[HH-MM]_[emotion-slug].md`

2. Use this format:
```markdown
# Feeling: [emotion]

**Time**: [timestamp]
**Context**: [what you were doing, what triggered this]

## Notes
[Any additional context AI observes from current session]

## Pattern Check
[Does this match any previous patterns? Similar feelings before?]
```

3. Keep it brief but meaningful

4. If the emotion is strong (very tired, frustrated, excited), note the intensity

## Examples

Input: `/feel exhausted after deadline push`

Output file: `ψ/memory/logs/feelings/2026-01-08_16-30_exhausted.md`
```markdown
# Feeling: exhausted

**Time**: 2026-01-08 16:30
**Context**: After deadline push, worked late

## Notes
Session shows 6 hours of intensive work on workshop slides.

## Pattern Check
Similar to 2026-01-05 entry after overnight work session.
```

---

Input: `/feel excited about new idea`

Output file: `ψ/memory/logs/feelings/2026-01-08_16-45_excited.md`
```markdown
# Feeling: excited

**Time**: 2026-01-08 16:45
**Context**: New idea emerged during brainstorming

## Notes
Breakthrough moment in workshop design.

## Pattern Check
First "excited" log this week. Previous was 2026-01-03.
```
