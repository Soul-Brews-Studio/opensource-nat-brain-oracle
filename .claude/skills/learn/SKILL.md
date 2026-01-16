---
name: learn
description: Explore a codebase with 2 parallel Haiku agents and create concise documentation. Use when user says "learn [repo]", "explore codebase", "study this repo", or wants to understand a project.
---

# /learn - Codebase Learning

Explore a codebase → create hub + 3 focused docs.

## Usage

```
/learn [url]             # Clone + explore
/learn [repo-path]       # Explore local
```

## Step 0: Clone if URL

```bash
date "+🕐 %H:%M (%A %d %B %Y)"
ghq get [url]
mkdir -p ψ/learn/[REPO_NAME]
```

## Step 1: Launch 2 Agents (PARALLEL)

### Agent 1: Structure Scout

```
Explore [REPO_PATH]. Return:

## What It Does
[2-3 paragraphs: project purpose, why it exists, who it's for]

## How It Works
[Core mechanism in plain English. What's the key idea?]

## Architecture
| Component | Purpose |
|-----------|---------|
[7-10 rows]

[Explain relationships between components - 2-3 sentences]

## Dependencies
| Package | Why |
|---------|-----|
[Key deps with explanation]

STYLE: Tables for structure, prose for explanation. ~80 lines.
```

### Agent 2: Code Hunter

```
Explore [REPO_PATH]. Return:

## Key Patterns
For each pattern (3 patterns):

### [Pattern Name]
**What**: [1-2 sentences]
**Why it's clever**: [1-2 sentences]
[Code block]

## Quick Reference
- **Install**: [command]
- **Key files**: [list]
- **Entry point**: [file]

STYLE: Explain the "why", not just show. ~70 lines.
```

## Step 2: Main Agent Creates 4 Files

### File 1: `[REPO].md` (Hub)

```markdown
# [REPO] - Learning Notes

**Date**: [TODAY]
**Repo**: [URL]

## Summary
[1 paragraph from Agent 1]

## Key Insight
[The ONE pattern worth stealing from Agent 2]

## Files
- [[ARCHITECTURE]] - Structure + how it works
- [[CODE-SNIPPETS]] - Patterns worth stealing
- [[QUICK-REFERENCE]] - Quick lookup

## Links
- Repo: [url]
- Demo: [if any]
```

### File 2: `ARCHITECTURE.md`

```markdown
# [REPO] - Architecture

## What It Does
[From Agent 1 - 2-3 paragraphs]

## How It Works
[From Agent 1 - core mechanism]

## Components
| Component | Purpose |
|-----------|---------|
[From Agent 1]

[Relationship explanation]

## Dependencies
| Package | Why |
|---------|-----|
[From Agent 1]
```

### File 3: `CODE-SNIPPETS.md`

```markdown
# [REPO] - Code Snippets

## Key Patterns

### 1. [Pattern Name]
**What**: [explanation]
**Why**: [why it's clever]
[code block]

### 2. [Pattern Name]
...

### 3. [Pattern Name]
...
```

### File 4: `QUICK-REFERENCE.md`

```markdown
# [REPO] - Quick Reference

## Install
[command]

## Key Files
| File | Purpose |
|------|---------|
[5-7 rows]

## Entry Points
- Main: [file]
- Config: [file]

## Links
- Repo: [url]
- Docs: [if any]
```

## Output Summary

```markdown
## 📚 /learn: [REPO_NAME]

**What**: [1 sentence]
**Key Pattern**: [1 sentence]

**Files**:
- `[REPO].md` - Hub
- `ARCHITECTURE.md` - Structure
- `CODE-SNIPPETS.md` - Patterns
- `QUICK-REFERENCE.md` - Quick lookup

**Location**: ψ/learn/[REPO_NAME]/
```

## Style Rules

- **Hub**: ~40 lines (summary + links)
- **Architecture**: ~80 lines (tables + explanation)
- **Code Snippets**: ~70 lines (patterns + why)
- **Quick Reference**: ~40 lines (lookup)
- **Total**: ~230 lines across 4 files
- Tables for structure, prose for explanation
- English for technical content
