---
title: ## Oracle Reverse Tunnel Pattern (Mac → white.local)
tags: [oracle, tunnel, ssh, white.local, reverse-tunnel, port-47778, infrastructure]
created: 2026-01-12
source: SSH tunnel test 2026-01-12
---

# ## Oracle Reverse Tunnel Pattern (Mac → white.local)

## Oracle Reverse Tunnel Pattern (Mac → white.local)

### The Setup
Oracle runs on Mac (workstation), white.local needs access via reverse tunnel.

### Correct Port
**47778** - Oracle HTTP server
(NOT 37778 - that's a different service)

### Tunnel Command (from Mac)
```bash
ssh -R 47778:localhost:47778 nat@white.local -f -N
```

- `-R 47778:localhost:47778` - Reverse tunnel, expose Mac's 47778 on white.local
- `-f` - Background
- `-N` - No command, just tunnel

### How It Works
```
Mac (Oracle :47778)
    │
    │ ssh -R (Mac initiates connection)
    ▼
white.local
    └── localhost:47778 → tunnels back to Mac
```

### Test from white.local
```bash
curl http://localhost:47778/
```

### Why Mac → white.local (not reverse)
- Mac's IP changes, not directly reachable
- white.local has stable Cloudflare tunnel
- Mac initiates = works regardless of Mac's network

### Persistent Tunnel (optional)
Add to Mac's startup or use autossh:
```bash
autossh -M 0 -R 47778:localhost:47778 nat@white.local -f -N
```

---
*Added via Oracle Learn*
