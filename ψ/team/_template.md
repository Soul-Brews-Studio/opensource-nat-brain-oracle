# Team Member Command Template

Base template for team member **namespace commands**.

Team members have Claude Code and can:
1. Run direct actions (request, note, schedule, etc.) → Creates GH Issues
2. Run compound commands (`/[name] /[command]`) → Logged + executed
3. Access Oracle/knowledge with attribution

---

## Usage Pattern

```
/[name] [type] [content]
```

## Default Types

| Type | Description | Auto-action |
|------|-------------|-------------|
| `schedule` | Add event | → Also add to `ψ/inbox/schedule.md` |
| `request` | Request from Nat | → pending status |
| `note` | General info | → logged only |
| `remind` | Reminder | → pending status |

## Default Action

1. Parse: `[type]` and `[content]`
2. Get current timestamp (GMT+7)
3. Create log file: `ψ/team/[name]/logs/YYYY-MM-DD_HH-MM_[type].md`
4. Create GitHub Issue (if applicable):
   ```bash
   gh issue create \
     --title "[Name] [type]: [summary]" \
     --label "team,[name],[type]" \
     --body "[content]\n\nLog: ψ/team/[name]/logs/[filename]"
   ```
5. If type = `schedule`:
   - Add to `ψ/inbox/schedule.md` with `(via [Name])` tag
6. **Auto-commit & push** (conflict-free!):
   ```bash
   git add ψ/team/[name]/
   git commit -m "[name]: [type] - [summary]"
   git push
   ```
7. Confirm with: Issue #XX + commit hash

## Log File Format

Each log entry is a separate file in `ψ/team/[name]/logs/`:

**Filename**: `YYYY-MM-DD_HH-MM_[type].md`

**Content**:
```markdown
# [Type]: [Summary]

**From**: [Name]
**Time**: YYYY-MM-DD HH:MM (GMT+7)
**Type**: [type]
**Status**: pending

---

[Full content here]

---

*Logged via /[name] command*
```

**Example**: `ψ/team/ampere/logs/2025-12-18_11-25_schedule.md`

## Status Values

| Status | Meaning |
|--------|---------|
| `pending` | New, not addressed |
| `done` | Completed |
| `cancelled` | No longer needed |
| `scheduled` | Added to calendar |

## Override Points

Commands can override:
- **Types**: Add custom types (e.g., `buy` for shopping)
- **Priority**: Set default priority level
- **Auto-actions**: Add special behaviors
- **Role**: Define relationship

---

*This is a template. Do not use directly. Use /bm, /ampere, etc.*
