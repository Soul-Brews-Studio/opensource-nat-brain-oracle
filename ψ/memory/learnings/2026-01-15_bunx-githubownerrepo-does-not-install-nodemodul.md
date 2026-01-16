---
title: bunx github:owner/repo does NOT install node_modules. It downloads the repo to ~
tags: [bunx, bun, github, node_modules, MCP, silent-failure, oracle-v2]
created: 2026-01-15
source: 2026-01-15 oracle-v2 remote deployment debugging
---

# bunx github:owner/repo does NOT install node_modules. It downloads the repo to ~

bunx github:owner/repo does NOT install node_modules. It downloads the repo to ~/.bun/install/cache/ but skips dependency installation, causing silent failures (exit 1, no output). Workaround: Clone manually to ~/.local/share/ and bun install, then point Claude MCP config to local path. This differs from bunx with npm packages which DO include dependencies.

---
*Added via Oracle Learn*
