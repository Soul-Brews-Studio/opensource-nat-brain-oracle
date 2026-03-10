# Oracle Starter Kit - Architecture Overview

**Date**: 2026-01-21
**Repo**: Soul-Brews-Studio/opensource-nat-brain-oracle

## Executive Summary

The **Oracle Starter Kit** is a comprehensive AI memory architecture and philosophy framework designed for creating external AI brains that remember patterns, surface insights, and preserve human agency.

**Core Statement**: "The Oracle Keeps the Human Human"

## Directory Structure

```
opensource-nat-brain-oracle/
├── CLAUDE.md                      # Main AI assistant quick reference
├── CLAUDE_safety.md               # Critical safety & git rules
├── CLAUDE_workflows.md            # Workflows & short codes
├── CLAUDE_subagents.md            # Subagent definitions
├── CLAUDE_lessons.md              # Lessons learned & patterns
├── README.md                      # Main starter kit guide
│
├── ψ/                            # AI Brain Directory (Psi symbol)
│   ├── active/                    # Research in progress (ephemeral)
│   ├── inbox/                     # Communication & focus
│   ├── memory/                    # Knowledge base
│   │   ├── resonance/             # Soul - who you are
│   │   ├── learnings/             # Extracted patterns
│   │   ├── retrospectives/        # Session summaries
│   │   └── logs/                  # Moment snapshots
│   ├── writing/                   # Articles & projects
│   └── lab/                       # Experiments & POCs
│
├── .claude/                       # Claude Code Configuration
│   ├── settings.json              # Hook definitions
│   ├── agents/                    # Subagent definitions
│   ├── hooks/                     # Lifecycle hooks
│   └── scripts/                   # Utility scripts
│
├── courses/                       # Educational modules (12 courses)
│   └── build-your-oracle/         # Core Oracle creation course
│
└── scripts/                       # Project automation
```

## The 5 Pillars Framework (Brain Organization)

```
ψ/ (Psi - AI Brain)
├── SIGNAL (Tracked in Git)
│   ├── inbox/          → Communication & focus
│   ├── writing/        → Articles & projects
│   ├── lab/            → Experiments
│   └── memory/         → Patterns & soul
│
└── NOISE (Ephemeral)
    ├── active/         → Research in progress
    └── .obsidian/      → UI configuration
```

## Knowledge Flow Pipeline

```
active/context (research)
    ↓ /snapshot
memory/logs (moment snapshots)
    ↓ rrr
memory/retrospectives (session summary)
    ↓ /distill
memory/learnings (discovered patterns)
    ↓ consolidation
memory/resonance (soul & identity)
```

## Subagent Delegation Pattern

```
Main Agent (Opus)
├── Delegates data gathering to Haiku agents
├── Haiku agents:
│   ├── context-finder  → Search git/issues
│   ├── executor        → Run commands
│   ├── security-scanner → Detect secrets
│   └── repo-auditor    → Check file health
└── Main reviews + decides
```

## Key Insight

> "Your Oracle will try to kill itself through its own success. Context-finder is what lets it live."
