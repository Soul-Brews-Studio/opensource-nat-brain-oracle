# CLAUDE_safety.md - Critical Safety Rules

> **Navigation**: [Main](CLAUDE.md) | **Safety** | [Workflows](CLAUDE_workflows.md) | [Subagents](CLAUDE_subagents.md) | [Lessons](CLAUDE_lessons.md) | [Templates](CLAUDE_templates.md)

## Repository Usage
-   **NEVER create issues/PRs on upstream**

## Command Usage
-   **NEVER use `-f` or `--force` flags with any commands.**
-   Always use safe, non-destructive command options.
-   If a command requires confirmation, handle it appropriately without forcing.

## Git Operations
-   Never use `git push --force` or `git push -f`.
-   Never use `git checkout -f`.
-   Never use `git clean -f`.
-   Always use safe git operations that preserve history.
-   **NEVER PUSH DIRECTLY TO MAIN** - Always create a feature branch and PR
-   **NEVER MERGE PULL REQUESTS WITHOUT EXPLICIT USER PERMISSION**
-   **Never use `gh pr merge` unless explicitly instructed by the user**
-   **Always wait for user review and approval before any merge**

## PR Workflow (Required)
1. Create feature branch: `git checkout -b feat/description`
2. Make changes and commit
3. Push branch: `git push -u origin feat/description`
4. Create PR: `gh pr create`
5. **WAIT** for user to review and approve
6. User merges when ready

## Multi-Agent Worktree Safety

### ⚠️ CRITICAL: History-Rewriting Commands are FORBIDDEN

In multi-agent setup, these commands break ALL agents:

| FORBIDDEN Command | Why It Breaks Everything |
|-------------------|-------------------------|
| `git commit --amend` | Changes commit hash → agents have old hash → divergence |
| `git rebase -i` | Rewrites history → all synced agents become orphaned |
| `git reset --soft/mixed` + recommit | Same as amend - creates new hash |

**What happens when you amend:**
1. Main has commit `abc123`
2. Agents sync → they all have `abc123`
3. You amend → Main now has `def456`
4. Agents still have `abc123` (different hash, same content)
5. `git rebase` says "already up to date" (content matches)
6. But hashes are forever diverged → future merges get confused

**The Rule: ALWAYS create NEW commits, NEVER rewrite history**

```bash
# ❌ WRONG - breaks all agents
git commit --amend -m "fix typo"

# ✅ CORRECT - safe for multi-agent
git commit -m "fix: correct typo in previous commit"
```

### General Worktree Rules
-   **NEVER use `git reset --hard` on agent worktrees**
-   Each agent may have uncommitted work - respect their state
-   To sync agents, use `maw sync` (handles everything safely)
-   Always check `git status` before any sync operation
-   Ask user before any destructive worktree operation

## File Operations
-   Never use `rm -rf` - use `rm -i` for interactive confirmation.
-   Always confirm before deleting files.
-   Use safe file operations that can be reversed.

## Temp File Operations
-   **NEVER create temp files outside the repository** (e.g., `/tmp/`)
-   **ALWAYS use `.tmp/` directory inside repo** (gitignored)
-   Signal files, locks, caches -> `.tmp/filename`
-   Clean up temp files after use: `rm -f .tmp/filename`

## Package Manager Operations
-   Never use `[package-manager] install --force`.
-   Never use `[package-manager] update` without specifying packages.
-   Always review lockfile changes before committing.

## General Safety Guidelines
-   Prioritize safety and reversibility in all operations.
-   Ask for confirmation when performing potentially destructive actions.
-   Explain the implications of commands before executing them.
-   Use verbose options to show what commands are doing.

---

**See also**: [CLAUDE.md](CLAUDE.md) for quick reference, [CLAUDE_workflows.md](CLAUDE_workflows.md) for development workflows
