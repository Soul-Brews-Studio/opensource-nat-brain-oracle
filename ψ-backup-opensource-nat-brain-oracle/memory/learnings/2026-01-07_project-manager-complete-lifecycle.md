# Project Manager Complete Lifecycle

**Date**: 2026-01-07

## What We Learned

- Built complete project lifecycle: learn → incubate → spinoff → reunion → offload
- Added `history.sh` for git timeline analysis (your earlier idea about git logs)
- Reunion pattern: scan ψ/memory, oracle_learn, auto-offload
- Offload creates restore point - can relearn/reincubate anytime
- Slug format should be `owner/repo` (like gh/ghq) to avoid collision

## How Things Connect

```
/project learn     → 📚 ψ/learn/repo/ (symlink)
/project incubate  → 🌱 ψ/incubate/repo/ (symlink)
/project reunion   → 🤝 scan + oracle_learn + offload
/project offload   → 📤 remove symlink (ghq keeps repo)
/project history   → 📊 git timeline analysis
```

Slugs: `owner/repo` format with mixed lookup (full path priority, short slug fallback)

## Session Highlights

- Started with `/trace pocketbase` → discovered reunion was missing
- Built 6 scripts in project-manager skill
- Fixed `rm -f` → `unlink` for symlinks
- `/learn esphome-fw` worked with 3 parallel Haiku agents
- Tested `history.sh` on claude-mem (992 commits!) and esphome-fw

## Tags

`project-manager` `reunion` `offload` `history` `slug-format` `lifecycle`
