# Task: MAW-INSTRUCTION-001

## Objective
Write MAW instruction report: complete guide to `maw hey` parallel workflow

## Output
- File: `ψ/memory/learnings/2025-12-20_maw-hey-instruction.md`
- Format: markdown (learning document)

## Inputs (Read these first)
- `MAW-COMPLETE-SYSTEM.md` — Full MAW system overview
- `.agents/scripts/hey.sh` — How `maw hey` sends commands
- `.agents/maw.env.sh` — Shell functions
- `ψ/memory/learnings/2025-12-17_maw-sync-best-practices.md` — Sync patterns

## Instructions

1. **Read all input files** to understand the system

2. **Document the complete workflow**:
   - Pre-flight: Git tag checkpoint + maw sync
   - Start: maw start [profile]
   - Assign: maw hey [agent] "[task]"
   - Monitor: maw peek
   - Sync: maw sync
   - Rollback: git checkout [tag]

3. **Include command examples** with expected output for each step

4. **Add troubleshooting section**:
   - Agent not responding
   - Sync conflicts
   - Rollback procedure

5. **Document the task template format** (reference task-template.md)

## Success Criteria
- [ ] Complete workflow from start to finish
- [ ] All commands have copy-paste examples
- [ ] Git tag checkpoint pattern documented
- [ ] Troubleshooting covers common issues
- [ ] A developer can follow this to run MAW

## When Done
```bash
git add ψ/memory/learnings/2025-12-20_maw-hey-instruction.md
git commit -m "docs: MAW hey workflow instruction guide"
touch .agent-signals/agent-1.done
```
