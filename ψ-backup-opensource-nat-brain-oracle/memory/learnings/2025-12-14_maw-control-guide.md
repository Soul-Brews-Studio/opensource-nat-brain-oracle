# MAW Control Guide - Practical Commands

> **Purpose**: Copy-paste commands for controlling MAW agents via `maw hey` and `tmux`
> **Session**: `ai-Nat-s-Agents`
> **Profile**: profile14 (2 windows × 3 horizontal panes)

---

## Pane Mapping (Profile14)

```
WINDOW 1 (node)           WINDOW 2 (support)
┌─────┬─────┬─────┐       ┌─────┬─────┬─────┐
│ 1.1 │ 1.2 │ 1.3 │       │ 2.1 │ 2.2 │ 2.3 │
│ Ag1 │ Ag2 │ Ag3 │       │ Ag4 │ Ag5 │ Mon │
│Claude│Codex│Codex│       │Codex│Codex│Shell│
└─────┴─────┴─────┘       └─────┴─────┴─────┘
```

| Pane | Agent | Role | Command |
|------|-------|------|---------|
| `1.1` | Agent 1 | Shadow (Claude) | `claude --dangerously-skip-permissions` |
| `1.2` | Agent 2 | Executor (Codex) | `codex --dangerously-bypass-approvals-and-sandbox` |
| `1.3` | Agent 3 | Executor (Codex) | `codex --dangerously-bypass-approvals-and-sandbox` |
| `2.1` | Agent 4 | Specialist (Codex) | `codex --dangerously-bypass-approvals-and-sandbox` |
| `2.2` | Agent 5 | Specialist (Codex) | `codex --dangerously-bypass-approvals-and-sandbox` |
| `2.3` | Monitor | Shell | Plain zsh |

---

## 1. Send Messages to Agents (`maw hey`)

### Single Agent
```bash
# ส่งงานให้ agent เฉพาะตัว
maw hey 1 "analyze the authentication flow"
maw hey 2 "list all files in src/"
maw hey 3 "git status"
maw hey 4 "search for TODO comments"
maw hey 5 "run the tests"
```

### Broadcast to All
```bash
# ส่งให้ทุก agent พร้อมกัน
maw hey all "git pull origin main"
maw hey all "report your current directory"
maw hey all "npm install"
```

### Check Available Agents
```bash
maw hey --list    # แสดง agents ที่มี
maw hey --map     # แสดง pane mapping
```

---

## 2. Read Agent Output (`tmux capture-pane`)

### Basic Capture
```bash
# อ่าน output จาก agent (tail -N = จำนวนบรรทัด)
tmux capture-pane -t ai-Nat-s-Agents:1.1 -p | tail -20   # Agent 1
tmux capture-pane -t ai-Nat-s-Agents:1.2 -p | tail -20   # Agent 2
tmux capture-pane -t ai-Nat-s-Agents:1.3 -p | tail -20   # Agent 3
tmux capture-pane -t ai-Nat-s-Agents:2.1 -p | tail -20   # Agent 4
tmux capture-pane -t ai-Nat-s-Agents:2.2 -p | tail -20   # Agent 5
tmux capture-pane -t ai-Nat-s-Agents:2.3 -p | tail -20   # Monitor
```

### Full History
```bash
# จับ history ทั้งหมด (scrollback)
tmux capture-pane -t ai-Nat-s-Agents:1.1 -p -S -1000 | tail -100
```

### Quick Status Check
```bash
# เช็คทุก agent รวดเดียว
for p in 1.1 1.2 1.3 2.1 2.2; do
  echo "=== Pane $p ==="
  tmux capture-pane -t ai-Nat-s-Agents:$p -p | tail -5
done
```

---

## 3. Send Raw Commands (`tmux send-keys`)

### Basic Send
```bash
# ส่ง command ตรงๆ (C-m = Enter)
tmux send-keys -t ai-Nat-s-Agents:1.1 "pwd" C-m
tmux send-keys -t ai-Nat-s-Agents:2.3 "echo hello" C-m
```

### Send Without Execute
```bash
# พิมพ์แต่ไม่กด Enter (ให้ user กดเอง)
tmux send-keys -t ai-Nat-s-Agents:1.1 "git push origin main"
```

