# Team System - Complete Index

All documentation and tools for the team command system.

---

## Quick Links

| Document | Purpose | Read When |
|----------|---------|-----------|
| **QUICK_START.md** | Fast reference with examples | Starting to use the system |
| **IMPLEMENTATION_SUMMARY.md** | Complete overview | Understanding what was built |
| **TEST_REPORT.md** | Detailed test results | Reviewing quality & findings |
| **_template.md** | Core template | Understanding the design |

---

## Tool

| File | Command | Purpose |
|------|---------|---------|
| `scripts/team-log.sh` | `./scripts/team-log.sh [person] [type] "[content]"` | Create log entries |

---

## Command Definitions

| File | Person | Config |
|------|--------|--------|
| `.claude/commands/bm.md` | BM (team member) | Normal priority |
| `.claude/commands/ampere.md` | Ampere (wife) | High priority |

---

## Log Storage

All logs stored in: `ψ/team/[person]/logs/YYYY-MM-DD_HH-MM_[type].md`

### Current Sample Logs

**BM** (6 files):
- `2025-12-18_10-00_schedule.md`
- `2025-12-18_10-05_request.md`
- `2025-12-18_10-10_note.md`
- `2025-12-18_11-32_request.md`
- `2025-12-18_11-32_schedule.md`
- `2025-12-18_11-33_note.md`

**Ampere** (4 files):
- `2025-12-18_10-15_schedule.md`
- `2025-12-18_10-20_buy.md`
- `2025-12-18_11-32_remind.md`
- `2025-12-18_11-33_buy.md`

---

## Getting Started

### 1. Read QUICK_START.md
```bash
cat ψ/team/QUICK_START.md
```

### 2. Try the script
```bash
./scripts/team-log.sh ampere buy "นม ไข่"
```

### 3. Check the created log
```bash
ls ψ/team/ampere/logs/
cat ψ/team/ampere/logs/[latest-file].md
```

### 4. Add aliases (optional)
```bash
alias bm='./scripts/team-log.sh bm'
alias ampere='./scripts/team-log.sh ampere'
bm request "code review"
```

---

## Features at a Glance

### Supported Types
- `schedule` - Calendar events
- `request` - Action needed
- `remind` - Reminders
- `note` - FYI info
- `buy` - Shopping (Ampere only)

### Smart Behavior
- **Auto-priorities**: BM=Normal, Ampere=High
- **Status tracking**: pending vs logged
- **Collision safe**: Prevents overwrite
- **Thai-friendly**: Unicode support

---

## Test Status

All tests PASSED (13/13):
- 5 /bm tests
- 5 /ampere tests
- 3 error handling tests

See TEST_REPORT.md for details.

---

## Production Ready

Yes! The system is ready for daily use.

Next steps are optional enhancements:
- Auto-add to schedule.md
- Search/query helpers
- Status update scripts

---

**Last Updated**: 2025-12-18
**Created by**: Claude Haiku (test suite)
