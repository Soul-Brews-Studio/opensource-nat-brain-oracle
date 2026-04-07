# Scripts Directory — Distilled

> Distilled 2026-03-11 from scripts/ root (14 files: 8 shell scripts, 2 AppleScripts, 1 Python, 3 symlinks/config)
> Note: scripts/prompts/ subdirectory NOT included (separate distillation target)

---

## Overview

Shell scripts for the Oracle/Nat-s-Agents ecosystem. Two main categories:
1. **Antigravity image generation** — automating prompt sending to Antigravity AI app
2. **Project management** — repo creation, incubation, team logging

All scripts reference macOS paths (`/Users/nat/...`) and use macOS-specific tools (osascript, cliclick).

---

## Antigravity Scripts (Image Generation Pipeline)

### antigravity-auto.sh
Infinite loop auto-generator for sending visual prompts to Antigravity app.
```bash
# Usage: ./scripts/antigravity-auto.sh [start_num] [interval_seconds]
# Default: start=301, interval=90s, end=400
# Flow: Find prompt file -> extract prompt text -> send via osascript -> wait interval -> log
# Key function: extract_prompt() — parses markdown for prompt section between headers/backticks
# Skips already-generated images (checks results/*.png)
# Logs to: ψ/memory/logs/antigravity.log
```

### antigravity-tmux.sh
Wrapper to run antigravity-auto.sh in detached tmux session.
```bash
# Usage: ./scripts/antigravity-tmux.sh [start_num]
# Creates session "antigravity-gen" with 5-min intervals
# Commands: tmux attach -t antigravity-gen | tmux kill-session -t antigravity-gen
```

### antigravity-remind.sh
Sends reminder to Antigravity every 5 minutes to continue MASTER-AUTO.md generation (086-210 range).

### create-slides-antigravity.sh / open-project-antigravity.sh
Simple wrappers: read prompt from scripts/prompts/*.txt, send via osascript.

### send-antigravity (shell) + send-to-antigravity.scpt (AppleScript)
The core send mechanism:
```applescript
-- AppleScript flow:
-- 1. Set clipboard to prompt text
-- 2. Activate Antigravity app
-- 3. Click middle of window (cliclick)
-- 4. Cmd+L to focus AI chat box
-- 5. Cmd+V to paste, Return to send
```

### 3 Symlinks (broken on Linux — macOS paths)
- agent-complete-notify.sh -> claude-voice-notify scripts
- agent-start-notify.sh -> claude-voice-notify scripts
- agent-voices.toml -> claude-voice-notify config

---

## Project Management Scripts

### project-create.sh
```bash
# Usage: project-create.sh <name> [--public]
# Flow: gh repo create laris-co/<name> -> ghq get -> symlink to ψ/incubate/ -> register slug
# Creates: GitHub repo + local clone + symlink + slug entry in ψ/memory/slugs.yaml
```

### project-incubate.sh
```bash
# Usage: project-incubate.sh <url-or-path> [slug]
# Accepts: GitHub URL, local path, or ~ path
# Flow: ghq get (if URL) -> symlink to ψ/incubate/repo/github.com/<org>/ -> register slug
# Idempotent: checks for existing symlinks and slug registrations
```

### team-log.sh
```bash
# Usage: ./team-log.sh [person] [type] [content]
# Persons: bm, ampere
# Types: schedule, request, note, remind, buy
# Creates: ψ/team/<person>/logs/<timestamp>_<type>.md with frontmatter
# Features: collision avoidance (counter suffix), color output, type validation
# Example: ./team-log.sh ampere buy "นม ไข่ ขนมปัง"
```

### maw-peek.sh
```bash
# Multi-Agent Worktree status checker
# Scans agents/1-5 worktrees, shows: branch, hash, last commit
# Output: markdown table format
# Path: /Users/nat/Code/github.com/laris-co/Nat-s-Agents
```

---

## Utility Scripts

### organize_prompts.py (Python, 280 lines)
Organizes visual prompts from ψ/writing/slides into individual files in scripts/prompts/.
- Handles 3 source formats: consolidated MD, individual MD with frontmatter, directory batches
- Creates standardized files: `antigravity-NNN-slug.md`
- Key functions: `slugify()`, `extract_consolidated()`, `extract_individual_file()`
- Source ranges: 301-310 oracle-philosophy, 311-320 psi-pillars, 321-330 maw-patterns, 331-340 subagent-personas, 341-350 command-workflows, 351-360 learning-patterns, 361-370 energy-rhythm, 371-380 anti-patterns, 381-390 graduated-projects, 391-400 teaching-prompts

### battery-tracker.scpt (AppleScript)
macOS battery status notification — shows charging state and percentage via `pmset -g batt`.

---

*All scripts used macOS-specific paths and tools. The Antigravity pipeline is the primary automation — sending AI image prompts in batch. Project scripts handle the ghq/GitHub repo lifecycle.*