### Send Special Keys
```bash
# Ctrl+C (interrupt)
tmux send-keys -t ai-Nat-s-Agents:1.1 C-c

# Escape
tmux send-keys -t ai-Nat-s-Agents:1.1 Escape

# Clear screen
tmux send-keys -t ai-Nat-s-Agents:1.1 "clear" C-m
```

---

## 4. Practical Workflows

### Workflow 1: Assign Tasks to Multiple Agents
```bash
# แจกงานให้แต่ละ agent
maw hey 1 "read CLAUDE.md and summarize the key rules"
maw hey 2 "search for all TODO comments in the codebase"
maw hey 3 "run npm test and report results"

# รอ 30 วินาที แล้วเก็บผล
sleep 30
for p in 1.1 1.2 1.3; do
  echo "=== Agent $p ==="
  tmux capture-pane -t ai-Nat-s-Agents:$p -p | tail -10
done
```

### Workflow 2: Sync All Agents
```bash
# ให้ทุก agent pull code ใหม่
maw hey all "git fetch origin && git pull origin main"
```

### Workflow 3: Check Agent Status
```bash
# เช็คว่า agent ทำอะไรอยู่
for i in 1 2 3 4 5; do
  echo "--- Agent $i ---"
  maw hey $i "pwd && git branch --show-current"
done
```

### Workflow 4: Interrupt All Agents
```bash
# หยุดทุก agent (Ctrl+C)
for p in 1.1 1.2 1.3 2.1 2.2; do
  tmux send-keys -t ai-Nat-s-Agents:$p C-c
done
```

### Workflow 5: Broadcast Then Collect
```bash
# ส่งคำสั่งเดียวกัน แล้วเก็บผล
maw hey all "git status --short"
sleep 5
for p in 1.1 1.2 1.3 2.1 2.2; do
  echo "=== $p ===" && tmux capture-pane -t ai-Nat-s-Agents:$p -p | tail -8
done
```

---

## 5. Session Management

### List Session Info
```bash
tmux list-sessions                           # ดู sessions ทั้งหมด
tmux list-windows -t ai-Nat-s-Agents         # ดู windows
tmux list-panes -t ai-Nat-s-Agents:1         # ดู panes in window 1
tmux list-panes -t ai-Nat-s-Agents:2         # ดู panes in window 2
```

### Restart MAW
```bash
# Kill และ restart
tmux kill-session -t ai-Nat-s-Agents
export AUTO_START_AGENTS=1 && source .envrc && maw start profile14
```

### Attach to Session (from real terminal)
```bash
tmux attach -t ai-Nat-s-Agents
```

---

## 6. Quick Reference

| Task | Command |
|------|---------|
| ส่งให้ agent 1 | `maw hey 1 "message"` |
| ส่งให้ทุก agent | `maw hey all "message"` |
| อ่าน output agent 1 | `tmux capture-pane -t ai-Nat-s-Agents:1.1 -p \| tail -20` |
| ส่ง command ตรงๆ | `tmux send-keys -t ai-Nat-s-Agents:1.1 "cmd" C-m` |
| Interrupt agent | `tmux send-keys -t ai-Nat-s-Agents:1.1 C-c` |
| ดู agent mapping | `maw hey --map` |
| Kill session | `tmux kill-session -t ai-Nat-s-Agents` |

---

## 7. Troubleshooting

### Agent ไม่ตอบ
```bash
# เช็คว่า agent ยังทำงานอยู่ไหม
tmux capture-pane -t ai-Nat-s-Agents:1.1 -p | tail -5

# ถ้าค้าง ให้ interrupt
tmux send-keys -t ai-Nat-s-Agents:1.1 C-c
```

### Session หาย
```bash
# เช็คว่ามี session ไหม
tmux list-sessions | grep ai-Nat

# ถ้าไม่มี ให้ start ใหม่
export AUTO_START_AGENTS=1 && source .envrc && maw start profile14
```

### maw hey ไม่ทำงาน
```bash
# ต้อง source .envrc ก่อน
source .envrc
maw hey 1 "test"
```

---

## Notes

- **maw hey** ใช้ tmux send-keys ข้างใน (delivery ~100ms)
- **Agents 1-5** อยู่ใน worktrees แยก (`agents/1/`, `agents/2/`, etc.)
- **Monitor pane (2.3)** เป็น shell ธรรมดา ไม่มี agent
- **C-m** = Enter key ใน tmux send-keys

---

*Created: 2025-12-14 00:08*
*Session: ai-Nat-s-Agents (profile14)*
