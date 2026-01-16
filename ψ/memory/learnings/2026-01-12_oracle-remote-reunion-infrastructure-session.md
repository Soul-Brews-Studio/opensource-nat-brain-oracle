---
title: Oracle Remote Access + Reunion Infrastructure Patterns
tags: [oracle, supergateway, sse, tunnel, reunion, infrastructure, multi-ai]
created: 2026-01-12
source: Session Retrospective
---

# Oracle Remote Access + Reunion Infrastructure Patterns

## Pattern 1: Supergateway for Remote MCP Access

MCP is stdio-based (local process). To access from another machine:

```bash
# On Mac (Oracle host)
npx supergateway --stdio "bun /path/to/oracle-v2/src/index.ts" --port 9000

# Reverse tunnel to remote
ssh -R 9000:localhost:9000 user@remote -f -N

# On remote - configure Claude
claude mcp add --transport sse --scope user oracle-v2 'http://localhost:9000/sse'
```

**Key insight**: Mac initiates tunnel (works despite dynamic IP), remote sees localhost:9000.

## Pattern 2: Reunion for External Knowledge

External projects' learnings need to flow back to central Oracle:

```
/project reunion [slug]
    ↓
Locate (ghq, SSH, external)
    ↓
Fetch (git pull, scp)
    ↓
Sync to reunion-data/projects/[slug]/
    ↓
Index to Oracle
    ↓
Log + commit
```

**Storage**: Private `reunion-data` repo preserves synced content.

## Pattern 3: AI-to-AI via Oracle Threads

Two AIs on different machines can converse through Oracle threads:

```
AI (Mac) creates Thread #19
    ↓
Asks questions about meshtastic firmware
    ↓
AI (white.local) answers from retrospective
    ↓
Mac AI reads responses, creates build report
    ↓
Knowledge preserved in Oracle
```

## Pattern 4: External Project Registration

```yaml
# ψ/memory/slugs.yaml
meshtastic-firmware: reunion-data://projects/meshtastic-firmware
#   remote: floodboy@white.local:/home/floodboy/meshtastic-firmware
```

Points to reunion-data, comments store actual remote path.

## Anti-patterns Discovered

1. **Guessing ports** - Always `lsof -i :PORT` first
2. **Assuming single user** - Ask which user on remote machines
3. **Local-only thinking** - Oracle can be networked via Supergateway

---

*Session: 2026-01-12 11:29-12:35*
