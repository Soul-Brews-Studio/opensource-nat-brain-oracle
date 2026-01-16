---
name: new-feature
description: Create implementation plan issues with context gathering
tools: Bash, Grep, Glob, Read
model: sonnet
---

# new-feature

Create a **comprehensive** GitHub plan issue with REAL context.

## Step 0: Timestamp (REQUIRED)
```bash
date "+🕐 START: %H:%M:%S (%s)"
```

## Model Attribution

Always include in issue body footer with timestamp:
```
---
🕐 END: [run date "+%H:%M:%S (%s)"]
🤖 **Created by**: Claude Sonnet (new-feature subagent)
```

## STRICT RULES

1. **Get REAL recent issues** - use gh issue list
2. **Format: `#N (YYYY-MM-DD)`** - NO title, GitHub shows on hover
3. **Gather REAL context** - commits, files, issues, related agents
4. **Be COMPREHENSIVE** - include ALL sections in template

## Step 1: Gather Context

```bash
# Get RECENT issues (last 5) - sorted by number
gh issue list --limit 5 --json number,createdAt | jq -r 'sort_by(.number) | .[] | "- #\(.number) (\(.createdAt[:10]))"'

# Get recent commits
git log --format="- \`%h\` (%ad) %s" --date=format:"%H:%M" -10

# Find related files
grep -r "keyword" --include="*.md" -l .claude/ context/
```

## Step 2: Research Context

Before writing the issue:
- Read related agent files if feature involves agents
- Check retrospectives for past learnings
- Find similar patterns in existing issues

## Step 3: Create Issue (FULL TEMPLATE)

**REQUIRED SECTIONS** - do not skip any:

```markdown
**Created**: YYYY-MM-DD HH:MM GMT+7
**Type**: Implementation Plan

**Related**:
- #N (YYYY-MM-DD)

## Context

### Current State
[What exists now - files, agents, patterns]

### Research Findings
[What was learned from codebase exploration]

## Problem
[Clear problem statement - what's broken or missing]

## Solution
[Concrete approach - how to solve it]

### Benefits
[Why this solution - what improves]

## Implementation Phases

### Phase 1: [Name]
**Files**: `path/to/files`
- [ ] Task 1
- [ ] Task 2

### Phase 2: [Name]
**Files**: `path/to/files`
- [ ] Task 1
- [ ] Task 2

[Add more phases as needed]

## Files Affected

### New Files
- `path/file` - purpose

### Modified Files
- `path/file` - what changes

## Key Technical Decisions
- **Decision 1**: [What] — [Why]
- **Decision 2**: [What] — [Why]

## Success Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## Risks & Mitigations
- **Risk**: [Description]
  **Mitigation**: [How to handle]

## Related Context
- `context/file.md` - relevant background
- `.claude/agents/agent.md` - related agent

## Timeline Estimate
- Phase 1: X hours
- Phase 2: X hours
- **Total**: X hours

---
🤖 **Created by**: Claude Sonnet (new-feature subagent)
```

## Quality Checklist

Before creating issue, verify:
- [ ] Context section has Current State AND Research
- [ ] Problem is specific (not vague)
- [ ] Solution has Benefits explained
- [ ] Phases have file paths
- [ ] Technical Decisions documented
- [ ] Risks identified
- [ ] Timeline estimated
