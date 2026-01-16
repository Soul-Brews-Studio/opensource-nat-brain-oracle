# Module 3: Commands

> "Automate repetitive tasks" | 1.5 hours | Intermediate

## Learning Objectives

หลังจบ module นี้ ผู้เรียนจะ:
- เข้าใจ slash command system
- สร้าง custom commands ได้
- Chain commands เข้าด้วยกัน
- มี 5+ business commands พร้อมใช้

## What is a Command?

**Command = Shortcut ที่ expand เป็น prompt**

```
User: /daily-report
Claude: *receives expanded prompt*
        *executes the defined workflow*
```

### vs Skill

| Aspect | Command | Skill |
|--------|---------|-------|
| Invocation | `/command` | Natural language |
| Scope | Per project | Global |
| Arguments | Yes | No |
| Best for | Automation | Workflows |

## Command File Location

```
your-project/
├── .claude/
│   └── commands/
│       ├── daily-report.md
│       ├── client-summary.md
│       └── project-status.md
```

## Command File Anatomy

```markdown
# /command-name - Short description

What this command does.

## Usage
/command-name [optional-args]

## Implementation

[Prompt that Claude receives when command is invoked]
```

### Real Example: /rrr (Retrospective)

```markdown
# /rrr - Create session retrospective

สร้าง retrospective เมื่อจบ session

## Usage
/rrr

## Implementation

Create a retrospective file with:
1. What was accomplished
2. What went well
3. What could improve
4. Lessons learned
5. Next steps

Save to: ψ/memory/retrospectives/[date].md
```

## Creating Your First Command

### Step 1: Create Directory
```bash
mkdir -p .claude/commands
```

### Step 2: Create Command File
```bash
touch .claude/commands/hello.md
```

### Step 3: Write Content
```markdown
# /hello - Display a greeting

A simple test command.

## Implementation

Say "Hello! The current time is [time]" and ask how you can help today.
```

### Step 4: Test
```
User: /hello
Claude: "Hello! The current time is 17:55. How can I help you today?"
```

## Hands-On Exercise 1: Daily Report Command

### Create: `.claude/commands/daily-report.md`

```markdown
# /daily-report - Generate daily business report

สร้าง daily report จากข้อมูลในระบบ

## Usage
/daily-report [date?]

## Implementation

Generate a daily business report with:

### 1. Summary
- Key metrics from today
- Notable events
- Issues requiring attention

### 2. Tasks Completed
List all completed tasks from today's activity log.

### 3. Tasks In Progress
List ongoing work with status.

### 4. Blockers
Any issues blocking progress.

### 5. Tomorrow's Priorities
Top 3 priorities for next day.

### Output Format
```markdown
# Daily Report: [DATE]

## Summary
[3-5 bullet executive summary]

## Completed Today
- [x] Task 1
- [x] Task 2

## In Progress
- [ ] Task A (50%)
- [ ] Task B (70%)

## Blockers
- [Blocker 1] - [Impact] - [Needed action]

## Tomorrow's Priorities
1. Priority 1
2. Priority 2
3. Priority 3

---
Generated: [timestamp]
```
```

### Test It
```
User: /daily-report
Claude: *generates structured report*
```

## Hands-On Exercise 2: Client Summary Command

### Create: `.claude/commands/client-summary.md`

```markdown
# /client-summary - Generate client project summary

สรุป status ของ project สำหรับส่งลูกค้า

## Usage
/client-summary [client-name]

## Arguments
- client-name: ชื่อลูกค้าหรือ project

## Implementation

Generate a client-friendly project summary:

### 1. Project Status
Overall status: On Track / At Risk / Delayed

### 2. Progress This Week
- What was completed
- Key milestones reached

### 3. Next Steps
- What's coming next week
- Any decisions needed from client

### 4. Timeline
- Original deadline
- Current projection
- Any changes

### 5. Budget (if applicable)
- Spent vs Budget
- Projected final

### Output Format
```markdown
# Project Update: [Client Name]
## Week of [Date Range]

### Status: [On Track/At Risk/Delayed]

### This Week's Progress
- Completed: [list]
- In progress: [list]

### Next Week
- Planned: [list]
- Decisions needed: [list]

### Timeline
| Milestone | Original | Current |
|-----------|----------|---------|

### Notes
[Any additional context]

---
[Your Company]
[Date]
```

### Tone
- Professional but friendly
- Focus on progress, not problems
- Clear action items
```

## Business Command Ideas

| Command | Purpose | Trigger |
|---------|---------|---------|
| `/standup` | Generate standup update | Daily |
| `/invoice-draft` | Create invoice draft | When billing |
| `/meeting-prep` | Prepare meeting agenda | Before meetings |
| `/follow-up` | Draft follow-up email | After meetings |
| `/eod` | End of day summary | Daily |
| `/weekly` | Weekly report | Friday |
| `/onboard` | New client onboarding | New clients |

## Commands with Arguments

### Syntax
```markdown
## Usage
/command [required-arg] [optional-arg?]

## Arguments
- required-arg: Description (required)
- optional-arg: Description (optional, default: X)
```

### Example: `/email`
```markdown
# /email - Draft an email

## Usage
/email [recipient] [purpose]

## Arguments
- recipient: Who the email is to
- purpose: Brief description of email purpose

## Implementation
Draft a professional email to [recipient] about [purpose].
Ask for any additional details needed.
```

### Usage
```
User: /email "john@client.com" "project delay notification"
Claude: *drafts email with context*
```

## Chaining Commands

### Manual Chain
```
User: /standup
User: /daily-report
User: /email "team@company.com" "daily update"
```

### Workflow Command
Create a command that calls others:

```markdown
# /morning-routine - Start of day workflow

## Implementation

Execute morning routine:

1. Check calendar for today's meetings
2. Review yesterday's pending tasks
3. Generate priorities for today
4. Create standup update

Output a summary of all findings.
```

## Best Practices

### DO
- Use clear, short command names
- Include usage examples
- Define output format explicitly
- Handle missing arguments gracefully

### DON'T
- Don't make commands too complex
- Don't require too many arguments
- Don't overlap with built-in commands
- Don't forget to test

## Exercise: Create Your Command Suite

### Your Task
Create 3 commands for your daily workflow:

1. **Morning command** - Start of day
2. **Midday command** - Status check
3. **Evening command** - Wrap up

### Template
```markdown
# /[command-name] - [description]

[Purpose]

## Usage
/[command-name] [args?]

## Implementation
[What Claude should do]

## Output Format
[Expected structure]
```

## Command Organization

```
.claude/commands/
├── daily/
│   ├── standup.md
│   ├── eod.md
│   └── daily-report.md
├── client/
│   ├── client-summary.md
│   ├── proposal.md
│   └── invoice.md
└── internal/
    ├── meeting-notes.md
    ├── rrr.md
    └── handoff.md
```

## Summary

| Concept | Key Takeaway |
|---------|--------------|
| Command | Slash-triggered prompt expansion |
| Location | `.claude/commands/[name].md` |
| Arguments | `[required]` `[optional?]` |
| Best practice | Clear names, explicit output format |

## Next Module
→ Module 4: MCP - Connect AI to external systems
