---
title: Check File Size Before Reading
created: 2025-12-09
source: Nat feedback on DustBoy chat handling
tags:
  - token-efficiency
  - file-handling
  - subagent
  - workflow
aliases:
  - wc -l pattern
  - file size check
---

# Learning: Check File Size Before Reading

## Context Links

- **Source Retrospectives**:
  - [[21.16_context-overload-honest-feedback|Context Overload - Honest Feedback]] - DustBoy chat (1443 lines) triggered this pattern
  - [[20.36_evening-context-and-brewing|Evening Context and Brewing]] - First session with large file handling
- **Related Learnings**:
  - [[001-delegate-reading|Delegate Reading]] - Use context-finder for large files
  - [[002-context-finder-first|Context Finder First]] - Subagent-first approach

---

## Pattern

**Before reading any file, check its size first:**

```bash
wc -l "filename.txt"
```

## Decision Tree

```
File size?
├── Small (< 500 lines) → Read directly
├── Medium (500-2000 lines) → Read head + tail, decide
└── Large (> 2000 lines) → Use context-finder subagent (Haiku)
```

## Why

1. **Token efficiency** — Don't waste Opus tokens on raw data
2. **Context preservation** — Large files eat context window
3. **Speed** — Haiku summarizes faster than Opus reading everything
4. **Cost** — Haiku is cheaper for bulk text processing

## Implementation

```bash
# Step 1: Check size
wc -l "file.txt"

# Step 2: If large, preview only
head -50 "file.txt"
tail -100 "file.txt"

# Step 3: If still need full analysis, use subagent
Task(subagent_type="context-finder", model="haiku", prompt="summarize...")
```

## Nat's Words

> "ก่อนที่ Opus จะเป็นคนอ่าน ให้ตัดสินใจก่อน"
> "ถ้ายาวไป ไม่อ่าน หาอินไซด์มาก่อน"
> "ให้เช็ค status ของไฟล์ก่อนว่าเป็นยังไง"

---

## Example (Good)

```bash
# DustBoy chat - 1443 lines - too long
wc -l "/Users/nat/Downloads/[LINE]DustBoy ทีมพี่ณัฐ.txt"
# → 1443 lines = use head/tail + summarize

head -50 "file.txt"
tail -100 "file.txt"
# → Got enough context to write summary
```

---

*This pattern should be followed ALWAYS before reading unknown files*

---

## See Also

- [[004-human-confirmation-loop|Human Confirmation Loop]] - Another "check before act" pattern
- [[003-speech-to-text-uncertainty|Speech to Text Uncertainty]] - Handling uncertainty in input
- [[006-plugin-system-architecture|Plugin System Architecture]] - Subagent workflow patterns
