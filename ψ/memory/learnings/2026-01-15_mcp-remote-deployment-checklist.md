# MCP Server Remote Deployment Checklist

**Date**: 2026-01-15
**Context**: Oracle Nightly deployment debugging
**Source**: bunx limitation discovery session

## The Problem

MCP servers that work locally often fail on remote/fresh machines due to:
1. Missing dependencies (bunx GitHub limitation)
2. Missing data directories
3. Missing database tables
4. Shell noise (mise, nvm warnings)
5. Version mismatches

## The Checklist

### Before Deployment

- [ ] **Test on fresh machine** - Not just CI, actual fresh install
- [ ] **Check package.json engines** - Version requirements met?
- [ ] **Auto-create directories** - `~/.app/` must exist
- [ ] **Auto-bootstrap tables** - First run should create schema

### Installation Method

| Method | Works? | Notes |
|--------|--------|-------|
| `bunx npm-package` | ✅ | npm packages include deps |
| `bunx github:repo` | ❌ | NO node_modules! |
| `git clone + bun install` | ✅ | Manual but reliable |
| Install script | ✅ | Best UX |

### Claude Config Pattern

```json
{
  "mcpServers": {
    "my-server": {
      "type": "stdio",
      "command": "bun",
      "args": ["run", "$HOME/.local/share/my-server/src/index.ts"],
      "env": {}
    }
  }
}
```

### Testing Commands

```bash
# Test MCP initialize handshake
echo '{"jsonrpc":"2.0","method":"initialize","id":1,"params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"test","version":"1.0"}}}' | timeout 10 bun run src/index.ts

# Expected response contains serverInfo
grep -E "serverInfo|error"
```

### Common Failures

| Symptom | Cause | Fix |
|---------|-------|-----|
| Silent exit 1 | No node_modules | Clone + install |
| ENOENT ~/.app/ | Dir not created | mkdir -p in startup |
| No tables | Schema not pushed | Auto-bootstrap |
| mise WARN spam | Tool version missing | MISE_QUIET=1 or install version |

## Key Insight

> **CI passing ≠ Works everywhere**
>
> CI runs in prepared environment with deps installed.
> bunx on fresh machine has no deps.
> Always test the actual user installation flow.

## Install Script Template

```bash
#!/bin/bash
INSTALL_DIR="${APP_INSTALL_DIR:-$HOME/.local/share/my-app}"
git clone https://github.com/owner/repo.git "$INSTALL_DIR"
cd "$INSTALL_DIR" && bun install
echo "Add to ~/.claude.json..."
```
