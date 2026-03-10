---
title: Long run CLI building pattern: Built 13 CLIs in one session using consistent tem
tags: [cli-building, bun, commander, pattern, efficiency, long-run]
created: 2025-12-31
source: Practice Session 2025-12-31
---

# Long run CLI building pattern: Built 13 CLIs in one session using consistent tem

Long run CLI building pattern: Built 13 CLIs in one session using consistent template. Simple utilities take 1-2 min, database CLIs take 5 min. Key pattern: mkdir + bun init + commander + write src/index.ts + update package.json (bin/scripts) + test + commit. Learnings: Commander.js negation uses !== false, Drizzle returns camelCase but raw SQL returns snake_case, use import.meta.dir for paths.

---
*Added via Oracle Learn*
