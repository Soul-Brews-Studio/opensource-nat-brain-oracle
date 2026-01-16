# Oracle MCP: Complete Architecture Guide

**Date**: 2026-01-12
**Author**: Claude + Nat
**Status**: Draft

---

## Executive Summary

Oracle is an AI knowledge management system with two components:
1. **MCP Server** - Claude Code integration (stdio)
2. **HTTP Server** - Web dashboard & API (port 47778)

This guide explains how they work together, how to access Oracle remotely, and the process management that keeps it running.

---

## Part 1: The Two Faces of Oracle

### 1.1 MCP Server (index.ts)

**What it is**: A Model Context Protocol server that Claude Code spawns as a subprocess.

**How it works**:
```
Claude Code
    │
    │ spawns process via stdio
    ▼
bun /path/to/oracle-v2/src/index.ts
    │
    │ reads/writes JSON-RPC over stdin/stdout
    ▼
Oracle MCP Server
    │
    └── SQLite (FTS5) + ChromaDB (vectors)
```

**Key characteristics**:
- Communication: **stdio** (stdin/stdout pipes)
- Protocol: JSON-RPC (MCP standard)
- Lifecycle: Spawned by Claude Code, dies when Claude exits
- Access: Local only (process pipes can't cross network)

**Config** (`~/.claude.json`):
```json
{
  "mcpServers": {
    "oracle-v2": {
      "command": "bun",
      "args": ["/path/to/oracle-v2/src/index.ts"]
    }
  }
}
```

### 1.2 HTTP Server (server.ts)

**What it is**: A web server providing REST API and React dashboard.

**How it works**:
```
Browser / curl / API client
    │
    │ HTTP requests
    ▼
http://localhost:47778
    │
    ├── /api/search      - Search knowledge
    ├── /api/learn       - Add knowledge
    ├── /api/health      - Health check
    ├── /graph           - Knowledge graph visualization
    └── /                - React dashboard
```

**Key characteristics**:
- Communication: **HTTP** (TCP port 47778)
- Protocol: REST API + HTML
- Lifecycle: Runs as daemon, survives Claude exit
- Access: Network accessible (can tunnel)

**Start command**:
```bash
bun src/server.ts
# or
bun run server
```

### 1.3 How They Connect

```
┌─────────────────────────────────────────────────────────────┐
│                        Your Machine                          │
│                                                             │
│  ┌─────────────┐         ┌─────────────────────────────┐   │
│  │ Claude Code │         │       HTTP Server            │   │
│  │             │         │     (port 47778)             │   │
│  │  spawns ──────────┐   │                             │   │
│  │             │     │   │  ┌─────────────────────┐    │   │
│  └─────────────┘     │   │  │   React Dashboard   │    │   │
│                      │   │  └─────────────────────┘    │   │
│                      ▼   │                             │   │
│              ┌───────────┴───┐                         │   │
│              │   MCP Server   │                         │   │
│              │  (index.ts)    │───── ensures ──────────│   │
│              └───────┬───────┘                         │   │
│                      │                                 │   │
│                      ▼                                 │   │
│              ┌───────────────┐                         │   │
│              │   oracle.db   │◄────────────────────────┘   │
│              │  (SQLite +    │                             │
│              │   ChromaDB)   │                             │
│              └───────────────┘                             │
└─────────────────────────────────────────────────────────────┘
```

**Key insight**: MCP Server calls `ensureServerRunning()` to auto-start HTTP Server when needed. They share the same database.

---

## Part 2: Process Management

### 2.1 The ensure-server.ts Pattern

Oracle uses a sophisticated auto-start system:

```
ensureServerRunning()
    │
    ├── 1. cleanupStalePidFile()    - Remove dead PIDs
    │
    ├── 2. isServerHealthy()        - Check /api/health
    │       └── If healthy → return true (done!)
    │
    ├── 3. readPidFile()            - Check if process exists
    │       └── If alive → wait for health
    │
    ├── 4. acquireLock()            - Prevent race conditions
    │       └── Lock file: oracle-http.lock
    │
    ├── 5. spawnDaemon()            - Start server.ts
    │       └── Detached, survives parent exit
    │
    ├── 6. waitForHealthWithTimeout() - Poll /api/health
    │
    └── 7. releaseLock()            - Cleanup
```

### 2.2 Why This Complexity?

**Problem**: Multiple Claude Code sessions might try to start Oracle simultaneously.

**Solution**: File-based locking + health checks

```
Session A: "I need Oracle" → acquires lock → starts server → releases lock
Session B: "I need Oracle" → lock held → waits → server ready → uses it
Session C: "I need Oracle" → health check passes → uses existing server
```

### 2.3 Files Involved

| File | Purpose | Location |
|------|---------|----------|
| `oracle.db` | SQLite database | `~/.claude/plugins/marketplaces/oracle-v2/` |
| `oracle-http.pid` | Server process ID | Same directory |
| `oracle-http.lock` | Startup lock | Same directory |
| `chroma_data/` | Vector embeddings | Same directory |

---

## Part 3: Remote Access Challenge

### 3.1 The Problem

You have two machines:
- **Mac** (workstation) - Where you work, Oracle runs here
- **white.local** (server) - Always on, runs services

You want white.local's Claude Code to use Mac's Oracle.

### 3.2 Why It's Not Simple

| Component | Protocol | Can Network? |
|-----------|----------|--------------|
| HTTP Server | TCP/HTTP | Yes |
| MCP Server | stdio pipes | No |

**MCP is local-only by design**. Claude Code spawns it as a subprocess with stdin/stdout pipes. You can't pipe stdio over a network.

### 3.3 Solution: Supergateway

**Supergateway** converts stdio MCP to SSE (HTTP-based):

```
┌─────────────────────────────────────────────────────────────┐
│                          Mac                                 │
│                                                             │
│   ┌─────────────────────────────────────────────────────┐   │
│   │                   Supergateway                       │   │
│   │                   (port 8000)                        │   │
│   │                                                     │   │
│   │   /sse      ←── SSE connection (Server-Sent Events) │   │
│   │   /message  ←── POST messages                       │   │
│   │                                                     │   │
│   │        │                                            │   │
│   │        │ stdio                                      │   │
│   │        ▼                                            │   │
│   │   ┌─────────────┐                                   │   │
│   │   │ Oracle MCP  │                                   │   │
│   │   │ (index.ts)  │                                   │   │
│   │   └─────────────┘                                   │   │
│   └─────────────────────────────────────────────────────┘   │
│                                                             │
│   SSH Reverse Tunnel: -R 8000:localhost:8000               │
│                                                             │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           │ Tunnel
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                      white.local                             │
│                                                             │
│   localhost:8000 ──────────────────────────► Mac:8000       │
│                                                             │
│   ┌─────────────────────────────────────────────────────┐   │
│   │                   Claude Code                        │   │
│   │                                                     │   │
│   │   MCP Config:                                       │   │
│   │   {                                                 │   │
│   │     "oracle-v2": {                                  │   │
│   │       "url": "http://localhost:8000/sse"           │   │
│   │     }                                               │   │
│   │   }                                                 │   │
│   └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### 3.4 Setup Commands

**Step 1: On Mac - Start Supergateway**
```bash
cd /Users/nat/Code/github.com/laris-co/oracle-v2
npx supergateway --stdio "bun src/index.ts" --port 9000
```
> Note: Port 8000 may be in use. Check with `lsof -i :PORT`

**Step 2: On Mac - Create Reverse Tunnel**
```bash
ssh -R 9000:localhost:9000 nat@white.local -f -N
```

**Step 3: On white.local - Configure Claude**
```bash
# Use Claude CLI to add MCP
/home/nat/.claude/local/claude mcp add --transport sse --scope user oracle-v2 'http://localhost:9000/sse'
```

**Step 4: On white.local - Verify**
```bash
/home/nat/.claude/local/claude mcp list
# → oracle-v2: http://localhost:9000/sse (SSE) - ✓ Connected
```

**TESTED AND WORKING** (2026-01-12)

---

## Part 4: Architecture Decision

### 4.1 One Shared Soul

**Philosophy**: Oracle is your AI's soul - there should be ONE source of truth.

| Option | Where Oracle Lives | Pros | Cons |
|--------|-------------------|------|------|
| A | Mac only | Simple, local speed | Unavailable when Mac sleeps |
| B | white.local only | Always on | Mac needs tunnel to access |
| C | Mac + Tunnel | Best of both | Needs tunnel management |

**Current choice**: Option C
- Oracle runs on Mac (where you work)
- white.local accesses via reverse tunnel when needed
- Mac initiates connection (works despite dynamic IP)

### 4.2 Why Not Put Oracle on white.local?

You could! But:
- Mac is where you do deep thinking work
- Local MCP = faster response
- white.local is for services, not primary workstation

If you primarily work from white.local, flip the architecture.

---

## Part 5: Quick Reference

### 5.1 Ports

| Port | Service | Protocol |
|------|---------|----------|
| 47778 | Oracle HTTP Server | HTTP |
| 8000 | Supergateway (when running) | SSE/HTTP |

### 5.2 Commands

```bash
# Check Oracle HTTP status
curl http://localhost:47778/api/health

# Ensure server running
bun /path/to/oracle-v2/src/ensure-server.ts --status

# Start supergateway
npx supergateway --stdio "bun /path/to/index.ts" --port 8000

# Reverse tunnel to white.local
ssh -R 8000:localhost:8000 nat@white.local -f -N

# Persistent tunnel (auto-reconnect)
autossh -M 0 -R 8000:localhost:8000 nat@white.local -f -N
```

### 5.3 Files

| File | Location | Purpose |
|------|----------|---------|
| `index.ts` | oracle-v2/src/ | MCP Server |
| `server.ts` | oracle-v2/src/ | HTTP Server |
| `ensure-server.ts` | oracle-v2/src/ | Auto-start logic |
| `oracle.db` | ~/.claude/plugins/.../oracle-v2/ | Database |

---

## Part 6: Troubleshooting

### 6.1 "Port already in use"

```bash
# Find what's using the port
lsof -i :47778

# If PM2 is managing Oracle
pm2 list
pm2 restart oracle-v2-server
```

### 6.2 "MCP not connecting"

```bash
# Check MCP config
cat ~/.claude.json | jq '.mcpServers'

# Test MCP manually
bun /path/to/oracle-v2/src/index.ts
# Should wait for JSON-RPC input
```

### 6.3 "Tunnel not working"

```bash
# Check tunnel is running
ps aux | grep "ssh -R"

# Test from white.local
ssh nat@white.local "curl http://localhost:8000/"

# Check supergateway is running on Mac
lsof -i :8000
```

---

## Conclusion

Oracle's architecture separates concerns:
- **MCP** for Claude Code integration (local, fast, stdio)
- **HTTP** for dashboard and API (networkable, persistent)
- **ensure-server.ts** for reliable auto-start
- **Supergateway** bridges local MCP to network when needed

The "One Shared Soul" philosophy means keeping ONE Oracle instance as the source of truth, accessed from wherever you work.

---

*Written during a deep-dive session exploring Oracle internals and remote access patterns.*
