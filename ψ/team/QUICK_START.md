# Team Logging - Quick Start Guide

Fast reference for using the team command system.

---

## One-Liner Usage

```bash
./scripts/team-log.sh [person] [type] "[content]"
```

---

## Examples by Scenario

### BM Requests

```bash
# Code review needed
./scripts/team-log.sh bm request "review PR #123"

# Scheduled meeting
./scripts/team-log.sh bm schedule "Jan 5 10:00 Project review"

# Quick note
./scripts/team-log.sh bm note "Server maintenance completed"

# Reminder for you
./scripts/team-log.sh bm remind "need to send invoice before end of month"
```

### Ampere Requests

```bash
# Shopping list
./scripts/team-log.sh ampere buy "นม ไข่ ขนมปัง"

# Schedule family time
./scripts/team-log.sh ampere schedule "Dec 25 visit mom"

# Reminder for you
./scripts/team-log.sh ampere remind "ต่อประกันรถ"

# Quick update
./scripts/team-log.sh ampere note "shoes arrived"
```

---

## Type Reference

| Type | Status | When to Use | Example |
|------|--------|------------|---------|
| `schedule` | pending | Calendar event | "Jan 5 10:00 meeting" |
| `request` | pending | Action needed | "review my code" |
| `remind` | pending | Set reminder | "send invoice" |
| `note` | logged | FYI info | "updated server" |
| `buy` | pending | Shopping (Ampere only) | "milk eggs" |

---

## What Gets Created?

Each command creates:

1. **Log file**: `ψ/team/[person]/logs/YYYY-MM-DD_HH-MM_[type].md`
   - Contains full details
   - Marked with status (pending/logged)
   - Timestamped

2. **Console output**: Summary showing
   - Person name
   - Type
   - Time
   - Priority level
   - File path

---

## Important Notes

### Priority Levels
- **BM**: Normal priority
- **Ampere**: HIGH priority (wife's requests are important!)

### Status Meanings
- `pending` - Needs action or scheduling
- `logged` - FYI only, no action required

### Log Location
All logs go to: `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/team/[person]/logs/`

---

## Quick Tips

1. **Put quotes around multi-word content**
   ```bash
   ✅ ./scripts/team-log.sh bm request "review PR #123"
   ❌ ./scripts/team-log.sh bm request review PR #123
   ```

2. **Thai text works fine**
   ```bash
   ./scripts/team-log.sh ampere buy "นม ไข่ ผ้าเช็ดตัว"
   ```

3. **For schedule items**
   Include the date/time in content
   ```bash
   ./scripts/team-log.sh bm schedule "Jan 10 14:00 Team standup"
   ```

4. **For shopping (ampere)**
   Just list the items
   ```bash
   ./scripts/team-log.sh ampere buy "กระบอก น้ำผลไม้ ขนม"
   ```

---

## Common Workflows

### Morning Standup with BM
```bash
./scripts/team-log.sh bm request "review my changes"
./scripts/team-log.sh bm schedule "Jan 15 10:00 Code review session"
```

### Ampere's Shopping List
```bash
./scripts/team-log.sh ampere buy "นม ไข่"
./scripts/team-log.sh ampere buy "ผงซักฟอก"
./scripts/team-log.sh ampere buy "น้ำยาล้างจาน"
```

### End of Day Notes
```bash
./scripts/team-log.sh bm note "API deployment complete"
./scripts/team-log.sh ampere note "grocery delivered"
```

---

## Finding Your Logs

List all BM logs:
```bash
ls -la ψ/team/bm/logs/
```

List all Ampere logs:
```bash
ls -la ψ/team/ampere/logs/
```

View a specific log:
```bash
cat ψ/team/bm/logs/2025-12-18_10-00_request.md
```

---

## Next Steps

1. Create a shortcut alias (optional):
   ```bash
   alias bm='./scripts/team-log.sh bm'
   alias ampere='./scripts/team-log.sh ampere'
   ```
   Then use: `bm request "code review"`

2. Check the test report: `ψ/team/TEST_REPORT.md`

3. Read the full template: `ψ/team/_template.md`

---

**That's it!** The system is ready to use.
