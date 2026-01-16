---
title: "Key Repos for Deep Analysis"
tags: [lab, github, repos, analysis]
created: 2025-12-11
status: active
parent: "[[lab|Lab]]"
---

# Key Repos for Deep Analysis

**Generated**: 2025-12-11
**Source**: GitHub API + Profile Analysis
**Tier Strategy**: Lifecycle phases + Active development + Technical depth  

---

## Quick Summary

From Nat's 500+ personal repos across 30 organizations, selected **14 key repos** spanning 4 life phases:

- **Tier 1**: Current flagship & philosophy (3 repos)
- **Tier 2**: Active multi-agent frameworks (4 repos)
- **Tier 3**: Historical context - Maker/IoT/Web3 (3 repos)
- **Tier 4**: Emerging patterns - Infrastructure (2 repos)
- **Reference**: Organization map + metadata

---

## Tier 1: Core Philosophy (Must-Read)

Represents Nat's **current** thinking, methodology, and vision for 2025+.

| Repo | Org | Status | Size | Key Topics |
|------|-----|--------|------|-----------|
| `Nat-s-Agents` | laris-co | Active (2025-12) | Core | Claude Code framework, oracle philosophy |
| `oracle-starter-kit` | laris-co | Active (2025-12) | Template | Subagent patterns, philosophy documentation |
| `the-headline` | laris-co | Active (2025-12) | Integration | AI news dashboard, LLM integration example |

**Why analyze**: These define his current AI/Oracle phase philosophy. Extract:
- File organization patterns
- README mission statements
- Code structure preferences
- Documentation philosophy

---

## Tier 2: Active Frameworks (Technical Depth)

Current implementations of multi-agent patterns and automation frameworks.

| Repo | Org | Status | Purpose | Key Topics |
|------|-----|--------|---------|-----------|
| `agents` | nazt | Active (2025-10) | Framework | Multi-agent orchestration, automation |
| `awesome-claude-agents` | nazt | Active (2025-08) | Community | Sub-agent teams, best practices |
| `ccpm` | nazt | Active (2025-08) | Tooling | GitHub Issues + git worktrees for parallel agents |
| `multi-agent-workflow-kit` | laris-co | Active (2025-10) | Toolkit | Tmux + git worktree workflows (6 stars) |

**Why analyze**: Technical implementations showing:
- Automation patterns
- Agent communication
- Workflow management
- Development velocity

---

## Tier 3: Historical Context (Pattern Recognition)

Earlier work showing evolution and foundational interests.

| Repo | Org | Phase | Last Active | Significance |
|------|-----|-------|------------|--------------|
| `dustboy-geo` | nazt | IoT/Maker | 2025-12 | Recent GPS IoT - shows continued maker interest |
| `mqtt-sight` | nazt | IoT/Maker | 2025-03 | MQTT visualization - data infrastructure skill |
| `duckyscan-v1` | muskindex | Blockchain | 2023-04 | Blockchain explorer - shows Web3 exploration era |

**Why analyze**: Evolution of interests:
- 2015-2020: Hardware/IoT (Maker phase)
- 2021-2022: Blockchain/DeFi (Web3 phase)
- 2022-2024: Beer brewing (90/10 balance)
- 2025+: AI/Oracle (Current focus)

---

## Tier 4: Emerging Patterns (Optional Deep Dive)

Recent infrastructure projects showing new directions.

| Repo | Org | Status | Description |
|------|-----|--------|-------------|
| `BotBrowser` | nazt | Active (2025-11) | Browser automation + anti-bot testing |
| `HeadlessX` | nazt | Active (2025-10) | Self-hosted headless browser platform |

**Why analyze** (optional): Shows interest in:
- Browser automation
- Infrastructure tools
- Automation patterns outside AI

---

## Organization Structure

Understanding Nat's org ecosystem:

| Organization | Org Type | Repos | Focus |
|--------------|----------|-------|-------|
| `laris-co` | Primary workspace | 100+ | AI, frameworks, current projects |
| `nazt` | Personal | 150+ | Experimental, side projects |
| `muskindex` | Blockchain | 50+ | Web3, DeFi, blockchain explorers |
| `cmmakerclub` | Community | 60+ | Maker projects, Thai IoT scene |
| `Soul-Brews-*` (3) | Creative studio | 30+ | Brewing, business, creative work |
| `DustBoy-*` (3) | Hardware brand | 20+ | IoT devices, embedded systems |
| `Cat-Lab-System` | AI Lab | 10+ | Experimental AI projects |
| `Humanist-Design` | Philosophy | 5+ | Design philosophy |

---

## Analysis Questions

When examining each repo, look for answers to:

### Architecture & Design
- How does Nat structure repos? (what goes in root, docs/, src/?)
- What patterns repeat across repos?
- How does he organize dependencies?

### Philosophy & Values
- What does each README reveal about priorities?
- How does documentation style evolve across phases?
- What values appear in commit messages?

### Technical Choices
- What's his preferred tech stack? (per language)
- How does he handle configuration/env?
- What testing/validation patterns appear?

### Development Velocity
- How often does he commit? Merge frequency?
- Solo developer or collaboration?
- What triggers project activation/dormancy?

### Evolution Signals
- How do older repos (2015-2020) differ from new ones?
- What technical skills transfer between phases?
- How do team/org patterns change?

---

## Clone & Analyze

To clone all repos and begin analysis:

```bash
# Clone all tiers
bash .tmp/clone-commands.sh

# Then examine structure
for repo in .tmp/github-analysis/repos/*/; do
  echo "=== $(basename $repo) ==="
  head -30 "$repo/README.md" 2>/dev/null
  echo ""
done
```

---

## Output Location

Once analysis is complete, store findings in:

- **Deep dives**: `ψ/lab/github-analysis/repos-deep-dive.md`
- **Patterns**: `ψ/memory/learnings/github-personality.md`
- **Timeline**: `ψ/lab/github-analysis/timeline.md`
- **Tech stack**: `ψ/lab/github-analysis/tech-evolution.md`

---

## Metadata

- **Total repos scanned**: 500+
- **Organizations**: 30
- **Active languages**: 6 (TypeScript, Python, Go, C++, JavaScript, Solidity)
- **Oldest repo**: 2009
- **Most active org**: laris-co (100+ repos)
- **Current phase**: AI/Oracle (2025+)

---

*Analysis framework by context-finder*

---

## See Also

- [[HOME|Home]] - Brain navigation
- [[lab/github-profile-analysis|GitHub Profile Analysis]] - Initial profile scan
- [[memory/retrospectives/2025-12/11/11.19_skills-experiments-github-scan|Session: GitHub Scan]] - Session that created this
- [[memory/resonance|Resonance]] - Where distilled patterns go
