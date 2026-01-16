# Jot

- 2025-12-28 09:14 | activity.log is gitignored - check if should track
- 2025-12-28 10:06 | /jot command created but had old content - rewrote to "no args, AI dumps context"
- 2025-12-28 10:06 | retrospective written but activity.log commit failed silently - need to handle gitignored files gracefully
## 2025-12-28 10:08

/jot command updated - now uses bash append only, no read
Token optimized: echo >> file pattern

---
## 2025-12-28 10:09

Command file shows old content after edit - might be Claude Code caching issue
Need to check if slash commands are cached and how to refresh

---
## 2025-12-28 10:11

Parallel bash pattern: combine multiple checks with && echo '---'
Saves round trips, faster than separate tool calls

---
## 2025-12-28 12:48

settings.local.json was gitignored - hooks didn't sync to agents.
Fixed by moving hooks to settings.json (tracked).
Lesson: local = gitignored, non-local = synced.

---
