# Track: Garmin Data Analysis

**Created**: 2025-12-27 19:25
**Last touched**: 2025-12-27 19:32
**Status**: 🟡 Cooling

---

## Goal

Analyze personal health data from Garmin export

## Current State

Private repo created: `laris-co/nat-garmin-data`
- Extracted 185 files from Garmin Connect export
- DuckDB analysis queries working
- Streamlit dashboard scaffold exists
- Key finding: Sleep improved ~1 hour after 2020

## Next Action

- [ ] Interactive Streamlit dashboard
- [ ] Sleep vs activity correlation
- [ ] Identify best sleep periods + causes
- [ ] HRV analysis (if in data)

## Context

**Repo**: https://github.com/laris-co/nat-garmin-data (private)

**Tools**: DuckDB CLI for JSON queries

**Interesting**: Training status mostly "DETRAINING" (753 days) but activities show consistent movement. Metrics don't capture everything.
