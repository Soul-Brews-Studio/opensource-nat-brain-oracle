# Task: MAW-BLOG-002

## Objective
Write blog post: "How to Run 5 AI Agents in Parallel with MAW"

## Output
- File: `ψ/writing/drafts/2025-12-20_maw-parallel-agents-tutorial.md`
- Format: markdown (blog post)

## Inputs (Read these first)
- `ψ/lab/maw-demo/task-template.md` — Task assignment format
- `ψ/memory/learnings/2025-12-17_maw-sync-best-practices.md` — Patterns
- `MAW-AGENTS.md` — Agent definitions

## Instructions

1. **Opening hook**: Start with the problem (sequential work is slow)

2. **Show the solution**:
   - 5 agents working simultaneously
   - 2 minutes vs 2 hours
   - Real results from our trial

3. **Tutorial sections**:
   - Setup: What you need (tmux, worktrees, Claude Code)
   - Pre-flight: Git tags for safety
   - Assign: Using `maw hey` with task templates
   - Monitor: Watching progress with `maw peek`
   - Collect: Syncing results

4. **Include real commands** that readers can copy-paste

5. **End with**: What we learned, what's next

## Requirements
- **Word count**: 1000-1500 words
- **Tone**: Tutorial-style, practical, developer-friendly
- **Audience**: Developers using Claude Code

## Success Criteria
- [ ] Clear problem → solution narrative
- [ ] Step-by-step tutorial with commands
- [ ] Real examples from our workflow
- [ ] Publication-ready (minimal edits)

## When Done
```bash
git add ψ/writing/drafts/2025-12-20_maw-parallel-agents-tutorial.md
git commit -m "blog: MAW parallel agents tutorial"
touch .agent-signals/agent-2.done
```
