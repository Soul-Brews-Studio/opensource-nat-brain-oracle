---
title: "Skill Templates Must Be Explicit"
tags: [skills, templates, consistency, rrr, automation]
created: 2026-01-15
source: Session 2026-01-15 - Fixing 7 missing retro headers
---

# Skill Templates Must Be Explicit

## The Problem

7 out of 12 retrospectives from Jan 14 were missing Date/Time headers.

The rrr skill said "follow template" but didn't show the **exact format** to use.

## Why It Happened

```markdown
# Original skill instruction
## Step 4: Create Retrospective File
**Location**: `ψ/memory/retrospectives/YYYY-MM/DD/HH.MM_slug.md`
**Filename**: `07.39_maw-amend-divergence-fix.md` (time + slug)

# What was missing: THE ACTUAL TEMPLATE
```

Different sessions → different AI interpretations → inconsistent headers.

## The Fix

Added explicit **REQUIRED HEADER** block with copy-paste template:

```markdown
**REQUIRED HEADER** (copy this structure exactly):

# Session Retrospective: [Title]

**Date**: YYYY-MM-DD (Day)
**Time**: HH:MM - HH:MM GMT+7 (~X minutes)
**Model**: Claude Opus 4.5
**Context**: [One line context]

---
```

## The Pattern

| Skill Instruction | Result |
|-------------------|--------|
| "Follow the template" | ❌ Inconsistent |
| "Use proper format" | ❌ Ambiguous |
| "Copy this exactly: [template]" | ✅ Consistent |

## Lesson

> **Don't describe the format. Show the format.**
>
> When writing skills, include the literal template to copy.
> AI will interpret "proper format" differently each time.
> AI will copy "this exact block" consistently.

---

*From: Fixing 7 retrospectives with missing headers*
