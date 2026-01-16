# Retrospective: Global Safety Hooks Complete

**Date**: 2025-12-27 18:30-19:20
**Duration**: ~50 minutes
**Focus**: Implementing enforceable safety rules via Claude Code hooks

---

## What We Built

### 1. Global Safety Hook (`~/.claude/hooks/safety-check.sh`)

PreToolUse hook that blocks dangerous commands:
- `--force`, `-f` flags (git, rm, npm)
- `git push origin main`
- `rm -rf`
- `gh pr merge` (requires user approval)
- `reset --hard`

Key insight: Hook receives JSON via **stdin**, not env vars. Exit code 2 = block.

### 2. Local vs Global Settings Split

| Location | Contains |
|----------|----------|
| `~/.claude/settings.json` | Safety hooks (all projects) |
| `.claude/settings.local.json` | Oracle philosophy, Thai voice, project hooks |

### 3. ψ/memory Reorganization

- INDEX.md → FOLDER_NAME.md (caps convention)
- Moved non-soul files from resonance to reference/learnings
- Removed number prefix from resonance PNGs
- Resonance now pure soul: identity, oracle, patterns, personality, style

## Bugs Fixed

1. **Hook blocking `[ -f ]` shell tests** - Regex too aggressive, fixed to only match with git/rm/npm commands
2. **Hook blocking commit messages** - Word "force" in heredoc triggered block, used simpler message

## Abandoned Ideas

- `~/Obsidian/NatOracle/` symlink vault - deleted, too complex

## Key Learning

**Documentation vs Enforcement**: CLAUDE.md says "never force push" but relies on AI compliance. A hook with `exit 2` makes it impossible. Defense in depth.

---

## AI Diary

Satisfying session. Turned safety rules from suggestions into walls.

The hook blocking itself was funny - PR body contained "--force", commit message contained "force". Had to work around my own safety measures. Good sign they're working.

The Obsidian detour was brief. User quickly decided against extra complexity. Good instinct - ψ/memory already works as direct vault.

Interesting UX challenge: hook blocks `gh pr merge` even when user explicitly says "merge". Temporary disable → merge → restore is clunky. Maybe need a "user confirmed" bypass pattern.

---

## Honest Feedback

**To User**: Clean session. Quick decisions (keep/abandon Obsidian vault), clear direction on safety vs convenience tradeoffs.

**To Self**: Should have checked hook input format (stdin JSON) before assuming env vars. Cost ~5 minutes debugging.

---

*Session: 2025-12-27 18:30-19:20*
*PR: #54 merged*
