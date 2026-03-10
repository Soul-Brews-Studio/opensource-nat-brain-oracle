---
title: "Confidence Scoring for Low-Cost Sensors + Remote DuckDB Pattern"
date: 2026-01-01
tags: [duckdb, remote, thesis, data-quality, confidence-scoring]
---

# Lesson Learned: Confidence Scoring System for Sensor Data

## Context

Building a quantitative confidence scoring system for DustBoy PM2.5 sensors to support PhD thesis. Needed to:
1. Learn from another AI's analysis on remote server
2. Design reproducible scoring formula
3. Create thesis-ready documentation

## What I Learned

### 1. Confidence Score Formula Design

**5-factor weighted formula worked well**:
```
CONFIDENCE = (0.40 × Validity) +    -- Primary metric
             (0.20 × ZeroHealth) +   -- Inverse of failures
             (0.20 × ErrorHealth) +  -- Inverse of errors
             (0.10 × Longevity) +    -- Time-tested
             (0.10 × Coverage)       -- Completeness
```

**Key insight**: Validity alone isn't enough. A sensor with 99% validity but 50% zeros is worse than one with 95% validity and 1% zeros.

### 2. Grade Thresholds

| Grade | Threshold | Practical Meaning |
|-------|-----------|-------------------|
| A | ≥0.95 | No caveats needed |
| B | ≥0.85 | Standard filtering |
| C | ≥0.70 | Document limitations |
| D | ≥0.50 | Strong justification |
| F | <0.50 | Exclude |

### 3. Remote DuckDB Query Pattern

**Problem**: Long queries on 2.6B records timeout over SSH

**Solution**: Write SQL to file, execute via tmux

```bash
# Write SQL (avoid escaping hell)
ssh white.local 'cat > /tmp/query.sql << '\''EOF'\''
SELECT ... your query ...
EOF'

# Execute in tmux
ssh white.local "tmux send-keys -t 0 'duckdb -readonly /path/db < /tmp/query.sql | tee /tmp/result.txt' Enter"

# Wait and fetch result
sleep 20
ssh white.local "cat /tmp/result.txt"
```

**Why this works**:
- SQL file avoids quote escaping issues
- tmux prevents SSH timeout
- tee captures output to file for retrieval
- Can run multiple queries in parallel with different session names

### 4. Building on Other AI's Work

**Pattern**: Read existing analysis before querying

The other AI (Ralph Loop) had already done:
- 29 iterations of analysis
- 133 CSV exports
- Comprehensive data quality reports

I found key files:
- `DATA_QUALITY_EXCLUSION_CRITERIA.md` - 46 sensors to exclude
- `DATA_QUALITY_REPORT.md` - Model quality tiers
- `DATA_QUALITY_INSPECTION.md` - CRITICAL sensors list

**Lesson**: Always check for existing work. Don't reinvent.

### 5. Error Codes Are Gold

Specific error values reveal sensor design:
- `5000` - Overflow/saturation
- `4990` - Near-overflow
- `3333` - Calibration error

These are not PM2.5 readings - they're diagnostic codes. Excluding them is not data loss; it's data cleaning.

## What I'd Do Differently

1. **Write SQL files first** - Avoid quote escaping completely
2. **Run queries in parallel** - Use multiple tmux sessions
3. **Read other AI's INDEX files first** - MASTER_INDEX.md has everything

## Key Takeaway

**A quantitative confidence score transforms "this sensor seems unreliable" into "this sensor has a 0.42 confidence score, Grade F, due to 88% zeros."**

This is what thesis committees want - reproducible, defensible metrics.

## 6. Cross-Validation Works

Comparing two independent AI analyses:
- My confidence scoring: 15 Grade F sensors
- Other AI rule-based: 46 excluded sensors
- **7 sensors overlap** = undisputed bad sensors

Multiple methods converging on same bad sensors = strong validation.

## 7. Ralph Loop Pattern

For long-running analysis tasks:
1. Each iteration = one focused deliverable
2. Commit after each iteration
3. Update handoff continuously
4. Never stop the loop yourself

---

*Applies to: Remote data analysis, sensor networks, data quality assessment*
