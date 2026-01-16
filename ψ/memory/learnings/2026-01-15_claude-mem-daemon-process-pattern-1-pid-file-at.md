---
title: Claude-mem daemon process pattern: (1) PID file at ~/.app/worker.pid with {pid, 
tags: [daemon, process-manager, pid-file, spawn, detached, graceful-shutdown, claude-mem]
created: 2026-01-15
source: claude-mem v9.0.0 ProcessManager.ts
---

# Claude-mem daemon process pattern: (1) PID file at ~/.app/worker.pid with {pid, 

Claude-mem daemon process pattern: (1) PID file at ~/.app/worker.pid with {pid, port, startedAt}, (2) spawn with detached:true, stdio:'ignore', windowsHide:true then child.unref(), (3) Signal handlers for SIGTERM/SIGINT with graceful shutdown + PID file cleanup, (4) Orphan cleanup on startup to kill stale processes from crashed sessions. This pattern enables start/stop/restart/status CLI commands for any background service.

---
*Added via Oracle Learn*
