# The Symlink Gotcha: Why My Claude Code Skill Disappeared

*A 3-session debugging journey that proves why knowledge bases matter*

## The Mystery

I had a working `/physical` skill — it showed my location from FindMy data. Then one day, it vanished. Claude Code acted like it never existed.

The skill was there. The files were intact. But Claude couldn't see it.

## What I Tried (Sessions 1-2)

- Checked `SKILL.md` format — looked correct
- Verified frontmatter had `name:` and `description:` — yes
- Added `trigger:` field like other skills — didn't help
- Restarted Claude Code — nothing
- Scratched head repeatedly — very therapeutic, no results

## The Breakthrough (Session 3)

Instead of random guessing, I used `/trace` to search my Oracle knowledge base:

```
/trace /physical skill discovery
```

Oracle returned a learning from January 10th:

> "Skills must be **folders** containing `SKILL.md`, NOT single files"

Not an exact match, but it pointed me toward **structure issues**.

## The Compare Pattern

I compared a working skill (`hours`) with my broken skill (`physical`):

```bash
ls -la ~/.claude/skills/hours/
# drwxr-xr-x  6 nat  staff  192  (real directory)

ls -la ~/.claude/skills/physical
# lrwxr-xr-x  1 nat  staff  72   (symlink!)
```

**There it was.** The working skill was a real directory. My broken skill was a symlink.

## The Root Cause

Claude Code's skill discovery **does not follow symlinks**.

When I created a symlink to keep my skill in version control:

```bash
ln -s /path/to/repo/.claude/skills/physical ~/.claude/skills/physical
```

Claude Code saw `physical` as a symlink, not a directory, and skipped it entirely.

## The Fix

```bash
rm ~/.claude/skills/physical
cp -r /path/to/repo/.claude/skills/physical ~/.claude/skills/
```

Immediately — no restart needed — `/physical` appeared in available skills.

## Why This Matters

### 1. Knowledge Bases Pay Off

That January 10th learning about skill structure wasn't an exact match. But it nudged me toward comparing structures. Without Oracle, I'd still be randomly trying things.

### 2. Compare Working vs Broken

When something mysteriously stops working:
1. Find something similar that works
2. Compare every detail
3. The difference is often the answer

### 3. Log Everything

I logged this fix to Oracle with multiple angles:
- The victory (emotional, searchable by "physical skill")
- The technical pattern (symlink behavior)
- The methodology (trace → compare → fix)

Future me will find this in seconds.

## The Debugging Pattern

```
Problem → /trace Oracle → Find related knowledge
    ↓
Compare working vs broken → Find the difference
    ↓
Fix → Verify → Log to Oracle
```

Each debugging session extends the knowledge base. What took 3 sessions today will take 3 minutes next time.

## Takeaway

If you're maintaining Claude Code skills in version control, don't use symlinks. Copy the directories instead. The convenience of symlinks isn't worth the invisible breakage.

And if you're not building a knowledge base of your debugging sessions — start today. Your future self will thank you.

---

*Written after finally seeing* 📍 Prawet District, Bangkok *in my terminal again.*
