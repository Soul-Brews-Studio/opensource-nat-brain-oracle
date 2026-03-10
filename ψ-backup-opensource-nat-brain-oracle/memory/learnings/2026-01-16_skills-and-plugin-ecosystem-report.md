---
title: Skills & Plugin Ecosystem Report
tags: [skills, plugin, ecosystem, architecture, trace]
created: 2026-01-16
trace_ids: ["79e6a0c1", "cf5795e6"]
---

# Skills & Plugin Ecosystem Report

**Generated**: 2026-01-16 08:45
**Trace IDs**: `79e6a0c1` (skills), `cf5795e6` (plugins)

---

## Executive Summary

| Metric | Count |
|--------|-------|
| Active Skills | 15 |
| Registered Marketplaces | 12 |
| Installed Plugins | 5 |
| Plugin Repos (Your Orgs) | 11 |
| Related GitHub Issues | 10 |

**Primary Distribution**: Soul-Brews-Studio/plugin-marketplace v1.3.2

---

## Part 1: Skills Inventory

### Active Skills (15 total)

| Skill | Source | Purpose |
|-------|--------|---------|
| `/trace` | oracle-skills | Find projects across git/repos/docs |
| `/recap` | oracle-skills | Fresh-start context summary |
| `/rrr` | oracle-skills | Session retrospective |
| `/learn` | oracle-skills | Clone repo for study |
| `/project` | oracle-skills | Project lifecycle (learn/incubate) |
| `/feel` | oracle-skills | Log emotions/mood |
| `/fyi` | oracle-skills | Log info for reference |
| `/forward` | oracle-skills | Session handoff |
| `/standup` | oracle-skills | Daily check |
| `/schedule` | oracle-skills | DuckDB calendar queries |
| `/watch` | oracle-skills | YouTube → Gemini transcription |
| `/where-we-are` | oracle-skills | Session awareness |
| `/context-finder` | oracle-skills | Fast codebase search |
| `/hours` | local | Work hours from git commits |
| `/gemini` | local | Gemini integration |

### Skill Locations

```
~/.claude/skills/
├── trace → ~/.claude/plugins/cache/oracle-skills/.../skills/trace/
├── recap → ~/.claude/plugins/cache/oracle-skills/.../skills/recap/
├── rrr → ~/.claude/plugins/cache/oracle-skills/.../skills/rrr/
├── learn → ~/.claude/plugins/cache/oracle-skills/.../skills/learn/
├── project → ~/.claude/plugins/cache/oracle-skills/.../skills/project/
├── feel → ~/.claude/plugins/cache/oracle-skills/.../skills/feel/
├── fyi → ~/.claude/plugins/cache/oracle-skills/.../skills/fyi/
├── forward → ~/.claude/plugins/cache/oracle-skills/.../skills/forward/
├── standup → ~/.claude/plugins/cache/oracle-skills/.../skills/standup/
├── schedule → ~/.claude/plugins/cache/oracle-skills/.../skills/schedule/
├── watch → ~/.claude/plugins/cache/oracle-skills/.../skills/watch/
├── where-we-are → ~/.claude/plugins/cache/oracle-skills/.../skills/where-we-are/
├── context-finder → ~/.claude/plugins/cache/oracle-skills/.../skills/context-finder/
├── hours/ (local)
└── gemini/ (local)
```

### Skills Usage Analytics

Top 5 most used (Jan 2026):
1. `/learn` (140 uses)
2. `/recap` (104 uses)
3. `/trace` (85 uses)
4. `/oracle` (75 uses)
5. `/rrr` (66 uses)

---

## Part 2: Plugin Architecture

### 3-Tier Architecture

```
┌─────────────────────────────────────────────────────────┐
│ TIER 1: Development (Main Repo)                         │
│ plugins/                                                │
│ ├── handoff-mcp/      (Node.js/tsx)                    │
│ ├── handoff-mcp-v4/   (Bun + Drizzle + Web UI)         │
│ ├── nat-agents-core → symlink                          │
│ ├── nat-data-personal → symlink                        │
│ └── ralph-local → symlink                              │
├─────────────────────────────────────────────────────────┤
│ TIER 2: Distribution (Soul-Brews-Studio)               │
│ plugin-marketplace/                                     │
│ ├── oracle-skills (13 skills) v1.3.2                   │
│ └── ralph-soulbrews v1.0.0                             │
├─────────────────────────────────────────────────────────┤
│ TIER 3: Runtime (~/.claude/plugins/cache/)             │
│ ├── nat-agents-core@1.7.0                              │
│ ├── oracle-skills@1.3.2                                │
│ ├── claude-mem@9.0.5                                   │
│ ├── project-manager@1.1.0                              │
│ └── claude-voice-notify@1.0.0                          │
└─────────────────────────────────────────────────────────┘
```

