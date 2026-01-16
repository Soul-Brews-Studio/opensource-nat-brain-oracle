---
title: Complete Course Inventory - All Workshops, All Versions, All Strategies
tags: [workshop, courses, inventory, strategy, portfolio, complete-list]
created: 2026-01-11
source: Full session trace - comprehensive course discovery
---

# Complete Course Inventory

## Overview

| Metric | Count |
|--------|-------|
| Total Workshops | 17 |
| Total Slides (v2) | 205 |
| Ready to Deliver | 3 |
| In Development | 9 |
| Ideas | 3 |
| FREE (Funnel) | 2 |

---

## FLAGSHIP WORKSHOPS (v2 - Jan 8, 2026)

Created with slide outlines, most valuable assets.

| Workshop | Audience | Duration | Slides | Modules | Starter Kit | Status |
|----------|----------|----------|--------|---------|-------------|--------|
| AI Life Buddy | Knowledge workers | 4h | 50 | ❌ | partial | outline |
| **Build Your Oracle** | Developers | 3 days | **95** | **✅ 3** | **✅ complete** | **ready** |
| Psychology + AI | Academics | 2 days | 60 | ❌ | partial | outline |

### Build Your Oracle Structure (COMPLETE)

```
courses/build-your-oracle/
├── slides-outline.md           ← 95 slides, 865 lines
├── INDEX.md                    ← Pricing & module structure
│
├── module-1-memory/            ← Day 1: SQLite + FTS5
│   └── README.md               ← Teaching guide
│
├── module-2-survival/          ← Day 2: context-finder
│   └── README.md               ← Discovery through pain
│
├── module-3-intelligence/      ← Day 3: Vectors + MCP
│   └── README.md               ← 4 commands: consult/reflect/learn/supersede
│
└── starter-kit/                ← Working code
    ├── oracle.py               ← 180 lines, Day 1-2 CLI
    ├── oracle_smart.py         ← 227 lines, Day 3 with vectors
    ├── init_db.py              ← Database setup
    ├── schema.sql              ← FTS5 schema
    ├── knowledge/example.md    ← Sample data
    ├── templates/              ← learning.md, observation.md
    └── docs/
        ├── day1-memory.md
        ├── day2-search.md
        └── day3-intelligence.md
```

### AI Life Buddy Structure (PARTIAL)

```
courses/003-ai-life-buddy/
└── slides-outline.md           ← 50 slides

courses/starter-kits/ai-life-buddy/
├── README.md
├── CLAUDE.md.example
├── commands/
│   ├── feel.md
│   ├── fyi.md
│   ├── jump.md
│   └── rrr.md
└── templates/
    ├── feeling-log.md
    ├── handoff.md
    └── retrospective.md
```

### Psychology + AI Structure (PARTIAL)

```
courses/psychology-ai/
└── slides-outline.md           ← 60 slides

courses/starter-kits/psychology-ai/
├── README.md
├── ethics/guidelines.md
├── frameworks/khandha-5-ai.md
└── prompts/
    ├── pattern-discovery.md
    └── reflection-analysis.md
```

---

## CORE SERIES (v1 - Dec 2025)

Original sequential learning path, markdown outlines only.

| # | Slug | Duration | Level | File | Status |
|---|------|----------|-------|------|--------|
| 000 | setup | 1h | everyone | `000-setup_1h_everyone.md` | idea |
| 001 | imagination | 2h | intermediate | `001-imagination_2h_intermediate.md` | idea |
| 002 | control | 3h | advanced | `002-control_3h_advanced.md` | idea |
| 003 | ai-life-buddy | 4h | intermediate | `003-ai-life-buddy_4h_intermediate.md` | **v2 exists** |

**Learning Path**:
```
000 Setup → 001 Imagination → 002 Control
                   ↓
             003 AI Life Buddy (application)
```

---

## SKILLLANE FORMAT (Online Video Courses)

Self-paced video courses with pricing.

| # | Course | Price | Duration | Level | Status |
|---|--------|-------|----------|-------|--------|
| 01 | AI Builder (No-Code) | ฿1,590 | 8h 45m | beginner | dev |
| 02 | Master Class for Business | ฿2,490 | 7h 20m | advanced | dev |
| 03 | AI Automation Workflow | ฿1,990 | 6h 30m | beginner | dev |

**Files**: `courses/skilllane-format/`

---

## CUSTOM WORKSHOPS

