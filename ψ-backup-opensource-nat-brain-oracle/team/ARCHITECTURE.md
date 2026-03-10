# Team Command System - Architecture

Technical overview of how the system works.

---

## Design Philosophy

**Simple. Single responsibility. Extensible.**

Each request from a team member creates a timestamped log file. No database, no complex state management. Just organized files.

---

## Component Overview

```
User Input
   |
   v
scripts/team-log.sh
   |
   +-- Parse arguments
   |   (person, type, content)
   |
   +-- Validate
   |   (check person & type)
   |
   +-- Determine metadata
   |   (status, priority)
   |
   +-- Create log file
   |   ψ/team/[person]/logs/
   |   YYYY-MM-DD_HH-MM_[type].md
   |
   +-- Output summary
   |   (colored, context-aware)
   |
   v
Log File Created
(ready for manual processing)
```

---

## Data Flow

### Input
```
./scripts/team-log.sh bm request "review PR #123"
```

### Processing
```
1. Extract: person="bm", type="request", content="review PR #123"
2. Validate: person exists? type valid?
3. Get time: 2025-12-18 11:32 GMT+7
4. Determine: status="pending", priority="Normal"
5. Render: Markdown template with metadata
6. Write: ψ/team/bm/logs/2025-12-18_11-32_request.md
```

### Output
```
Log created successfully!

Details:
  Person:  BM
  Type:    request
  Time:    2025-12-18 11:32
  Priority: Normal
  Path:    ψ/team/bm/logs/2025-12-18_11-32_request.md

Note: This is marked as pending - needs action
```

---

## File Organization

```
ψ/team/
├── _template.md              <- Blueprint for all logs
├── bm/
│   └── logs/
│       ├── 2025-12-18_10-00_schedule.md
│       ├── 2025-12-18_10-05_request.md
│       └── 2025-12-18_10-10_note.md
└── ampere/
    └── logs/
        ├── 2025-12-18_10-15_schedule.md
        ├── 2025-12-18_10-20_buy.md
        └── 2025-12-18_11-33_buy.md
```

### Key Design Decisions

1. **One file per entry** - Immutable log entries, easy to version
2. **YYYY-MM-DD_HH-MM format** - Sortable by filesystem, human readable
3. **[type] suffix** - Quick filtering (ls *_request.md = all requests)
4. **Person folder** - Separate namespaces, easy to list all from one person

---

## Log File Format

Every log file follows this template:

```markdown
# [Type]: [Summary]

**From**: [Person]
**Time**: [ISO datetime] (GMT+7)
**Type**: [type]
**Status**: [pending|logged|done|cancelled]
**Priority**: [Normal|High]

---

[Full content here]

---

*Logged via /[person] command*
```

Example:
```markdown
# Request: Code review

**From**: BM
**Time**: 2025-12-18 10:05 (GMT+7)
**Type**: request
**Status**: pending
**Priority**: Normal

---

Please help review PR #123

---

*Logged via /bm command*
```

---

## Type System

### Default Types (inherited from template)

| Type | Status | Use Case | Priority |
|------|--------|----------|----------|
| `schedule` | pending | Calendar events | Same as person |
| `request` | pending | Action needed | Same as person |
| `remind` | pending | Reminder | Same as person |
| `note` | logged | FYI only | Same as person |

### Custom Types (per person)

| Type | Person | Status | Use Case |
|------|--------|--------|----------|
| `buy` | Ampere | pending | Shopping lists |

### Status Values

- `pending` - Needs action/processing
- `logged` - FYI only
- `done` - Completed (can be updated manually)
- `cancelled` - No longer needed (can be updated manually)

---

## Priority System

### Person-based Defaults

```
BM       -> Normal priority
Ampere   -> High priority (wife's requests!)
```

### How It's Used

1. Logged as metadata in file
2. Can be used for filtering/sorting
3. Context hints in script output
4. Can be overridden manually if needed

---

## Error Handling

### Validation Layer

```bash
# Check: Is person valid?
if [ "$PERSON" != "bm" ] && [ "$PERSON" != "ampere" ]; then
    ERROR: Unknown person
fi

# Check: Is type valid?
case "$TYPE" in
    schedule|request|note|remind|buy) ;;
    *) ERROR: Unknown type ;;
esac
```

