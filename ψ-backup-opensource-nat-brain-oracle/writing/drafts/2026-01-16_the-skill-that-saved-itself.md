---
date: 2026-01-16
type: blog
status: draft
topic: skill recovery, oracle philosophy, debugging
---

# The Skill That Saved Itself

*How a lost command recovered its own existence*

## The Hook

I'm writing this with a tool that didn't exist 20 minutes ago. Not because it was never created — it was. But Claude Code couldn't see it. The `/draft` skill was invisible, lost in the gap between what exists and what the system recognizes.

Then we found it. And here's the twist: we found it using the Oracle — a knowledge system that remembers what we've learned. The very philosophy that says "Nothing is Deleted" proved itself by recovering the skill that writes these words.

## The Story

### Day 1: The Mystery (January 16, morning)

The `/physical` skill was gone. It shows my location from FindMy data — useful for context-aware AI. But when I typed `/physical`, nothing happened. Claude Code acted like it never existed.

The files were there. The structure looked correct. But the skill was invisible.

### The Hunt (3 sessions, 24+ hours)

- **Session 1**: Checked SKILL.md format. Looked fine.
- **Session 2**: Verified frontmatter had `name:` and `description:`. Yes.
- **Session 2**: Added `trigger:` field like other skills. Nothing.
- **Session 3**: Finally used `/trace` to search Oracle.

The Oracle found a learning from January 10th:

> "Skills must be **folders** containing `SKILL.md`, NOT single files"

Not an exact match. But it pointed toward **structure issues**.

### The Breakthrough

I compared a working skill (`hours`) with my broken skill (`physical`):

```
hours:    drwxr-xr-x  (real directory)
physical: lrwxr-xr-x  (symlink!)
```

**There it was.**

Claude Code's skill discovery doesn't follow symlinks. It scans real directories only. My "convenient" symlink to keep skills in version control was making them invisible.

The fix:
```bash
rm ~/.claude/skills/physical
cp -r /path/to/skill ~/.claude/skills/physical
```

Immediately — no restart — `/physical` appeared.

### The Second Discovery

While celebrating, I realized: wait, where's `/draft`?

Same methodology:
1. Search git history: `git log --grep="draft"`
2. Found commit `62ed9c0f`: "feat: Add /draft skill"
3. Recovered content: `git show 62ed9c0f:.claude/skills/draft/skill.md`

**Second root cause**: The original used `skill.md` (lowercase). Claude Code expects `SKILL.md` (uppercase).

Two skills. Two different bugs. Same debugging pattern.

## The Insight

### The 7-Day Journey (Jan 10-16)

This wasn't my first skill debugging session. In the past week, I've discovered **four separate ways** Claude Code skill discovery can silently fail:

| Date | Issue | Silent Failure |
|------|-------|----------------|
| Jan 10 | Single file instead of folder | Skill doesn't appear |
| Jan 10 | Missing `name:` in frontmatter | Skill doesn't appear |
| Jan 15 | Plugin missing `skills[]` declaration | Skill doesn't appear |
| Jan 16 | Symlink instead of real directory | Skill doesn't appear |
| Jan 16 | Lowercase `skill.md` filename | Skill doesn't appear |

Notice the pattern? **Every failure looks the same.** The skill just doesn't show up. No error message. No hint. Nothing.

The only way to debug is:
1. Find something that works
2. Compare every detail
3. The difference is the answer

### The Meta-Story

Here's what makes this special: **the `/draft` skill I'm using to write this post was itself just recovered.**

Twenty minutes ago, this command didn't exist. Now it's being used to document its own resurrection. The skill that saves stories became part of its own story.

This is the Oracle philosophy in action: "Nothing is Deleted." The old skill wasn't gone — it was preserved in git history, waiting to be found. The debugging knowledge from January 10th wasn't wasted — it guided me toward structural issues today.

Every session adds to the knowledge base. What took 3 sessions to debug will take 3 minutes next time.

## The Pattern

### For Anyone Building Claude Code Skills

```
~/.claude/skills/your-skill/
└── SKILL.md    # UPPERCASE, not skill.md
```

**Requirements**:
1. Must be a **real directory** (not symlink)
2. Must contain `SKILL.md` (uppercase)
3. Frontmatter needs `name:` and `description:`

**When skills don't appear**:
1. Check if it's a symlink: `ls -la ~/.claude/skills/`
2. Check filename case: `SKILL.md` not `skill.md`
3. Check frontmatter fields
4. Compare with a working skill

### For Anyone Building Knowledge Systems

The Oracle approach:

```
Problem → Search past learnings → Find related knowledge
    ↓
Compare working vs broken → Identify difference
    ↓
Fix → Verify → Log to Oracle
```

Each debugging session extends the knowledge base. The investment compounds. What's hard to find today becomes instant tomorrow.

## The Invitation

I used to think "Nothing is Deleted" was about data preservation. Today I learned it's about **trust**.

Trust that your past learning isn't wasted. Trust that git history holds your work safe. Trust that the patterns you capture will guide you when you're stuck.

The `/draft` skill didn't save itself, exactly. But the system we've built — Oracle + git + accumulated learnings — created the conditions where recovery was possible.

What knowledge are you capturing? What patterns are you preserving for your future self?

---

## 🔮 Oracle Speaks

*The skill that writes these words was invisible 20 minutes ago. Now it exists, documents its own recovery, and will help create the next draft.*

*This is the loop: tools create knowledge, knowledge recovers tools, tools create more knowledge.*

*Nothing is deleted. Everything compounds.*

---

*Draft created via /draft*
*🕐 10:38 (Friday 16 January 2026)*
