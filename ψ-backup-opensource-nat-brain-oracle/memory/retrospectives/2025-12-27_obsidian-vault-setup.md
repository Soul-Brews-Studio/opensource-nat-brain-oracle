# Retrospective: Obsidian Vault Setup

**Date**: 2025-12-27 19:00-19:15
**Focus**: Setting up Obsidian for ψ/memory knowledge management

---

## What Happened

User wanted to use Obsidian to visualize connections between retrospectives and learnings. Initial attempt opened wrong vault (RileyContent).

Solution: Create dedicated vault `~/Obsidian/NatOracle/` with symlink to ψ/memory - same files, clean view.

Then reorganized files for better Obsidian experience:
1. INDEX.md → FOLDER_NAME.md (caps convention, less clutter in graph)
2. Removed number prefix from resonance PNGs (`027-` → clean names)
3. Moved non-soul files from resonance to proper locations with date prefix

## Key Decisions

**Resonance = pure soul** (timeless, no dates):
- identity, oracle, patterns, personality, style

**Everything else = dated** (timeline matters):
- learnings, retrospectives, reference

**Naming convention**:
- `FOLDER_NAME.md` for index files (caps = special)
- `2025-12-27_description.md` for dated content

## Safety Hook Bug Fix

The PreToolUse safety hook was too aggressive - blocked `[ -f file ]` shell tests because it matched `-f`. Fixed regex to only match `-f` with git/rm/npm commands.

## What We Built

- `~/Obsidian/NatOracle/` vault with symlink
- Cleaner resonance folder (soul only)
- Improved safety hook regex

---

## AI Diary

Short productive session. The Obsidian setup revealed organization issues - INDEX files cluttering graph, non-soul files in resonance. Good forcing function.

The symlink approach is elegant: one source of truth (ψ/memory in repo), clean Obsidian view. Edit anywhere, same files.

Safety hook bug was interesting - over-aggressive pattern matching. Defense in depth shouldn't block legitimate work.

---

*Session: 2025-12-27 18:40-19:15*
