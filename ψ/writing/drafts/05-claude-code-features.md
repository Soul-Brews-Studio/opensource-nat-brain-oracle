# Claude Code Features: What's New and How to Use Them

**Status**: Draft
**Created**: 2025-12-11
**Topic**: Testing new Claude Code CLI features

---

## TL;DR

[สรุปสั้นๆ หลัง experiment เสร็จ]

---

## Background

Claude Code CLI มี features ใหม่หลายตัวที่น่าสนใจ:

1. **Resume Agent** - ต่อ session ของ agent ได้
2. **permissionMode** - ควบคุม permission ของ agent
3. **Skills auto-load** - โหลด skills อัตโนมัติ
4. **Explore subagent** - Built-in Haiku agent สำหรับ search

บทความนี้จะทดสอบแต่ละ feature และสรุปว่าควรใช้ยังไง

---

## Experiment Setup

[อธิบาย setup]

### Environment
- Claude Code version: [version]
- Model: Opus 4.5 (main), Haiku (subagents)
- Project: Nat's Agents

### Methodology
- ทดสอบแต่ละ feature แยก
- วัดผล: time, tokens, accuracy
- เปรียบเทียบกับวิธีเดิม

---

## Feature 1: Resume Agent

### What is it?
[อธิบาย]

### How to use
```yaml
resume: "agent-id-here"
```

### Test Results
| Metric | Result |
|--------|--------|
| Context preserved | [yes/no] |
| Token savings | [%] |
| Latency | [seconds] |

### Verdict
[แนะนำหรือไม่]

---

## Feature 2: permissionMode

### What is it?
[อธิบาย]

### Modes available
| Mode | Description | Risk |
|------|-------------|------|
| default | Standard prompts | Low |
| acceptEdits | Auto-accept edits | Medium |
| bypassPermissions | Skip all | High |

### Test Results
[ผลทดสอบ]

### Verdict
[แนะนำ mode ไหนสำหรับกรณีไหน]

---

## Feature 3: Skills Auto-load

### What is it?
[อธิบาย]

### How to use
```yaml
skills: skill1, skill2
```

### Test Results
[ผลทดสอบ]

### Verdict
[แนะนำหรือไม่]

---

## Feature 4: Explore Subagent

### What is it?
[อธิบาย]

### Thoroughness levels
- quick: Fast, minimal
- medium: Balanced
- very thorough: Comprehensive

### Test Results
| Agent | Time | Tokens | Accuracy |
|-------|------|--------|----------|
| Our context-finder | [?] | [?] | [?] |
| Explore (quick) | [?] | [?] | [?] |
| Explore (thorough) | [?] | [?] | [?] |

### Verdict
[ใช้อันไหนเมื่อไหร่]

---

## Summary

| Feature | Useful? | Recommend? | Use case |
|---------|---------|------------|----------|
| Resume Agent | [?] | [?] | [?] |
| permissionMode | [?] | [?] | [?] |
| Skills auto-load | [?] | [?] | [?] |
| Explore agent | [?] | [?] | [?] |

---

## Takeaways

1. [Key insight 1]
2. [Key insight 2]
3. [Key insight 3]

---

## References

- [Claude Code Docs - Subagents](https://code.claude.com/docs/en/sub-agents)
- [Experiment data](../lab/claude-code-features/experiment.md)

---

*Draft - จะ update หลัง experiment เสร็จ*
