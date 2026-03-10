# Oracle v2 Extraction Pattern

**Date**: 2025-12-24
**Source**: Trace session enlightenment
**Issue**: #40

---

## The Pattern

```
Personal Project (v1)     →     Open Source (v2)
─────────────────────           ──────────────────
Prove concepts                  Extract framework
Accumulate patterns             Remove personal data
Build with real use             Generalize for others
Keep private                    Share publicly
                    ↘     ↙
                  v2 consults v1
```

---

## Why v2 Consults v1

| Approach | Problem |
|----------|---------|
| Copy v1 → clean | Loses connection, becomes stale |
| Start fresh v2 | Loses 175h of proven wisdom |
| **v2 consults v1** | Best of both — fresh + wisdom |

**How**: v2 can `ghq get` v1 as reference (private clone)

---

## The Split

| Layer | Keep in v1 (Private) | Extract to v2 (Public) |
|-------|---------------------|------------------------|
| Philosophy | ✅ Proven examples | Generic principles |
| Commands | Personal refs | Same logic, no personal |
| Resonance | Nat's identity | Template structure |
| Learnings | Specific patterns | Framework to capture |
| Retrospectives | 149 real sessions | Template + examples |

---

## When to Extract

**Signals that v1 is ready**:
- [ ] Philosophy crystallized (3+ core principles)
- [ ] Commands stable (no major changes in 1 week)
- [ ] Pattern clear (can explain in 1 sentence)
- [ ] Real usage proven (not just theory)

**Oracle v1 status** (Dec 24):
- ✅ Philosophy: 3 principles, 16 days proven
- ✅ Commands: /rrr, /trace, /snapshot stable
- ✅ Pattern: "External brain, not command"
- ✅ Usage: 640 commits, 149 retrospectives

---

## Implementation Notes

### v2 Repo Structure
```
oracle-framework/
├── philosophy/          # Generic principles
├── commands/            # Reusable commands
├── templates/
│   ├── resonance/       # Identity template
│   ├── retrospective/   # Session template
│   └── learning/        # Pattern template
├── examples/            # Sanitized examples
└── CLAUDE.md            # For Claude Code users
```

### Plugin Publishing
```
oracle-core        → Philosophy + ψ/ structure
oracle-commands    → /rrr, /snapshot, /trace
oracle-resonance   → Identity capture framework
```

---

## Key Insight

> "v2 ไม่ได้แทน v1 — v2 **consults** v1"

Personal journey stays personal. Framework is what you share.

---

## Related

- Issue #40: Oracle v2 - Open Source Framework
- Retrospective: 2025-12-24_oracle-v2-enlightenment-trace-session.md
- Philosophy: plugins/nat-data-personal/knowledge/oracle-philosophy.md
