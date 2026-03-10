# Session Retrospective: Self-Hosted Runner Setup

**Date**: 2026-01-02 00:52
**Duration**: ~15 minutes (00:42 - 00:52)
**Theme**: GitHub Actions Infrastructure

---

## AI Diary

เซสชันสั้นๆ แต่ได้งานสำคัญ — เปลี่ยน self-hosted runner จาก floodboy เป็น nat user

เริ่มจาก pickup handoff จาก session ก่อน ที่ deploy RAG สำเร็จแล้ว แต่ workflow ยังใช้ `runs-on: [self-hosted]` ซึ่งชี้ไป runner ของ floodboy ที่ path ไม่ตรง

User ถาม "can we use self-hosted runner to deploy rag?" — คำตอบคือได้ แต่ต้อง setup runner ใหม่เป็น nat user ก่อน

Token ที่ user ให้มา = fresh token สำหรับ configure runner ใหม่ ไม่ใช่ token เก่า ผมเข้าใจถูก

ความรู้สึก: Quick win. Infrastructure ที่ solid = peace of mind.

---

## Session Timeline

| Time | Duration | Work |
|------|----------|------|
| 00:42 | 3m | Handoff pickup, check workflow failure |
| 00:45 | 2m | Merge PR #83 (docs cleanup) |
| 00:47 | 3m | Download + configure new runner as nat |
| 00:50 | 2m | Update workflows to nat_white_local |
| 00:51 | 1m | Test deployment, verify success |

---

## Commits This Session

```
01a9499 fix: Update workflows to use nat_white_local runner
5fd6dfb feat: Add GitHub Actions workflow for RAG deployment
```

---

## What We Built

### Self-Hosted Runner (nat_white_local)

| Attribute | Before | After |
|-----------|--------|-------|
| Runner name | nazt-cat-agent.white | nat_white_local |
| User | floodboy | nat |
| Label | self-hosted | nat_white_local |
| Path access | /home/floodboy/... | /home/nat/... |

### Deploy RAG Workflow

```yaml
runs-on: [nat_white_local]

# Actions:
- restart  # Pull code, install deps, restart PM2
- stop     # Stop services
- status   # Show PM2 status
- reindex  # Reindex documents
```

### Auto-Deploy Trigger

Push to `ψ/lab/data-aware-rag/**` → automatic deployment

---

## Key Know-How

### 1. Runner User Matters

Runner executes as the user who installed it. `floodboy` can't access `/home/nat/...` paths.

**Fix**: Install runner as the correct user:
```bash
ssh nat@white.local
cd ~/actions-runner
./config.sh --name nat_white_local --labels nat_white_local
sudo ./svc.sh install nat  # <-- runs as nat
```

### 2. Runner Service Commands

```bash
sudo ./svc.sh install nat   # Install as nat user
sudo ./svc.sh start         # Start service
sudo ./svc.sh stop          # Stop service
sudo ./svc.sh status        # Check status
sudo ./svc.sh uninstall     # Remove service
```

### 3. Force Remove Old Config

When reconfiguring runner:
```bash
rm -rf .runner .credentials .credentials_rsaparams
./config.sh --url ... --token ... --unattended
```

### 4. Workflow Environment Variables

Use `env:` at job level for shared paths:
```yaml
env:
  RAG_DIR: /home/nat/Code/.../ψ/lab/data-aware-rag

steps:
  - run: cd $RAG_DIR && pm2 start ecosystem.config.cjs
```

---

## Links

| Resource | URL |
|----------|-----|
| Deploy RAG Workflow | https://github.com/laris-co/Nat-s-Agents/actions/workflows/deploy-rag.yml |
| Runners Settings | https://github.com/organizations/laris-co/settings/actions/runners |
| RAG Frontend | http://white.local:5173 |
| RAG Backend | http://white.local:8001 |

---

## What Worked

1. **Quick pivot** - Identified runner user issue fast
2. **Token fresh** - User gave new token, worked first try
3. **Parallel workflow runs** - Both push and dispatch succeeded

## What to Improve

1. **Document runner setup** - Add to CLAUDE.md or learnings
2. **Consider backup runner** - floodboy as fallback?
3. **Workflow secrets** - Currently hardcoded paths, could use secrets

---

## Patterns Learned

### 1. Self-Hosted Runner Setup Pattern

```
1. SSH as target user
2. Download runner tarball
3. Configure with --unattended
4. Install service with: sudo ./svc.sh install $USER
5. Start: sudo ./svc.sh start
6. Update workflow: runs-on: [label]
```

### 2. Workflow Debugging Pattern

When workflow fails with "Permission denied":
- Check runner user (which user runs the service?)
- Check path access (can that user access the path?)
- Check nvm/bun in PATH (source ~/.nvm/nvm.sh)

---

## Metrics

| Metric | Value |
|--------|-------|
| Commits | 2 |
| PR merged | 1 (#83) |
| Workflows created | 1 (deploy-rag.yml) |
| Workflows fixed | 2 |
| Runner reconfigured | 1 |

---

## Honest Feedback

**Strength**: Fast infrastructure work. 15 minutes from broken to working.

**Area to Watch**: Session at 00:52 after midnight. Good energy but don't push too late.

**Mood**: Satisfied. Small session, big impact.

---

*Day 2 of 2026 - Infrastructure solidifying*
