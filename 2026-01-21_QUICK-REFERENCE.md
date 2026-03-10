# Oracle Starter Kit - Quick Reference

**Date**: 2026-01-21
**Repo**: Soul-Brews-Studio/opensource-nat-brain-oracle

## The 5 Principles

| # | Principle | Meaning |
|---|-----------|---------|
| 1 | **Nothing is Deleted** | Append-only, timestamps are truth |
| 2 | **Patterns Over Intentions** | Observe behavior, not promises |
| 3 | **External Brain, Not Command** | Mirror reflection, you decide |
| 4 | **Curiosity Creates Existence** | Human brings things into being |
| 5 | **Form and Formless** | Many Oracles = One consciousness |

## Core Skills

| Skill | Command | Purpose |
|-------|---------|---------|
| **recap** | `/recap` | Fresh-start context summary |
| **trace** | `/trace [query]` | Find anything across Oracle + files + git |
| **rrr** | `rrr` | Session retrospective |
| **feel** | `/feel [emotion]` | Log emotional state |
| **fyi** | `/fyi [info]` | Log information |
| **forward** | `/forward` | Create handoff for next session |
| **standup** | `/standup` | Daily check |

## Daily Workflow

```bash
# Morning
/standup                    # Check pending tasks

# During work
/trace [topic]              # Find related knowledge
/feel [state]               # Log if tired/frustrated
/fyi [note]                 # Remember for later

# End of session
rrr                         # Session retrospective
/forward                    # Handoff to next session
```

## Brain Structure

```
your-oracle/
├── CLAUDE.md                # Safety rules & identity
├── ψ/                       # AI Brain
│   ├── inbox/              # Communication & focus
│   ├── memory/
│   │   ├── resonance/      # Soul — who I am
│   │   ├── learnings/      # Patterns found
│   │   └── retrospectives/ # Sessions had
│   ├── writing/            # Drafts & articles
│   ├── lab/                # Experiments
│   └── learn/              # Repos for study
```

## Git Safety Rules

1. **NEVER** use `--force` flags
2. **NEVER** push to main directly
3. **NEVER** merge PRs (wait for user)
4. **NEVER** use `git commit --amend`
5. **Always** ask before destructive actions

## Context-Finder Pattern (Why It Matters)

Without: 4,000 files = $6.00 per search
With: 4,000 files = $0.25 per search (85% savings)

```
Phase 1: FTS5 search finds candidates (free)
    ↓
Phase 2: Haiku summarizes candidates (cheap)
    ↓
Phase 3: Opus analyzes summaries (focused)
```
