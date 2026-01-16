# bunx GitHub Packages Don't Install node_modules

**Date**: 2026-01-15
**Context**: Oracle-v2 MCP deployment via bunx
**Severity**: Critical - Silent Failure

## The Problem

`bunx github:owner/repo` **does NOT install dependencies**.

```bash
# This caches the repo but node_modules is empty!
bunx github:Soul-Brews-Studio/oracle-v2

# Server fails silently (exit code 1, no output)
# Because imports can't resolve without node_modules
```

## What bunx Actually Does

1. Downloads repo to `~/.bun/install/cache/@GH@owner-repo-hash@@@1/`
2. Sets up bin symlinks based on package.json `bin` field
3. **DOES NOT run `bun install`**

## The Evidence

```bash
ls ~/.bun/install/cache/@GH@Soul-Brews-Studio-oracle-v2-*
# Shows all files EXCEPT node_modules/

# Contrast with npm packages:
bunx cowsay "hello"  # Works! npm packages come with deps
```

## The Workaround

### Option 1: Local Clone (Recommended for MCP)

```bash
# One-time setup
git clone https://github.com/Soul-Brews-Studio/oracle-v2.git ~/.local/share/oracle-v2
cd ~/.local/share/oracle-v2
bun install

# Claude config uses local path
{
  "oracle-v2": {
    "type": "stdio",
    "command": "bun",
    "args": ["run", "$HOME/.local/share/oracle-v2/src/index.ts"],
    "env": {}
  }
}
```

### Option 2: Publish to npm

```bash
# If published to npm registry, bunx works:
bunx @soul-brews/oracle-v2  # Would work
```

### Option 3: Wrapper Script

```bash
#!/bin/bash
# oracle-v2-install.sh
INSTALL_DIR=~/.local/share/oracle-v2
if [ ! -d "$INSTALL_DIR/node_modules" ]; then
  git clone https://github.com/Soul-Brews-Studio/oracle-v2.git "$INSTALL_DIR"
  cd "$INSTALL_DIR" && bun install
fi
exec bun run "$INSTALL_DIR/src/index.ts" "$@"
```

## Why This Matters

- **Silent failure** - No error message, just exit code 1
- **Wastes hours debugging** - Looks like it should work
- **MCP servers need deps** - TypeScript imports fail without node_modules
- **bunx documentation unclear** - Doesn't mention this limitation

## Key Insight

> **bunx github:repo = "download only"**
> **bunx npm-package = "download + deps"**

The `github:` protocol is essentially just a git clone into cache, not a proper package installation.

## Detection

If bunx GitHub package fails silently:

```bash
# Check if node_modules exists in cache
ls ~/.bun/install/cache/@GH@owner-repo-*/ | grep node_modules
# If missing, that's the issue
```

## Related

- `2026-01-15_bunx-github-auto-bootstrap.md` - Why bunx needs auto-bootstrap
- Oracle-v2 public release retrospective
