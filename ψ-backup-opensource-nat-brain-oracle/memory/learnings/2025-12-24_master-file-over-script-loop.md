# Lesson: MASTER File Over Script Loop

**Date**: 2025-12-24
**Context**: Antigravity image generation automation
**Source**: Session retrospective

## The Pattern

When automating tasks with AI tools that can read files:

| Approach | Complexity | Speed | Reliability |
|----------|------------|-------|-------------|
| Script loop (100 iterations) | High | Slow (~2.5h) | Error-prone |
| **Single MASTER file** | Low | Fast | Robust |

## Why It Works

AI tools like Antigravity can:
1. **Read markdown files** — understands structure
2. **Follow instructions** — executes prompts in sequence
3. **Handle state** — knows which ones are done

## Anti-Pattern: Over-Engineering

```bash
# ❌ Complex: Extract prompt, send, wait, repeat
for i in 301..400; do
  prompt=$(extract_from_file "antigravity-$i.md")
  osascript send.scpt "$prompt"
  sleep 90
done
```

## Pattern: Trust the Tool

```bash
# ✅ Simple: Send file, let AI handle it
osascript send.scpt "Read and execute: MASTER-AUTO-301-400.md"
```

## When to Apply

- AI tool can read files directly
- Task is sequential (do all items in order)
- You have a structured document (markdown, yaml)

## When NOT to Apply

- Tool can't read files
- Need custom logic per item
- Need to track/resume partial progress

## Key Insight

> "ไม่ต้อง extract prompt เอง — แค่ส่ง file path"

The simpler approach often works because modern AI tools are capable of understanding structured documents. Don't pre-process what the tool can handle natively.

---

**Tags**: #automation #simplicity #antigravity #ai-tools
