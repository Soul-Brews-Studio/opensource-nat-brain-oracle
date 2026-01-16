# POC Fix Plan

> **Status**: Planning
> **Created**: 2025-12-11
> **Goal**: Fix API mismatches before running experiments

---

## Current State

```
poc/
├── experiments/
│   ├── 01-basic-query.ts     # 30/40 - minor fixes
│   ├── 02-v2-session.ts      # 22/40 - major rewrite
│   └── 03-tools-sandbox.ts   # 26/40 - moderate fixes
├── results/
│   └── judge-report.md       # Complete
├── PLAN.md                   # This file
└── README.md                 # Updated
```

---

## Phase 1: Verify Actual SDK API

**Goal**: Understand real SDK signatures before fixing

### Tasks

1. [ ] Read SDK source types from cloned repo
   ```
   repo/src/index.ts (if exists)
   repo/types/*.d.ts
   ```

2. [ ] Check official examples
   ```
   https://github.com/anthropics/claude-agent-sdk-demos
   ```

3. [ ] Document correct signatures
   - `query()` - actual parameters
   - `unstable_v2_prompt()` - actual parameters
   - `unstable_v2_createSession()` - actual parameters

### Expected Output
- `docs/correct-api-signatures.md`

---

## Phase 2: Fix Experiments

**Goal**: Update code to match actual SDK API

### 01-basic-query.ts (Priority: Low)
- [ ] Verify `query()` options structure
- [ ] Fix property access safety
- [ ] Test runs successfully

### 02-v2-session.ts (Priority: High)
- [ ] Remove fake `client` parameter
- [ ] Fix `unstable_v2_prompt()` signature
- [ ] Fix `unstable_v2_createSession()` signature
- [ ] Remove `createMockClient()`
- [ ] Test runs successfully

### 03-tools-sandbox.ts (Priority: Medium)
- [ ] Change `messages` to `prompt`
- [ ] Verify `tools` array format
- [ ] Fix response parsing
- [ ] Test runs successfully

---

## Phase 3: Run & Validate

**Goal**: Execute experiments and capture results

### Tasks

1. [ ] Run each experiment individually
   ```bash
   npm run exp:basic
   npm run exp:v2
   npm run exp:tools
   ```

2. [ ] Capture output to results/
   ```
   results/01-basic-output.txt
   results/02-v2-output.txt
   results/03-tools-output.txt
   ```

3. [ ] Update judge report with run results

---

## Phase 4: Graduate from POC

**Criteria for Success**:
- [ ] All 3 experiments run without errors
- [ ] Each demonstrates its target feature
- [ ] Results documented

**Then**:
```bash
# Move to production
mv poc/ lab/
# Update parent INDEX.md
```

---

## Dependencies

| Item | Status | Notes |
|------|--------|-------|
| Node.js 22.x | ✅ Ready | |
| SDK v0.1.61 | ✅ Installed | |
| API Key | ❓ Unknown | Need ANTHROPIC_API_KEY |
| Cloned repo | ✅ Ready | For reference |

---

## Questions to Resolve

1. **API Key**: Do we have `ANTHROPIC_API_KEY` set?
2. **Model Access**: Which models are available?
3. **Rate Limits**: Any concerns for testing?

---

## Parallel Execution Strategy

When ready to fix (Phase 2):

```
Agent A → Fix 01-basic-query.ts
Agent B → Fix 02-v2-session.ts
Agent C → Fix 03-tools-sandbox.ts
Judge   → Validate all fixes
```

---

## Timeline

| Phase | Effort | Dependency |
|-------|--------|------------|
| Phase 1 | 30 min | None |
| Phase 2 | 45 min | Phase 1 |
| Phase 3 | 15 min | Phase 2 + API Key |
| Phase 4 | 5 min | Phase 3 success |

**Total**: ~1.5 hours when ready

---

*Plan created: 2025-12-11*