### Registered Marketplaces (12)

| Marketplace | Org | Plugins |
|-------------|-----|---------|
| nat-plugins | laris-co | nat-agents-core, nat-data-personal, ralph-local, handoff-mcp-v4 |
| soul-brews-plugin | Soul-Brews-Studio | oracle-skills, ralph-soulbrews |
| claude-project-manager | Soul-Brews-Studio | project-manager |
| claude-voice-notify | laris-co | claude-voice-notify |
| thedotmack | External | claude-mem |
| dev-browser-marketplace | External | dev-browser |
| anthropic-agent-skills | Anthropic | Official agents |
| claude-plugins-official | Anthropic | Official plugins |
| claude-code-plugins | Anthropic | Code plugins |
| oracle-skills | laris-co | Legacy |
| oracle-v2 | laris-co | Legacy |
| nat-agents-core | laris-co | Legacy |

### Plugin Repos by Organization

**laris-co (7)**:
- Nat-s-Agents/plugins/
- nat-agents-core
- nat-data-personal
- claude-voice-notify
- oracle-proof-of-concept-skills
- oracle-v2
- .claude-plugin (org level)

**Soul-Brews-Studio (4)**:
- plugin-marketplace (main distribution)
- claude-project-manager
- ralph-local
- oracle-proof-of-concept-skills

---

## Part 3: Key Patterns & Learnings

### Critical Discovery: Skills Array Required

```json
// marketplace.json MUST have explicit skills array
{
  "plugins": [{
    "name": "oracle-skills",
    "source": "./oracle-skills",
    "skills": [           // <-- REQUIRED for discovery!
      "./skills/trace",
      "./skills/recap",
      ...
    ]
  }]
}
```

Without `skills: []` array → plugins install but skills NOT discovered.

### Namespacing Pattern

| Type | Shows As | Example |
|------|----------|---------|
| Plugin command | `plugin:command` | `oracle-skills:rrr` |
| Plugin skill | Listed in `/skills` | Shows with description |
| Local skill | `/skill` | `/rrr` (clean) |

**Workaround**: Create `commands/` folder OR symlink to `~/.claude/skills/`

### Single Source of Truth

```bash
# Best practice
Git repo → symlink to ~/.claude/skills/

# NOT this (fragile)
Plugin cache → scattered copies
```

### MCP Configuration Pattern

```json
// .mcp.json
{
  "mcpServers": {
    "handoff-v4": {
      "type": "stdio",
      "command": "bun",
      "args": ["run", "${CLAUDE_PROJECT_DIR}/path/to/server.ts", "--mcp"]
    }
  }
}
```

---

## Part 4: Development Timeline

| Date | Event |
|------|-------|
| **2026-01-16** | Fixed `/learn` external script dependency |
| **2026-01-15** | Soul-Brews marketplace created (v1.3.2) |
| **2026-01-15** | Fixed: skills array required for discovery |
| **2026-01-14** | Single source of truth pattern |
| **2026-01-13** | Plugin-skill discovery workaround |
| **2026-01-06** | Ralph-Local plugin graduation |
| **2025-12-31** | Plugin Development Guide published |
| **2025-12-31** | Handoff MCP v4 → marketplace |
| **2025-12-28** | Plugin debugging foundation |

---

## Part 5: Open Issues

| # | Status | Title | Priority |
|---|--------|-------|----------|
| #95 | Open | Oracle schedule awareness | Medium |
| #77 | Open | Ralph + claude-mem integration | Medium |
| #57 | Open | Ultra-lean CLAUDE.md | Low |
| #41 | Open | Oracle v2 Repository Init | Low |

---

## Part 6: Installation Commands

```
# Add marketplace (once)
/plugin marketplace add Soul-Brews-Studio/plugin-marketplace

# Install plugins
/plugin install oracle-skills@soul-brews-plugin
/plugin install ralph-soulbrews@soul-brews-plugin

# Uninstall
/plugin uninstall oracle-skills@soul-brews-plugin
```

---

## Appendix: File References

| File | Purpose |
|------|---------|
| `ψ/memory/learnings/2026-01-15_complete-plugin-ecosystem-architecture-for-nat-s-a.md` | Full architecture |
| `ψ/memory/learnings/2026-01-15_mcp-marketplace-skills-discovery-pattern.md` | Skills discovery |
| `ψ/memory/learnings/2026-01-15_claude-code-plugin-skills-vs-local-skills-discover.md` | Namespacing |
| `.claude/docs/SKILL-SYMLINKS.md` | Symlink setup |
| `plugins/.claude-plugin/marketplace.json` | Local registry |

---

**Report End**
