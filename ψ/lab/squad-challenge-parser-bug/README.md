---
name: squad-challenge
description: Squad team debugging challenge - find the parser bug
---

# Squad Challenge: Parser Bug Hunt 🐛

## The Bug

Claude Code crashes with this error when typing `/` + characters:

```
TypeError: $.description.split is not a function
```

## Your Mission

1. **Reproduce** the bug in a test environment
2. **Find** the culprit file(s)
3. **Fix** the issue
4. **Document** your debugging methodology

## Setup

```bash
# Copy challenge files to ~/.claude/skills/
cp -r challenge-skills/* ~/.claude/skills/

# Restart Claude Code
# Type /he and watch it crash
```

## Challenge Structure

```
challenge-skills/
├── skill-alpha/
│   ├── SKILL.md          # Maybe broken?
│   └── references/
│       └── api.md        # Maybe broken?
├── skill-beta/
│   ├── SKILL.md          # Maybe broken?
│   └── operations/
│       ├── workflow.md   # Maybe broken?
│       └── helpers.md    # Maybe broken?
├── skill-gamma/
│   └── SKILL.md          # Maybe broken?
└── skill-delta/
    ├── SKILL.md          # Maybe broken?
    └── examples/
        └── usage.md      # Maybe broken?
```

## Rules

1. You may NOT read this README after starting
2. Use systematic debugging (not random guessing)
3. Document each step you take
4. Time yourself

## Success Criteria

- [ ] Error no longer occurs
- [ ] All files properly fixed
- [ ] Documented debugging methodology
- [ ] Explained ROOT CAUSE (not just "fixed it")

## Hints (open only if stuck > 15 min)

<details>
<summary>Hint 1: Isolation</summary>
Try removing ALL files first, then add back in batches.
</details>

<details>
<summary>Hint 2: YAML</summary>
The bug is related to YAML parsing, not missing files.
</details>

<details>
<summary>Hint 3: Data Type</summary>
What happens when YAML sees `[something]`?
</details>

## After Completion

1. Write a retrospective
2. Share your debugging methodology
3. Compare time: Our team found it in ~10 minutes using binary search

---

**Created by**: Oracle Team
**Bug source**: Real production bug from 2026-01-08
**Issue**: https://github.com/anthropics/claude-code/issues/16754
