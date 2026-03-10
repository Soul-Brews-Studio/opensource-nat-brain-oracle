---
title: "React Frontend Vite Port Collision Debugging"
date: 2026-01-01
concepts: [vite, react, port-collision, debugging, dev-browser]
---

# React Frontend Vite Port Collision

## The Problem

When testing a new Vite React frontend on localhost:5173, the browser showed a completely different app (Arthur v2 Oracle dashboard) instead of the data-aware-rag frontend being developed.

## The Mistake

Assumed port 5173 was available for the new frontend. Did not check what was already running on common Vite ports.

## The Fix

1. Check what's running: `lsof -i :5173`
2. Check Vite's auto-incremented port in server output
3. Vite auto-increments: 5173 -> 5174 -> 5175 -> 5176 -> 5177
4. The actual frontend was on port 5177

## The Pattern

```bash
# Always check the Vite dev server output for actual port
bun run dev
# Look for: ➜  Local:   http://localhost:5177/

# Or explicitly set port
PORT=5180 bun run dev
```

## Key Insight

Multiple Vite projects running simultaneously will auto-increment ports. Always verify the actual serving port from the server output before testing.

---

*Learned during: Data-Aware RAG React Frontend Session 2026-01-01*
