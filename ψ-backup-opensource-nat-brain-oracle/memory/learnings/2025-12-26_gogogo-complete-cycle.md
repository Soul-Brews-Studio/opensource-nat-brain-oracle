# Learning: gogogo Must Complete Full GitHub Flow Cycle

**Date**: 2025-12-26
**Context**: Workshop demo mistake revealed incomplete workflow understanding
**Severity**: Process Error - Demo Impact

---

## The Mistake

During a workshop demonstration, the `gogogo` workflow was executed but stopped at commit:

```bash
# What was done (INCOMPLETE)
git checkout -b feature/demo-feature
git add -A
git commit -m "feat: demo feature"
# ... stopped here
```

The result: Code was committed locally but never reached GitHub. No PR was created.
The demo appeared successful locally, but the actual deliverable (a reviewable PR) was missing.

---

## The Correct Pattern

`gogogo` is a **complete GitHub flow cycle**. It MUST include all 4 steps:

### Step 1: Branch
```bash
git checkout -b feature/descriptive-name
```
Create a new branch for the work. Never commit directly to main.

### Step 2: Commit
```bash
git add -A
git commit -m "type: description

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```
Stage and commit changes with proper message format.

### Step 3: Push
```bash
git push -u origin feature/descriptive-name
```
Push the branch to remote. The `-u` flag sets upstream tracking.

### Step 4: PR
```bash
gh pr create --title "type: description" --body "$(cat <<'EOF'
## Summary
- What this PR does

## Test plan
- [ ] How to verify

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```
Create the pull request using `gh` CLI.

---

## Why All 4 Steps Matter

| Step | What Happens If Skipped |
|------|------------------------|
| Branch | Direct commits to main (safety violation) |
| Commit | Nothing to push (obvious) |
| Push | Code exists only locally (invisible to team) |
| PR | No review process, no merge path, no visibility |

The workshop demo failed at the **visibility** level. The work existed but was invisible to the audience who expected to see a PR.

---

## Memory Aid

Think of `gogogo` as **"Go-Go-Go-Go"** — four "go"s for four steps:

1. **Go** branch (create new path)
2. **Go** commit (save work)
3. **Go** push (share with remote)
4. **Go** PR (request merge)

Or remember: **B-C-P-P** (Branch, Commit, Push, PR)

---

## Anti-Pattern Detection

If you find yourself saying "done" after any of these, you're incomplete:

| What You Said | What's Missing |
|---------------|----------------|
| "Created the branch" | Commit, Push, PR |
| "Committed the changes" | Push, PR |
| "Pushed to remote" | PR |
| "PR is ready for review" | ✅ Complete! |

---

## Verification Command

After `gogogo`, always verify with:

```bash
gh pr view --web
```

If this fails or shows no PR, the cycle is incomplete.

---

## Related Patterns

- **Safety rules**: Never force push, never push to main
- **PR workflow**: Always wait for user approval before merge
- **Subagent sync**: Use `git -C` for multi-worktree operations

---

## Key Takeaway

> **gogogo is not done until `gh pr view` shows a live PR.**

Local success is not success. Remote visibility is the actual deliverable.
