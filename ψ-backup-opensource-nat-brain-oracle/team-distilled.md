# Team Command System — Distilled

> Distilled from `team/` directory (28 files: architecture docs, profiles, logs)
> All entries from 2025-12-18
> Distilled: 2026-03-11

---

## System Overview

A file-based team command system for logging requests, schedules, and notes for team members. No database — each entry creates a timestamped markdown file.

### Architecture
- **Design**: Simple, single responsibility, extensible
- **Script**: `scripts/team-log.sh` parses input, validates, creates log file
- **Format**: `YYYY-MM-DD_HH-MM_[type].md`
- **Types**: schedule, request, note, buy, remind, query, show-schedule
- **Template**: `_template.md` blueprint for all log entries
- **Priority levels**: Normal, High (auto-set for reminders), Low

### File Structure
```
team/
├── _template.md
├── ampere/
│   ├── profile.md
│   └── logs/  (9 entries)
└── bm/
    ├── profile.md
    └── logs/  (10 entries)
```

---

## Team Members

### Ampere
- **Relationship**: Team member
- **Profile**: Tracked via `ampere/profile.md`

### BM
- **Relationship**: Team member / collaborator
- **Profile**: Tracked via `bm/profile.md`

---

## Log Summary (2025-12-18)

### Ampere Logs (9 entries, 10:15-15:42)

| Time | Type | Summary |
|------|------|---------|
| 10:15 | schedule | Schedule entry |
| 10:20 | buy | Purchase request |
| 11:32 | remind | Reminder |
| 11:33 | buy | Purchase request |
| 12:33 | query | Information query |
| 12:34 | remind | Reminder |
| 12:37 | remind | Reminder |
| 12:40 | remind | Reminder |
| 15:42 | remind | Reminder |

### BM Logs (10 entries, 10:00-12:28)

| Time | Type | Summary |
|------|------|---------|
| 10:00 | schedule | Schedule entry |
| 10:05 | request | Action request |
| 10:10 | note | General note |
| 11:32 | request | Action request |
| 11:32 | schedule | Schedule entry |
| 11:33 | note | General note |
| 11:35 | note | General note |
| 12:22 | show-schedule | Schedule display request |
| 12:24 | query | Information query |
| 12:28 | query | Information query |

---

## Supporting Documentation

### Architecture Docs (5 files)
- **ARCHITECTURE.md**: Technical overview of team-log.sh data flow
- **IMPLEMENTATION_SUMMARY.md**: Implementation details and status
- **INDEX.md**: Quick navigation index
- **QUICK_START.md**: Getting started guide
- **TEST_REPORT.md** + **TESTING_COMPLETE.md**: Test results and completion status

### Key Design Decisions
1. One file per entry — immutable, easy to version
2. Timestamped filenames — sortable by filesystem
3. Type suffix — enables filtering (`ls *_request.md`)
4. No database — filesystem IS the database
5. Markdown format — human-readable, AI-parseable

---

*Distilled from 28 team files (2 profiles, 19 logs, 7 docs)*
*Source directory: `team/`*
