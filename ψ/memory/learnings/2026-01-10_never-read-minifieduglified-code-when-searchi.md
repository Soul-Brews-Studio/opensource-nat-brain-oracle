---
title: ## Never Read Minified/Uglified Code
tags: [code-reading, minified, source, rule, token-efficiency]
created: 2026-01-10
source: Session 2026-01-10
---

# ## Never Read Minified/Uglified Code

## Never Read Minified/Uglified Code

When searching or reading code:
- **NEVER** read files in `dist/`, `build/`, `.next/`, `out/` directories
- **NEVER** read minified `.min.js`, `.min.css` files
- **NEVER** read bundled files with hash names like `index-BC8w-E1V.js`

**ALWAYS** find and read the original source files:
- `src/` directory
- Original `.ts`, `.tsx`, `.js` files
- Unminified configuration files

Why: Minified code wastes tokens and is unreadable. The original source has comments, proper formatting, and actual intent.

---
*Added via Oracle Learn*
