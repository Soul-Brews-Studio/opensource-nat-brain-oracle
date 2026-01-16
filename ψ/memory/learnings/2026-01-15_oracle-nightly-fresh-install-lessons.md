---
title: Oracle Nightly Fresh Install Lessons
created: 2026-01-15
tags: [oracle-nightly, fresh-install, testing, git-tracking, mcp]
---

# Oracle Nightly Fresh Install Lessons

## The Core Problem

Fresh install worked locally but failed on remote machines. Multiple issues discovered through remote testing.

## Lessons Learned

### 1. Check What Git Actually Tracks

**Mistake**: Assumed `frontend/dist/` was fully committed because files existed locally.

**Reality**: Only `index.html` and `vite.svg` were tracked. `assets/` folder (built JS/CSS) was gitignored.

**Fix**: Add build step to install script.

```bash
# Wrong assumption
ls frontend/dist/  # Shows all files

# Correct check
git ls-files frontend/dist/  # Shows only tracked files
```

### 2. Test Runners Can Conflict

**Problem**: `bun test` picked up Playwright tests meant for `playwright test`.

**Error**: `test.describe() not expected here`

**Fix**: `bunfig.toml` to scope Bun tests:
```toml
[test]
root = "src"
```

### 3. Show All Network URLs

Remote users need to know how to access from other machines.

```bash
# Get all URLs
echo "http://localhost:47778"
echo "http://$(hostname):47778"
for IP in $(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '127.0.0.1'); do
    echo "http://${IP}:47778"
done
```

### 4. MCP Auto-Start Already Exists

Oracle-v2 has claude-mem's daemon pattern built-in:

```typescript
// src/index.ts - MCP startup
await ensureServerRunning({ background: true, timeout: 5000 });
```

MCP tools auto-start HTTP server. No manual `bun run server` needed.

### 5. Use Claude CLI for MCP

Don't manually edit `~/.claude.json`:

```bash
# Add
claude mcp add oracle-v2 -- bun run ~/.local/share/oracle-v2/src/index.ts

# Remove
claude mcp remove oracle-v2

# List
claude mcp list
```

## Fresh Install Checklist

After any fresh install changes:

- [ ] Delete local installation completely
- [ ] Run install script on different machine
- [ ] Check all endpoints respond
- [ ] Verify frontend loads (not blank)
- [ ] Test search returns results
- [ ] Confirm all URLs displayed

## Key Commands

```bash
# Fresh install
curl -sSL https://raw.githubusercontent.com/Soul-Brews-Studio/oracle-v2/main/scripts/fresh-install.sh | bash

# Verify
curl http://localhost:47778/api/health
curl "http://localhost:47778/api/search?q=nothing+deleted"

# MCP setup
claude mcp add oracle-v2 -- bun run ~/.local/share/oracle-v2/src/index.ts
```

---

*Learned during Oracle Nightly v0.2.1 fresh install polish, 2026-01-15*
