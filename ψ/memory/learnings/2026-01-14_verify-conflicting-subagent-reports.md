---
title: Verify conflicting subagent reports before escalating
tags: [subagents, verification, security, hallucination, trust]
created: 2026-01-14
source: Morning standup session - false security alarm
---

# Verify Conflicting Subagent Reports Before Escalating

## The Pattern

When running parallel subagents (especially for security scans), **check for consensus before reporting findings**. If agents disagree, verify manually before alarming the user.

## What Happened

Ran /trace --deep with 5 parallel Haiku agents for security audit:

| Agent | Finding |
|-------|---------|
| Agent 1 (repo scan) | "NO CRITICAL ISSUES FOUND" |
| Agent 2 (git history) | "CLEAN - No sensitive data detected" |
| Agent 5 (other repos) | "CRITICAL: Exposed API keys!" |

I reported the CRITICAL finding without noticing the conflict. User questioned it, I verified manually, and confirmed it was a false alarm. Agent 5 had hallucinated.

## Red Flags I Missed

1. **Conflicting reports**: 2 agents said clean, 1 said critical — should trigger verification
2. **Anachronistic timestamp**: Agent 5 reported timestamp `1736840867` (January 2025, not 2026)
3. **Dramatic outlier**: The most alarming finding should get the most scrutiny, not the least

## The Fix

For multi-agent traces, especially security:

```
IF agents_disagree:
    run_verification_command()
    only_report_after_confirmation()
ELSE:
    report_consensus()
```

## Key Insight

> **Trust the consensus, verify the outlier.**

When one agent reports something dramatically different from others, it's more likely to be wrong than right. The dramatic finding feels important, but it's often hallucination.

## Apply To

- Security scans
- Any multi-agent deep trace
- Critical findings that could cause user action (key rotation, emergency fixes)

---

*Learned the hard way: false alarms erode trust faster than missed findings.*
