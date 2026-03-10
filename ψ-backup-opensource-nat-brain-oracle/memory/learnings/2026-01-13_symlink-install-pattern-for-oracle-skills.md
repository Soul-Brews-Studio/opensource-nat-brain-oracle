---
title: Symlink Install Pattern for Oracle Skills
tags: [install, symlink, ghq, oracle-skills, workaround]
created: 2026-01-13
source: Plugin skill discovery debugging session
---

# Symlink Install Pattern for Oracle Skills

## The Problem
Plugin skill discovery doesn't work in Claude Code (as of Jan 2026).
Skills in `~/.claude/plugins/cache/*/skills/` are not auto-discovered.

## The Workaround
Symlink from plugin cache to `~/.claude/skills/` (global scope).

## Install Instructions (for any AI/machine)

### Step 1: Clone via ghq
```bash
ghq get -u Soul-Brews-Studio/oracle-proof-of-concept-skills
```

### Step 2: Create symlinks
```bash
POC=$(ghq root)/github.com/Soul-Brews-Studio/oracle-proof-of-concept-skills/skills
mkdir -p ~/.claude/skills

for skill in $POC/*/; do
  ln -sf "$skill" ~/.claude/skills/$(basename "$skill")
done
```

### Step 3: Restart Claude Code
Skills now available globally: `/trace`, `/recap`, `/rrr`, etc.

## One-liner
```bash
ghq get -u Soul-Brews-Studio/oracle-proof-of-concept-skills && \
for s in $(ghq root)/github.com/Soul-Brews-Studio/oracle-proof-of-concept-skills/skills/*/; do \
  ln -sf "$s" ~/.claude/skills/; \
done
```

## Update
```bash
cd $(ghq root)/github.com/Soul-Brews-Studio/oracle-proof-of-concept-skills
git pull
# Symlinks auto-update (point to same location)
```

## Why This Works
- `~/.claude/skills/` is global scope (all projects)
- Symlinks follow source updates
- ghq manages clone location consistently

## Skills Included (13)
trace, recap, rrr, learn, project, where-we-are, forward, context-finder, feel, fyi, standup, schedule, watch