| Name | Duration | Audience | Status | Path |
|------|----------|----------|--------|------|
| ai-builder-2day | 2 days | General | dev | `courses/ai-builder-2day/` |
| ai-automation-thai | TBD | Thai market | dev | `courses/ai-automation-thai/` |
| claude-code-masterclass-business | TBD | Business | dev | `courses/claude-code-masterclass-business/` |

---

## FREE WORKSHOPS (Funnel - Jan 10, 2026)

Lead generation courses.

| Workshop | Duration | Status | Path |
|----------|----------|--------|------|
| Git + GitHub Codespaces | 2h | ready | `courses/git-codespaces-free/` |
| Git Workflow for Teams | 2h | ready | `courses/git-workflow-free/` |

---

## DELIVERED (Archive)

| Event | Duration | Audience | Date | Path |
|-------|----------|----------|------|------|
| SIIT Dec 2025 | 6h (2 days) | University | 2025-12-12 | `courses/siit-2025-12/` |

---

## EXTERNAL (Cloned for Reference)

| Repo | Location | Purpose |
|------|----------|---------|
| claude-code-workshops | `ψ/learn/claude-code-workshops/` | Slide templates, reference |

---

## GENERATION COMPARISON

| Aspect | v1 (Dec 2025) | v2 (Jan 2026) |
|--------|---------------|---------------|
| **Format** | Markdown outlines | Slide outlines (95 slides!) |
| **Structure** | Single file | Modules + Starter Kits |
| **Code** | None | Working oracle.py, oracle_smart.py |
| **Teaching** | Conceptual | Discovery through pain |
| **Status** | Mostly ideas | Ready to deliver |

---

## PRICING STRATEGY

### Individual Modules (Build Your Oracle)

| Module | Live | Self-Paced |
|--------|------|------------|
| Module 1: Memory | $400 | $150 |
| Module 2: Survival | $500 | $200 |
| Module 3: Intelligence | $400 | $150 |
| **Bundle** | **$1,000** | **$400** |

### Full Workshops

| Workshop | Solo | Team (5) | Self-Paced |
|----------|------|----------|------------|
| AI Life Buddy | $400 | $1,500 | $150 |
| Build Your Oracle | $1,200 | $4,000 | $400 |
| Psychology + AI | $800 | $3,000 | $300 |
| **Bundle (all 3)** | **$2,000** | **$7,000** | **$700** |

### Funnel Strategy

```
FREE Git courses → Paid workshops → Bundle upsell
     ↓                    ↓              ↓
  Lead gen            $400-$1,200     $2,000-$7,000
```

---

## KEY FILES

| File | Purpose |
|------|---------|
| `courses/WORKSHOP-CATALOG.md` | Master index |
| `courses/GENEALOGY.md` | Course inheritance tracking |
| `courses/GEMINI-PROMPTS.md` | Generate actual slides |
| `courses/templates/course-template.md` | Design template |

---

## COURSE GENEALOGY (Inheritance)

```
000-setup (root)
│
├── 001-imagination (inherits: 000)
│   │
│   ├── 002-control (inherits: 001)
│   │
│   └── skilllane/01-ai-builder (remix: 001 + pricing)
│
└── siit-2025-12 (remix: 000 + 001)
    │
    ├── ai-builder-2day (inherits: siit delivery)
    │   │
    │   └── tingting-friends (custom audience)
    │
    └── skilllane/02-masterclass (remix: siit + online)
```

---

## OBSIDIAN VAULT STRATEGY (Brainstormed)

### Current: Single Vault
```
Nat-s-Agents/ ← Open in Obsidian
├── ψ/                   ← Oracle memory
├── courses/             ← Workshops
└── .claude/             ← AI config
```

### Proposed: Navigation Layer
```
Nat-s-Agents/
├── _nav/
│   ├── VAULT-MAP.md     ← Master navigation
│   ├── oracle.md        → ψ/
│   └── workshops.md     → courses/
├── ψ/INDEX.md
└── courses/WORKSHOP-CATALOG.md ← ✅ Done
```

---

## NEXT STEPS

### Immediate
1. Create modules for AI Life Buddy (50 slides)
2. Create modules for Psychology + AI (60 slides)
3. Clean up 27 orphaned claude processes

### Future
1. Generate actual slides with Gemini
2. Implement multi-vault Obsidian structure
3. Create FREE → Paid funnel landing pages
4. Record self-paced video versions

---

## SESSION METRICS

| Metric | Value |
|--------|-------|
| Files created | 26 |
| Lines added | 1,561 |
| Commits | 3 |
| Context used | 86% |
| Duration | ~1h 20m |

---

*Complete inventory captured: 2026-01-11 08:27*
*Oracle Philosophy: "Nothing is Deleted"*
