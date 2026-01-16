# How to Run 5 AI Agents in Parallel with MAW

You're working on a feature. There are 5 independent tasks: write docs, create tests, implement the API, design the schema, and draft the blog post. Each takes 20-30 minutes.

**Sequential**: 2+ hours.
**Parallel with MAW**: 30 minutes.

That's not a typo. We've been running 5 Claude Code agents simultaneously on the same repository, each in their own Git worktree. Here's exactly how we do it.

## The Problem: AI Agents Work Sequentially

Claude Code is powerful, but it has an obvious limitation: one agent, one task at a time. When you have a batch of independent work—documentation across multiple features, tests for different modules, or parallel research tasks—you're stuck waiting.

The traditional workaround is to clone the repo multiple times. But then you're juggling separate directories, manually merging work, and praying you don't have conflicts.

We built something better.

## The Solution: Multi-Agent Worktrees (MAW)

MAW uses Git worktrees to give each agent its own working directory and branch, all pointing to the same repository. Changes stay synchronized through rebases, not merges. Every agent can see everyone else's work.

Here's what it looks like in practice:

```
.
├── agents/
│   ├── 1/      # Agent 1's worktree (branch: agents/1)
│   ├── 2/      # Agent 2's worktree (branch: agents/2)
│   ├── 3/      # Agent 3's worktree (branch: agents/3)
│   ├── 4/      # Agent 4's worktree (branch: agents/4)
│   └── 5/      # Agent 5's worktree (branch: agents/5)
└── (main repo on main branch)
```

Five agents. Five branches. One repo. Zero conflicts (when done right).

## What You Need

- **Git** (with worktree support—any modern version)
- **tmux** (for managing multiple terminal panes)
- **Claude Code** (or any CLI-based AI assistant)

## Step 1: Create the Worktree Structure

First, set up the worktrees. From your repo root:

```bash
# Create agent branches and worktrees
for i in 1 2 3 4 5; do
  git branch "agents/$i" main
  git worktree add "agents/$i" "agents/$i"
done
```

Each agent now has a dedicated directory with full access to the codebase.

## Step 2: Pre-Flight Safety (Critical)

Before assigning parallel work, create a checkpoint. This is your safety net.

```bash
# Create a tagged checkpoint
git tag -a "maw/pre-work/$(date +%Y%m%d-%H%M)" -m "Before parallel work"

# Sync all agents to the same commit
maw sync  # or manually: git -C agents/N rebase main

# Create signal directory for completion tracking
mkdir -p .agent-signals
rm -f .agent-signals/*.done
```

The tag lets you roll back if anything goes wrong. We've needed it exactly once—and were very glad it was there.

## Step 3: Assign Tasks with `maw hey`

Now the fun part. Send tasks to your agents:

```bash
# Inline task (short)
maw hey 1 "Write unit tests for the auth module. Output to tests/auth.test.ts"

# From a file (complex tasks with context)
maw hey 2 "$(cat tasks/agent-2-task.md)"

# Broadcast to all (rare, but useful)
maw hey all "git pull --rebase origin main"
```

Each `maw hey` command sends input directly to the tmux pane where that agent is running. The agent receives the task as if you typed it.

### Task Template Pattern

For complex work, we use structured task templates:

```markdown
# Task: AUTH-001

## Objective
Implement JWT refresh token logic

## Output
- File: `src/auth/refresh.ts`

## Instructions
1. Read src/auth/token.ts for context
2. Implement refresh flow with 7-day expiry
3. Add error handling for expired tokens

## When Done
git add src/auth/refresh.ts && git commit -m "feat: JWT refresh tokens"
touch .agent-signals/agent-1.done
```

The `.done` file is how agents signal completion. More on that next.

## Step 4: Monitor Progress with `maw peek`

While agents work, you can watch their progress:

```bash
# Table view of all agents
maw peek
```

Output:

