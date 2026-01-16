# Git "backup" Commit = Code Pre-existed

**Date**: 2025-12-22

## What We Learned

When you see a commit message like:
```
"backup floodboy fw"
```
...as an early commit (day 1-2 of repo), it means:

1. **Code existed BEFORE the repo was created**
2. **Git history ≠ project history**
3. **First commit date ≠ project start date**

## Pattern Detection

| Commit Message | Meaning |
|----------------|---------|
| `backup X` | Code existed, being tracked now |
| `initial commit` + lots of files | Migrated from elsewhere |
| `import from Y` | Came from another repo/system |

## How Things Connect

```
Real project start → [time passes] → Create git repo → "backup" commit
                                                         ↑
                                              This is NOT the start!
```

## Example: FloodBoy

```
2024-11-18: esphome-fw repo created
2024-11-19: "backup floodboy fw" commit  ← Day 2!
```

FloodBoy was already working firmware being backed up, not new code.

## Implication

When tracing project history:
1. Don't trust first commit date as project start
2. Ask the human: "When did this actually begin?"
3. Look for "backup", "import", "migrate" keywords

## Tags

`git-history` `project-timeline` `trace` `forensics`
