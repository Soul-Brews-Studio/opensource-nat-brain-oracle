# Track: Oracle-v2 Trace & Activity Implementation

**Created**: 2026-01-10 09:05
**Status**: Active
**Priority**: High

## Goal

Implement Issues #17 and #18 in oracle-v2

## Issues

| Issue | Feature | Spec |
|-------|---------|------|
| #17 | Trace Log | `oracle-v2/docs/issues/trace-log-feature-spec.md` |
| #18 | Activity Index | `oracle-v2/scripts/activity-helper.py` |

## MCP Tools to Implement

### Issue #17 - Trace Log
- `oracle_trace` - Log a trace with dig points
- `oracle_trace_list` - List recent traces
- `oracle_trace_dig` - Get dig points for a trace
- `oracle_trace_chain` - Show trace ancestry
- `oracle_trace_distill` - Extract awakening from trace

### Issue #18 - Activity Index
- `oracle_activity` - Get today's ground truth (learnings, retros, commits)

## Files

- Spec: `oracle-v2/docs/issues/trace-log-feature-spec.md` (772 lines)
- Helper: `oracle-v2/scripts/activity-helper.py` (30 lines)

## Next Action

Start with Issue #17 - trace_log database schema and first MCP tool

---

*Last updated: 2026-01-10 09:05*