```
Agent  │ Status   │ Task                           │ Commit
───────┼──────────┼────────────────────────────────┼────────
Main   │ ✓        │ orchestrating parallel work    │ a1b2c3d
1      │ 2 mod    │ writing auth tests             │ a1b2c3d
2      │ ✓        │ schema design complete         │ e4f5g6h
3      │ 5 new    │ API implementation             │ a1b2c3d
4      │ ✓        │ -                              │ a1b2c3d
5      │ 1 mod    │ drafting blog post             │ a1b2c3d
```

The status column shows:
- `✓` = clean (no uncommitted changes)
- `N mod` = N modified files
- `N new` = N new files

For detailed view of a specific agent:

```bash
maw peek 3

═══ Agent 3 ═══
Modified:
 M src/api/endpoints.ts
 M src/api/handlers.ts
?? src/api/validators.ts
  ... and 2 more

Focus:
  STATE: working
  TASK: API implementation
  SINCE: 14:32

Last commit:
  a1b2c3d feat: base API structure (5 minutes ago)
```

### Watching for Completion

```bash
# Wait for all agents to signal done
watch -n 5 'ls .agent-signals/*.done 2>/dev/null | wc -l'
```

When all 5 `.done` files appear, you're ready to collect.

## Step 5: Collect and Sync Results

Once all agents have committed and signaled:

```bash
# Sync all work to main (in order)
for i in 1 2 3 4 5; do
  git rebase "agents/$i"
done

# Or use the script
maw sync

# Push to remote
git push origin main

# Clean up signals
rm -rf .agent-signals/
```

The key insight: **rebase, not merge**. Rebasing keeps commit hashes consistent across all worktrees. Merging creates unique merge commits that diverge.

## Key Principles That Make This Work

### 1. Use `git -C`, Not `cd`

```bash
# Good: respects worktree boundaries
git -C agents/1 status

# Bad: pollutes shell state
cd agents/1 && git status
```

Any agent can control any other worktree using `git -C`. No need to change directories.

### 2. Rebase for Same Hash

```bash
# Rebase = all worktrees share same commit hashes
git rebase agents/1

# Merge = creates unique merge commit, causes divergence
git merge agents/1  # Don't do this
```

### 3. Never Force Push

```bash
# If push is rejected
git pull --rebase origin main
git push

# Never this
git push --force  # Destroys history
```

### 4. Always Peek Before Sync

```bash
maw peek  # Check for uncommitted work first
maw sync  # Only syncs clean worktrees
```

## What We Learned

After running parallel agents for a week:

**Speed gains are real.** Five independent tasks that took 2 hours sequentially completed in 35 minutes. The overhead of setup and coordination is minimal once you have the workflow down.

**Task boundaries matter.** Agents working on the same files will conflict. Plan task assignments to minimize overlap. When in doubt, assign by directory or module.

**Completion signals are essential.** Without explicit signals, you're constantly running `maw peek` to check status. With signals, you can fire-and-forget.

**Tags save lives.** That one time an agent went off the rails and modified 47 files? Rolled back to the pre-work tag in 10 seconds.

## What's Next

This workflow is manual—you're still the orchestrator. The next evolution is fully autonomous: agents that claim tasks from a queue, self-coordinate, and handle their own syncing.

We're building that now. But honestly, the manual version already feels like a superpower.

---

*Try it yourself: set up 3 agents, give them independent tasks, and watch them work. The first time you collect results from parallel work that would have taken an hour sequentially—completed in 15 minutes—you'll understand why we built this.*

---

**Commands Reference**

| Command | Purpose |
|---------|---------|
| `maw hey 1 "task"` | Send task to agent 1 |
| `maw hey all "cmd"` | Broadcast to all agents |
| `maw peek` | Table view of all agents |
| `maw peek 3` | Detailed view of agent 3 |
| `maw sync` | Rebase all clean agents to main |

**Repository**: [github.com/laris-co/Nat-s-Agents](https://github.com/laris-co/Nat-s-Agents)
