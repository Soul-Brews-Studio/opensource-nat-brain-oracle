# Module 2: Skills

> "สร้าง workflow ที่ใช้ซ้ำได้" | 1.5 hours | Intermediate

## Learning Objectives

หลังจบ module นี้ ผู้เรียนจะ:
- เข้าใจ Skill system ของ Claude Code
- สร้าง SKILL.md ได้ถูกต้อง
- ออกแบบ trigger phrases ที่ดี
- มี 3+ business skills พร้อมใช้

## What is a Skill?

**Skill = Reusable AI Workflow**

```
เหมือน SOP (Standard Operating Procedure)
แต่ AI execute ให้อัตโนมัติ
```

### Example
```
User: "review this UI"
Claude: *invokes ux-critic skill*
        *follows the critique framework*
        *outputs structured feedback*
```

## Skill vs Command

| Aspect | Skill | Command |
|--------|-------|---------|
| Location | `~/.claude/skills/` | `.claude/commands/` |
| Scope | Global (all projects) | Per project |
| Trigger | Natural language | Slash `/command` |
| Use case | Workflows, frameworks | Automation, shortcuts |

## SKILL.md Anatomy

```markdown
---
name: skill-name
description: Short description. Trigger phrases here.
---

# Skill Title

Instructions for Claude when skill is invoked.

## When to Use
- Trigger condition 1
- Trigger condition 2

## How to Execute
Step-by-step instructions...

## Output Format
Expected output structure...
```

### Real Example: ux-critic

```markdown
---
name: ux-critic
description: Harsh UX/UI critic for reviewing dashboards.
             Triggers on "review UI", "check UX", "design feedback".
---

# UX Critic Skill

## Critique Framework

### 1. UX Issues
- Navigation clarity
- Information hierarchy
...

### Output Format
# UX Critique: [Feature Name]
## Critical Issues
## Priority Fixes
## Summary
```

## Creating Your First Skill

### Step 1: Create Directory
```bash
mkdir -p ~/.claude/skills/my-skill
```

### Step 2: Create SKILL.md
```bash
touch ~/.claude/skills/my-skill/SKILL.md
```

### Step 3: Write Content
```markdown
---
name: my-skill
description: What it does. Trigger words.
---

# My Skill

[Instructions here]
```

### Step 4: Test
```
User: "[trigger phrase]"
Claude: *should invoke skill*
```

## Hands-On Exercise 1: Email Drafter Skill

### Create the Skill

```bash
mkdir -p ~/.claude/skills/email-drafter
```

### SKILL.md Content

```markdown
---
name: email-drafter
description: Draft professional emails quickly.
             Triggers on "draft email", "write email", "email to".
---

# Email Drafter Skill

Draft professional business emails with appropriate tone.

## When to Use
- Need to write a professional email
- Responding to clients/partners
- Internal communication

## Input Required
- Recipient (who)
- Purpose (why)
- Key points (what)
- Tone (formal/casual/urgent)

## Email Structure

### 1. Subject Line
- Clear, specific, action-oriented
- Max 50 characters

### 2. Opening
- Appropriate greeting
- Context/reference if reply

### 3. Body
- Main point first
- Supporting details
- Clear action items

### 4. Closing
- Next steps
- Appropriate sign-off

## Tone Guidelines

| Tone | Use When | Example |
|------|----------|---------|
| Formal | New clients, executives | "Dear Mr. Smith," |
| Professional | Regular business | "Hi John," |
| Casual | Internal team | "Hey team," |
| Urgent | Time-sensitive | "URGENT: Action needed by EOD" |

## Output Format

```
Subject: [subject line]

[greeting],

[body paragraph 1 - main point]

[body paragraph 2 - details]

[body paragraph 3 - action items]

[closing],
[signature]
```
```

### Test It
```
User: "draft email to client about project delay"
Claude: *invokes email-drafter*
        *asks for details*
        *outputs formatted email*
```

## Hands-On Exercise 2: Report Generator Skill

### SKILL.md

```markdown
---
name: report-generator
description: Generate business reports from data.
             Triggers on "generate report", "create report", "weekly report".
---

# Report Generator Skill

Create structured business reports with executive summary.

## Report Types

| Type | Frequency | Audience |
|------|-----------|----------|
| Daily | Every day | Team |
| Weekly | Monday | Management |
| Monthly | 1st of month | Executives |
| Ad-hoc | On demand | Varies |

## Report Structure

### 1. Executive Summary (3-5 bullets)
- Key metrics
- Notable changes
- Action items

### 2. Metrics Dashboard
| Metric | This Period | Last Period | Change |
|--------|-------------|-------------|--------|

### 3. Highlights
- Wins
- Challenges
- Opportunities

### 4. Action Items
- [ ] Item 1 (Owner, Due)
- [ ] Item 2 (Owner, Due)

### 5. Appendix
- Raw data
- Methodology notes

## Output Format

```markdown
# [Report Type] Report: [Date Range]

## Executive Summary
- Point 1
- Point 2
- Point 3

## Key Metrics
[table]

## Highlights
### Wins
### Challenges

## Action Items
[checklist]

---
Generated: [timestamp]
```
```

## Business Skill Ideas

| Skill | Trigger | Output |
|-------|---------|--------|
| `meeting-notes` | "summarize meeting" | Structured notes + action items |
| `proposal-writer` | "write proposal" | Business proposal draft |
| `competitor-brief` | "competitor analysis" | Competitive intel summary |
| `onboarding-guide` | "onboard new [role]" | Role-specific checklist |
| `client-update` | "client status update" | Status report for client |

## Trigger Phrase Best Practices

### Good Triggers
```
- Specific: "review UI design"
- Natural: "check this dashboard"
- Action-oriented: "critique the UX"
```

### Bad Triggers
```
- Too generic: "help" (conflicts with everything)
- Too long: "please review the user interface design"
- Uncommon: "perform UX audit" (no one says this)
```

### Multiple Triggers
```yaml
description: ... Triggers on "review UI", "check UX",
             "design feedback", "critique design".
```

## Exercise: Create Your Business Skill

### Template

```markdown
---
name: [your-skill-name]
description: [what it does]. Triggers on "[phrase1]", "[phrase2]".
---

# [Skill Title]

[What this skill does and why]

## When to Use
- [Condition 1]
- [Condition 2]

## Process
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Output Format
[Template for output]
```

### Your Task
1. Think of a repetitive task in your business
2. Create a skill for it
3. Test with trigger phrases
4. Refine based on results

## Summary

| Concept | Key Takeaway |
|---------|--------------|
| Skill | Reusable AI workflow |
| Location | `~/.claude/skills/[name]/SKILL.md` |
| Trigger | Natural language phrases |
| Best practice | Specific triggers, clear output format |

## Next Module
→ Module 3: Commands - Automate with slash commands
