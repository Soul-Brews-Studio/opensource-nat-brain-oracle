# Handoff: Oracle-v2 Open Source Ready

**Date**: 2026-01-15 10:02
**Context**: 79%

## What We Did

### Oracle-v2 Cleanup (Ready for Open Source)
- Removed all hardcoded `/Users/nat/` paths → `process.cwd()` or `$HOME`
- Port migration 37778 → 47778 in all docs
- Fixed frontend build (unused vars)
- Added `bun-types` for TypeScript
- DB correctly defaults to `~/.oracle-v2/`
- Repo size: 8.7MB (acceptable, BFG later if needed)

### npm Publish Infrastructure
- Package renamed: `@laris-co/oracle-v2`
- Added `bin` field for npx support
- Created `.github/workflows/publish.yml` (auto-publish on push)
- Version format: `0.YYYYMMDD.HHMM` (nightly always)
- **Not activated** - needs `NPM_TOKEN` secret in GitHub

### Handoff System
- Fixed stale handoff bug (hook reads `handoff.log`)
- Archived 42 old handoff files → `ψ/memory/archive/handoffs/`
- Pattern: Append to `handoff.log` → Archive when done

### Commits (oracle-v2)
| Hash | Message |
|------|---------|
| 4965782 | security: Remove all hardcoded personal paths |
| c18521f | fix: Port migration 37778 → 47778 + frontend build fixes |
| 72f91d4 | ci: Add npm auto-publish workflow (nightly) |

## Open Question: Distribution Strategy

**User asks**: "How to go open source? Which is best: marketplace, GitHub, or npx?"

### Options Discovered

| Method | Pros | Cons |
|--------|------|------|
| **GitHub only** | Simple, no setup | Manual clone + setup |
| **npm + npx** | One-liner install | Need npm account + token |
| **MCP Registry** | Official Anthropic discovery | Need to submit |
| **mcp.so** | Community visibility | Third-party |
| **Plugin marketplace** | Bundled install | More complex setup |

### Recommended Path

1. **Now**: GitHub + README with manual install
   ```bash
   git clone https://github.com/laris-co/oracle-v2
   cd oracle-v2 && ./scripts/setup.sh
   claude mcp add oracle-v2 -- bun $PWD/src/index.ts
   ```

2. **Soon**: Add npm publishing
   - Create npm account for laris-co
   - Add `NPM_TOKEN` to GitHub secrets
   - Auto-publish activates
   ```bash
   claude mcp add oracle-v2 -- npx @laris-co/oracle-v2
   ```

3. **Later**: Submit to official MCP Registry
   - URL: `https://api.anthropic.com/mcp-registry/docs`
   - Gets oracle-v2 in Claude Code discovery

## Pending

- [ ] Push MISSION-05 to Soul-Brews-Studio
- [ ] Tell BM: setup fix is ready (`git pull && ./scripts/setup.sh`)
- [ ] Decide: npm publish now or later?
- [ ] Submit to MCP Registry (when ready)
- [ ] BFG cleanup for old blobs (not urgent)

## Key Files Changed

| Repo | File | Change |
|------|------|--------|
| oracle-v2 | `package.json` | Renamed to `@laris-co/oracle-v2`, added bin |
| oracle-v2 | `.github/workflows/publish.yml` | NEW - auto npm publish |
| oracle-v2 | `src/*.ts` | Removed hardcoded paths |
| oracle-v2 | `docs/*.md` | Port 47778 |
| Nat-s-Agents | `ψ/inbox/handoff.log` | Updated with current session |

## For Next Session

1. Decide on npm publish (yes/no/later)
2. If yes: Set up npm account + token
3. Update oracle-v2 README with install instructions
4. Consider submitting to MCP Registry

---

*"Oracle-v2 is clean. Distribution is the next question."*
