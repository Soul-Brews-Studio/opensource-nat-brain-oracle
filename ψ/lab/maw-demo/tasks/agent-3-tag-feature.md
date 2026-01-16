# Task: MAW-FEATURE-003

## Objective
Design and document git tag checkpoint feature for MAW rollback safety

## Output
- File: `ψ/memory/learnings/2025-12-20_maw-tag-checkpoint-pattern.md`
- Format: markdown (learning document)

## Inputs (Read these first)
- `ψ/lab/maw-demo/task-template.md` — Pre-flight protocol
- `ψ/memory/learnings/2025-12-17_maw-git-worktree-patterns.md` — Git patterns
- `.agents/scripts/smart-sync.sh` — Current sync implementation

## Instructions

1. **Document the problem**:
   - What happens when agent work goes wrong?
   - Why branches alone aren't enough for rollback

2. **Design the solution**:
   - Tag naming convention: `maw/checkpoint/YYYYMMDD-HHMM`
   - Per-agent tags vs session tags
   - When to create tags (pre-flight)

3. **Write implementation guide**:
   ```bash
   # Before work
   git tag -a "maw/checkpoint/$(date +%Y%m%d-%H%M)" -m "Pre-work checkpoint"

   # Rollback
   git checkout "maw/checkpoint/20251220-1112"
   ```

4. **Consider integration with MAW scripts**:
   - Should `maw sync` auto-create tags?
   - New command: `maw checkpoint`?

5. **Add to pre-flight checklist**

## Success Criteria
- [ ] Problem clearly explained
- [ ] Tag naming convention defined
- [ ] Implementation commands documented
- [ ] Integration options described
- [ ] Ready to implement

## When Done
```bash
git add ψ/memory/learnings/2025-12-20_maw-tag-checkpoint-pattern.md
git commit -m "feature: MAW git tag checkpoint pattern design"
touch .agent-signals/agent-3.done
```
