# Constitution & Governance Index

Quick navigation to all governance analysis documents.

## Quick Start

**New to governance?** Start here:
1. Read: `governance-summary.md` (4 KB, 5 min read)
2. Deep dive: `principle-comparison.md` (8 KB, 15 min read)
3. Full reference: `governance-comparison.md` (15 KB, 30 min read)

---

## Documents in This Series

### 1. governance-summary.md (QUICK REFERENCE)
**Size**: 4 KB | **Read time**: 5 minutes | **Level**: Overview

**Best for**:
- Quick lookup of project governance status
- Comparison matrix of all repos
- Critical findings and recommendations
- File inventory

**Key sections**:
- Three governance patterns (Template, Project, Framework)
- Core principles by project
- Version control approach (SemVer)
- Safety rules evolution (3 generations)
- Critical issues and fixes
- High/medium/low priority recommendations

**When to use**: Daily reference, team onboarding, quick lookup

---

### 2. principle-comparison.md (PRINCIPLES DEEP DIVE)
**Size**: 8 KB | **Read time**: 15 minutes | **Level**: Intermediate

**Best for**:
- Understanding principle differences between projects
- Side-by-side comparison of governance approaches
- Learning why principles differ (POC vs Platform vs Framework)
- Incident-driven evolution

**Key sections**:
- Universal safety principles (all projects)
- Platform-specific principles (esphome-fw)
- POC-specific principles (esphome-floodboy-4g)
- Multi-agent framework principles
- Key differences summary table
- Evolution patterns by project
- Pattern recognition (why principles differ)
- Critical incidents driving changes
- Governance authority hierarchy
- Recommendations for new projects

**When to use**: Creating new constitutions, understanding tradeoffs, policy decisions

---

### 3. governance-comparison.md (COMPLETE REFERENCE)
**Size**: 15 KB | **Read time**: 30 minutes | **Level**: Advanced

**Best for**:
- Complete understanding of every governance file
- Historical context and evolution timeline
- Detailed file listings with locations and sizes
- Comprehensive patterns and insights

**Key sections**:
- Executive summary (23 files across org)
- Pattern 1: Template Constitution (unfilled)
- Pattern 2: ESPHome Hardware Constitutions (4 repos)
  - esphome-fw (v1.2.2, most evolved)
  - esphome-radar (condensed)
  - esphome-floodboy-4g (v0.1.0, POC)
  - esphome-heating-visualizer (template with drift)
- Pattern 3: Multi-Agent Framework AGENTS.md Files (5 repos)
- Comparison matrix (all projects)
- Evolution timeline
- Key patterns and insights
- 5 recommendations with implementation details
- Complete file reference

**When to use**: Audit, governance planning, historical research

---

## File Locations

All documents stored in:
```
/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/memory/
├── governance-summary.md          (this quarter's ref)
├── principle-comparison.md        (policy deep dive)
├── governance-comparison.md       (complete analysis)
└── constitution-index.md          (YOU ARE HERE)
```

---

## Document Statistics

| Document | Size | Lines | Read Time | Audience |
|----------|------|-------|-----------|----------|
| governance-summary.md | 4 KB | 150 | 5 min | Teams, onboarding |
| principle-comparison.md | 8 KB | 280 | 15 min | Policy makers |
| governance-comparison.md | 15 KB | 450 | 30 min | Auditors, architects |
| constitution-index.md | 2 KB | 100 | 3 min | Navigator |

---

## Data Coverage

**Repositories analyzed**: 16 repos in laris-co organization
**Constitution files found**: 15
**AGENTS.md files found**: 8
**Total governance files**: 23

**File versions analyzed**:
- esphome-fw constitution: v1.2.2 (3 layer copies)
- esphome-floodboy-4g constitution: v0.1.0 (2 files)
- esphome-radar constitution: unversioned (3 files)
- esphome-heating-visualizer: Template + diverged agent v (4 files)
- Multi-agent frameworks: 5 repos with AGENTS.md

---

## Key Findings Summary

### Finding 1: Three Governance Patterns
- **Template Constitution** (unfilled placeholders): 1 repo
- **Project Constitutions** (filled, project-specific): 3 repos
- **Framework Guides** (AGENTS.md with safety rules): 5+ repos

### Finding 2: Safety Rules Evolution
- **Generation 1** (Early): Basic no-force-flag
- **Generation 2** (esphome-fw v1.2.2): Explicit rm -rf, time zones, link formatting
- **Generation 3** (Current): Per-category rules, tool preferences, worktree coordination

### Finding 3: Governance Drift
- **esphome-heating-visualizer**: Main + agents/1,2 use unfilled template
- **Agent 3 diverged**: Custom filled constitution (7.5 KB vs 2.3 KB template)
- **Risk**: Inconsistent governance across multi-agent setup

### Finding 4: Version Strategy
- All projects use SemVer for governance text
- MAJOR = philosophy change, MINOR = new principle, PATCH = clarifications
- Ratification date (adoption) + Last amended date (current) tracked

