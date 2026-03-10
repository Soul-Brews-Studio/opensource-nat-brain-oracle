---
title: Soul Brews Plugin Distribution Strategy: Private marketplace over npm public reg
tags: [plugin, marketplace, soul-brews, distribution, bunx, npm, github, architecture, private-registry]
created: 2026-01-15
source: Distilled from trace fda170ea (soulbrews plugin marketplace oracle nats agents)
---

# Soul Brews Plugin Distribution Strategy: Private marketplace over npm public reg

Soul Brews Plugin Distribution Strategy: Private marketplace over npm public registry. The bunx github:owner/repo pattern skips node_modules installation, so the workaround is git clone + bun install. Three-layer architecture: (1) Symlinks for dev (/plugins/ → repos), (2) Marketplace for distribution (plugin@marketplace format), (3) Cache for runtime (~/.claude/plugins/cache/). 11 registered marketplaces spanning personal, organizational, and official sources. Key decision: Skip npm overhead → direct GitHub distribution with auto-bootstrap on fresh install.

---
*Added via Oracle Learn*
