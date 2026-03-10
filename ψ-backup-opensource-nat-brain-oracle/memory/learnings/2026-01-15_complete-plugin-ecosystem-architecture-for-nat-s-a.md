---
title: Complete Plugin Ecosystem Architecture for Nat-s-Agents:
tags: [plugin, marketplace, nat-agents-core, oracle-skills, soul-brews, distribution, bunx, architecture]
created: 2026-01-15
source: Traced from /trace --deep: Soul-Brews + nat-agents + marketplace (5 parallel agents)
---

# Complete Plugin Ecosystem Architecture for Nat-s-Agents:

Complete Plugin Ecosystem Architecture for Nat-s-Agents:

**11 Registered Marketplaces**:
- nat-plugins (local directory with symlinks)
- nat-agents-core, nat-data-personal, claude-voice-notify (laris-co GitHub)
- oracle-skills, ralph-local, claude-project-manager (Soul-Brews-Studio)
- claude-plugins-official, anthropic-agent-skills, claude-code-plugins (Anthropic)
- thedotmack (claude-mem), dev-browser-marketplace

**Key Plugins**:
- nat-agents-core v1.10.0: executor, coder, context-finder, planner agents + /oracle-init, /soul-init commands
- oracle-skills v1.0.2: "The 13 skills that survived The Great Archive Migration" (79→0→13)
- ralph-local v1.0.0: Self-referential AI loops

**Architecture Patterns**:
- Symlinks in /plugins/ → external repos (dev convenience)
- Cache at ~/.claude/plugins/cache/[marketplace]/
- Three scopes: User (global), Local (project), Project (workspace)

**Distribution Decision** (Jan 15, 2026):
- Skip npm public registry → Use private marketplace + bunx workaround
- bunx github:owner/repo does NOT install node_modules
- Solution: git clone + bun install, not bunx

**Pending**: Create Soul-Brews MCP Marketplace repo to bundle oracle-v2 + skills

---
*Added via Oracle Learn*