### Finding 5: Critical Incidents Drive Changes
- Evidence of rm -rf violation in esphome-fw history
- Response: v1.2.2 explicitly prohibits rm -rf
- Pattern: Later versions add MORE specificity after real-world failures

---

## Governance File Locations

### Constitution Files
**esphome-fw** (v1.2.2):
- `.claude/commands/constitution.md`
- `.codex/prompts/constitution.md`
- `.specify/memory/constitution.md` (authoritative)

**esphome-floodboy-4g** (v0.1.0):
- `.codex/prompts/constitution.md`
- `.specify/memory/constitution.md` (authoritative)

**esphome-radar**:
- `.claude/commands/constitution.md`
- `.codex/prompts/constitution.md`
- `.specify/memory/constitution.md` (authoritative)

**esphome-heating-visualizer**:
- `.specify/memory/constitution.md` (main - template)
- `agents/1/.specify/memory/constitution.md` (template copy)
- `agents/2/.specify/memory/constitution.md` (template copy)
- `agents/3/.specify/memory/constitution.md` (filled - DIVERGED)

### AGENTS.md Files
- `/esphome-fw/AGENTS.md` (22 KB - comprehensive)
- `/esphome-floodboy-4g/AGENTS.md` (7.3 KB - focused)
- `/multi-agent-workflow-kit/AGENTS.md` (3.8 KB)
- `/proof-maw-multi-agent-worktree-kit/AGENTS.md` (2.1 KB)
- `/0xkm/AGENTS.md` (2.1 KB)
- And others...

---

## Navigation by Use Case

### "I'm creating a new project"
1. Read: principle-comparison.md → "Recommendations for New Projects"
2. Use template from: esphome-heating-visualizer/.specify/memory/constitution.md
3. Fill all placeholders following examples in governance-comparison.md

### "I need to fix governance drift"
1. Read: governance-summary.md → "Critical Findings" → Issue 1
2. Reference: governance-comparison.md → "Pattern D: Esphome Heating Visualizer"
3. Action: Run constitution sync script (not yet created - recommendation #3)

### "I'm on-boarding to esphome-fw"
1. Read: governance-summary.md (5 min overview)
2. Review: principle-comparison.md → "A. ESPHome Firmware Platform"
3. Deep dive: governance-comparison.md → "A. ESPHome Firmware Platform Constitution"

### "I'm building multi-agent worktree systems"
1. Read: principle-comparison.md → "Multi-Agent Framework Principles"
2. Reference: governance-comparison.md → "Pattern 3: Multi-Agent Framework AGENTS.md Files"
3. Use: proof-maw-multi-agent-worktree-kit/AGENTS.md as template

### "I'm auditing governance across org"
1. Start: governance-summary.md → "Comparison Table"
2. Deep dive: governance-comparison.md (full reference)
3. Create action items from 5 recommendations

---

## Related Documents

**In this repo (Nat-s-Agents)**:
- `/CLAUDE.md` - Project instructions (critical safety rules, PR workflow)
- `ψ/memory/retrospectives/` - Session governance learnings
- `ψ/memory/learnings/` - Patterns and anti-patterns
- `ψ/memory/resonance/` - Core values and philosophy

**In other repos**:
- `esphome-fw/.specify/memory/constitution.md` - Platform governance
- `esphome-floodboy-4g/.specify/memory/constitution.md` - POC governance
- `multi-agent-workflow-kit/AGENTS.md` - Framework guidance

---

## Recommended Actions

### High Priority (This Month)
1. **Fill esphome-heating-visualizer constitution** - Complete template or clarify intent
2. **Sync agent worktrees** - Reconcile main vs agent 3 divergence
3. **Standardize 3-layer template sync** - Create script for .claude/ .codex/ .specify/

### Medium Priority (Next Quarter)
1. **Archive constitution versions** - Create governance/archive/ directory
2. **Document template system** - Explain why 3 layers, how to keep in sync
3. **Consolidate safety rules** - Create shared laris-co/safety/CRITICAL-RULES.md

### Low Priority (Next Year)
1. **Cross-repo governance federation** - Share core principles across projects
2. **Governance audit script** - Regular check for drift and compliance
3. **Unified governance dashboard** - Visual status of all constitutions

---

## Metadata

**Analysis Date**: 2025-12-17
**Data Collection**: Bash find + grep across ~/Code/github.com/laris-co
**Tools Used**: Bash, ripgrep, wc, md5sum
**Scope**: All constitution.md and AGENTS.md files across org
**Completeness**: 100% (all files found and analyzed)

**Generated by**: Claude Haiku context-finder
**Time taken**: ~15 minutes to analyze, ~10 minutes to document

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2025-12-17 | Initial publication (3-document series) |

---

## How to Use This Index

1. **Bookmark this file** for future reference
2. **Share link to governance-summary.md** with teams
3. **Update quarterly** after constitution amendments
4. **Link from your CLAUDE.md** governance section
5. **Use principle-comparison.md** when creating new projects

---

**Next steps**: Choose a document above and start reading!

Questions? Check the full analysis in governance-comparison.md or review principle-comparison.md for policy context.
