# Lesson Learned: /plan → /gogogo GitHub Flow Pattern

**Date**: 2025-12-17
**Session**: Planning workflow safety + GitHub flow enforcement
**Key Insight**: Design patterns that make unsafe actions impossible, not just discouraged

---

## Problem Statement

**Before**: Ad-hoc cleanup and destructive operations led to:
- Using `rm -rf` without safety nets
- Pushing directly to main without review
- Forgetting to create branches or PRs
- No audit trail for destructive actions

**Core Issue**: Safety relied on remembering rules, not enforcement.

---

## Solution: /plan → /gogogo Pattern

### Pattern Overview

```
/plan [description]
  ↓ analyzes impact
  ↓ creates GitHub issue with detailed plan
  ↓ user reviews & approves

/gogogo
  ↓ finds most recent plan issue
  ↓ creates feature branch (MANDATORY)
  ↓ executes steps sequentially
  ↓ commits on branch
  ↓ creates PR (MANDATORY)
  ↓ user reviews & merges
```

### Key Design Decisions

#### 1. Like `nnn` Pattern, Not Fixed
- `/plan` takes context from discussion, not just arguments
- Captures ALL conversation context into comprehensive plan
- Not prescriptive - flexible like `nnn`

**Example**:
```
User + Claude discuss fb-explorer graduation
User discusses ghq workflow vs manual clone
User decides on approach
User: "/plan cleanup-untracked"
→ Plan includes EVERYTHING discussed, not just "cleanup-untracked"
```

#### 2. GitHub Issue as Contract
- Plan must be written as GitHub issue
- Creates audit trail
- Allows async review
- Links to PR when executed

**Why**: Verbal approval gets lost, written issue persists.

#### 3. Enforced GitHub Flow in /gogogo
- Branch creation is MANDATORY (can't skip)
- PR creation is MANDATORY (replaces push to main)
- User must explicitly merge (can't forget review)

**Why**: If it's optional, it will be forgotten under time pressure.

#### 4. Link at Bottom, Not Top
- Summary and stats first
- GitHub link last (for reference)

**Why**: Better reading flow - what matters first, link for later.

---

## Oracle Philosophy Integration

### "Nothing is Deleted" Implementation

**Old way**:
```bash
rm -rf cellar/  # Gone forever
```

**Oracle way**:
```bash
mv cellar /tmp/cellar-$(date +%Y%m%d-%H%M%S)  # Recoverable until reboot
```

**Benefits**:
1. Safety window until next reboot
2. Easy recovery if mistake: `mv /tmp/cellar-* ./`
3. Automatic cleanup by OS
4. Audit trail in /tmp
5. Honors "Nothing is Deleted" principle

**Pattern**: Prefer `mv` over `rm` for all destructive operations.

---

## Implementation Patterns

### /plan Command Structure

1. **Action section** (what happens when run)
2. **Workflow details** (how it works)
3. **Template** (GitHub issue format)
4. **Safety rules** (what never to do)
5. **Examples** (real-world usage)

### /gogogo Command Structure

1. **Find plan** (search for open plan: issues)
2. **Create branch** (enforce naming: cleanup/issue-XXX, feat/issue-XXX)
3. **Execute steps** (sequential, stop on error)
4. **Create PR** (enforce linking: Closes #XXX)
5. **Output summary** (what happened, next steps)

---

## Graduation Pattern Validated

### Pattern: ψ/lab → Own Repo → ψ/incubate

```
1. Small experiment in ψ/lab/
2. When substantial: create own repo
3. Push code
4. Clone via ghq (not manual git clone)
5. Symlink to ψ/incubate/repo/github.com/[org]/[repo]
6. Register slug in slugs.yaml
7. Delete original (or mv to /tmp/)
8. Create PR (not push to main)
```

**Validated twice**: fb-explorer + cellar
**Space saved**: 331MB + 1.7GB = ~2GB

**Why ghq**: Consistent directory structure, proper remote tracking.

---

## Anti-Patterns Identified

### ❌ Anti-Pattern 1: Direct Main Pushes
**Problem**: No review, no rollback, accidents happen
**Solution**: /gogogo enforces branch + PR

### ❌ Anti-Pattern 2: "I'll remember to..."
**Problem**: Memory fails under pressure
**Solution**: Make it automatic, not optional

### ❌ Anti-Pattern 3: rm -rf Without Recovery
**Problem**: Permanent deletion, no undo
**Solution**: mv to /tmp with timestamp

### ❌ Anti-Pattern 4: Verbal Approval Only
**Problem**: No audit trail, forgotten decisions
**Solution**: GitHub issue as written contract

### ❌ Anti-Pattern 5: Fixed Command Behavior
**Problem**: /plan only does one thing
**Solution**: Context-aware like nnn (uses discussion)

---

## Lessons for Future Commands

### 1. Enforce, Don't Request
If safety is critical, make it impossible to skip:
- Branch creation in /gogogo
- PR creation in /gogogo
- Issue creation in /plan

### 2. Context Over Arguments
Take full conversation context, not just command args:
- nnn uses recent context
- /plan should do the same

### 3. Write It Down
Verbal agreements disappear:
- GitHub issues persist
- PRs create audit trail
- Comments capture decisions

### 4. Recovery Over Deletion
Honor Oracle philosophy:
- mv to /tmp, not rm
- Append, don't overwrite
- Timestamp everything

### 5. User Experience Flow
Reading order matters:
- Summary first (what happened)
- Details second (how it happened)
- Links last (reference)

---

## Metrics

**Commands Created**: 2 (/plan, /gogogo)
**Repos Graduated**: 2 (fb-explorer, cellar)
**Space Freed**: ~2GB
**Commits**: 5 (all following new pattern)
**PRs Created**: 1 (cellar graduation)
**Pattern Violations**: 0 (enforcement works!)

---

## Next Steps

### Immediate
- [ ] Update CLAUDE_safety.md with mv-to-tmp rule
- [ ] Update /plan to use mv instead of rm
- [ ] Update /gogogo to enforce mv pattern

### Future
- [ ] Consider /undo command (recover from /tmp)
- [ ] Add /trace integration with /plan
- [ ] Consider plan templates for common operations

---

## Key Quote

> "Design patterns that make unsafe actions impossible, not just discouraged."

When safety is optional, it gets skipped. When it's enforced, it becomes habit.

---

## Related Documents

- `CLAUDE_safety.md` - Safety rules
- `CLAUDE_workflows.md` - Short codes (nnn, gogogo)
- `.claude/commands/plan.md` - Plan command
- `.claude/commands/gogogo.md` - Execute command
- `plugins/nat-data-personal/knowledge/oracle-philosophy.md` - Oracle principles

---

**Tags**: #workflow #safety #github-flow #oracle-philosophy #enforcement #destructive-operations