### User Feedback

| Error | Message | Action |
|-------|---------|--------|
| Missing args | Shows usage + examples | User reads examples |
| Invalid person | Lists allowed persons | User corrects |
| Invalid type | Lists allowed types | User corrects |
| File collision | Auto-numbers suffix | File created anyway |

---

## Collision Handling

### Problem
Fast logging might create multiple entries in same minute.

### Solution
Automatic suffix numbering:

```
2025-12-18_11-32_request.md         <- First entry
2025-12-18_11-32_request-1.md       <- Second entry
2025-12-18_11-32_request-2.md       <- Third entry
```

### Implementation
```bash
LOG_FILE="$LOG_DIR/${TIMESTAMP}_${TYPE}.md"
while [ -f "$LOG_FILE" ]; do
    LOG_FILE="${ORIGINAL}_${TYPE}-${COUNTER}.md"
    ((COUNTER++))
done
```

---

## Unicode Support

### Thai Text Handling

```bash
./scripts/team-log.sh ampere buy "นม ไข่ ขนมปัง"
```

Result:
```
**From**: Ampere
**Time**: 2025-12-18 11:33 (GMT+7)
**Content**: นม ไข่ ขนมปัง
```

Thai characters preserved without corruption.

### Key Points
- No character encoding conversion
- Direct pass-through to file
- Terminal must be UTF-8
- Markdown handles Unicode natively

---

## Extensibility Points

### Add New Person

1. Create folder: `ψ/team/[name]/logs/`
2. Create command: `.claude/commands/[name].md`
3. Update script: Add person to validation
4. Test: `./scripts/team-log.sh [name] note "test"`

Example for new person:
```bash
# In scripts/team-log.sh, update person case:
case "$PERSON" in
    bm)
        PERSON_DISPLAY="BM"
        PRIORITY="Normal"
        ;;
    ampere)
        PERSON_DISPLAY="Ampere"
        PRIORITY="High"
        ;;
    john)                    # NEW
        PERSON_DISPLAY="John"
        PRIORITY="Normal"
        ;;
esac
```

### Add New Type

1. Update script type validation
2. Add to case statement for status/priority
3. Add example to documentation
4. Test: `./scripts/team-log.sh [person] [newtype] "content"`

Example:
```bash
# Support "urgent" type
case "$TYPE" in
    schedule|request|note|remind|buy|urgent)
        ;;
esac

# Determine status
case "$TYPE" in
    ...
    urgent)
        STATUS="pending"
        TYPE_TITLE="Urgent"
        ;;
esac
```

---

## Future Enhancements

### Phase 2: Auto-Actions
```bash
if [ "$TYPE" = "schedule" ]; then
    # Auto-add to ψ/inbox/schedule.md
    echo "- $(date '+%b %d') (via ${PERSON_DISPLAY}): ${CONTENT}" >> schedule.md
fi
```

### Phase 3: Query Tools
```bash
# Find all pending requests from Ampere
grep -r "Status.*pending" ψ/team/ampere/logs/

# Count requests by type
find ψ/team/bm/logs -name "*_request.md" | wc -l
```

### Phase 4: Status Updates
```bash
# Change log status from pending to done
./scripts/team-log-update.sh bm 2025-12-18_10-00_request.md done
```

---

## Performance Characteristics

| Operation | Time | Notes |
|-----------|------|-------|
| Create log | < 100ms | File write + validation |
| List logs | < 50ms | Directory listing |
| Find log | < 500ms | Grep across logs |
| Total workflow | < 200ms | User sees response immediately |

---

## Storage Requirements

| Factor | Size | Notes |
|--------|------|-------|
| Per log file | ~200 bytes | Small Markdown |
| 100 logs | ~20 KB | Negligible |
| 1000 logs | ~200 KB | Still tiny |
| Directory structure | < 1 KB | Just metadata |

**Conclusion**: No storage concerns for years of use.

---

## Version History

| Version | Date | Notes |
|---------|------|-------|
| 1.0 | 2025-12-18 | Initial release, production-ready |

---

## Conclusion

The system is architecturally simple, scalable, and maintainable. 

**Core principle**: Let the filesystem do the work. No databases, no complex state. Just organized files.

