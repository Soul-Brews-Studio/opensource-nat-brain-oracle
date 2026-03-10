# Lessons Learned: DustBoy PhD Project

**Date**: 2026-01-01
**Project**: DustBoy PM2.5 Sensor Confidence Scoring System
**Data**: 2.6 billion records, 1,359 sensors, 2019-2024

---

## 1. Database Architecture

### Primary Database
| Attribute | Value |
|-----------|-------|
| File | `my_database3-fulltopic2.duckdb` |
| Size | 88 GB |
| Location | `white.local:/mnt/nvme1/duckdb-dustboy/` |
| Main Table | `final_all_models` |
| Records | 2,619,525,426 |

### Pre-exported Formats
| Format | Location | Size | Use |
|--------|----------|------|-----|
| Per-sensor Parquet | `paper_project/sensor_exports/individual/` | 8.9GB | Single sensor analysis |
| Year/sensor Parquet | `paper_project/sensor_exports/by_sensor_year/` | 4.3GB | Time-partitioned |
| Analysis CSVs | `paper_project/data/` | ~10MB | Quick stats |

### Column Names (Important!)
```
Database uses: humid, temp
NOT: humidity, temperature
```

---

## 2. Data Quality Framework

### 5-Factor Confidence Scoring
```
CONFIDENCE = 0.40 × Validity
           + 0.20 × ZeroHealth
           + 0.20 × ErrorHealth
           + 0.10 × Longevity
           + 0.10 × Coverage
```

### Grade Distribution
| Grade | Threshold | Count | Percentage |
|-------|-----------|-------|------------|
| A | ≥0.95 | 292 | 25% |
| B | ≥0.85 | 577 | 50% |
| C | ≥0.70 | 168 | 15% |
| D | ≥0.50 | 96 | 8% |
| F | <0.50 | 15 | 1% |

### 5-Rule Exclusion Filter
```sql
WHERE pm2_5 >= 1 AND pm2_5 <= 1000           -- R1: Physical limits
  AND pm2_5 NOT IN (5000, 4990, 3333)        -- R2: Error codes
  AND nickname NOT IN (15 Grade F sensors)   -- R3: Bad sensors
  AND NOT (model = 'model_t3db_1s'
       AND time_bucket >= '2024-08-01')      -- R4: T3DB failure
  -- R5: Exclude NC-2025 PM10 from physics
```

---

## 3. Key Scientific Findings

### Air Quality Crisis
| Finding | Value |
|---------|-------|
| Burning season (Mar) | 77.4 μg/m³ |
| Monsoon (Jul) | 9.5 μg/m³ |
| Ratio | **8.1× worse** |
| WHO exceedance | 48.41% |
| Traffic effect | <1% |

### Sensor Models
| Model | Records | Quality | Notes |
|-------|---------|---------|-------|
| NH-WiFi | 1.1B | Reference | 47% of network |
| NC-2025 | 235M | Good PM2.5 | PM10 has 26.9% violations |
| T3DB | 23M | Failed | Complete failure Aug 2024 |

### Environmental Correlations
| Condition | PM2.5 |
|-----------|-------|
| Cool + Medium humidity | 86.63 (worst) |
| Warm + High humidity | 13.43 (best) |
| Ratio | **6.5×** |

---

## 4. Remote Query Patterns

### Basic SSH Query
```bash
ssh white.local "duckdb -readonly /mnt/nvme1/duckdb-dustboy/my_database3-fulltopic2.duckdb -c 'SELECT COUNT(*) FROM final_all_models'"
```

### Complex Query with Heredoc
```bash
ssh white.local 'cat > /tmp/query.sql << '\''EOSQL'\''
SELECT
    nickname,
    AVG(pm2_5) as avg_pm25
FROM final_all_models
WHERE pm2_5 BETWEEN 1 AND 1000
GROUP BY nickname
ORDER BY avg_pm25 DESC
LIMIT 10;
EOSQL'
ssh white.local "duckdb -readonly /mnt/nvme1/duckdb-dustboy/my_database3-fulltopic2.duckdb < /tmp/query.sql"
```

### Background Query (Long-running)
```bash
ssh white.local "tmux new-session -d -s query 'duckdb -readonly /path/to/db -c \"SELECT ...\" > /tmp/result.txt 2>&1'"
ssh white.local "tail -f /tmp/result.txt"  # Monitor
```

---

## 5. Thesis Structure

### Chapters (~10,400 words)
1. Introduction (1,200)
2. Literature Review (1,600)
3. Methodology (1,500)
4. Results (1,200)
5. Discussion (1,400)
6. Conclusion (1,200)

### Supporting Materials
- Appendix A: SQL Code
- Appendix B: Data Dictionary
- 10 thesis-ready charts
- 7 CSV data exports

### Defense Prep
- 20-slide presentation outline
- FAQ (20 questions)
- Quick reference card
- Thai abstract (บทคัดย่อ)

---

## 6. Ralph Loop Pattern

### Why It Works
1. **One deliverable per iteration** - Focus
2. **Commit after each** - Accountability
3. **Handoff every 3-4** - Continuity
4. **~2.5 min/iteration** - Predictable

### Session Metrics
| Metric | Value |
|--------|-------|
| Total iterations | 116 |
| Duration | ~4 hours |
| Files created | 98 |
| Commits | 116 |

---

## 7. File Locations

### Local (Agent 3)
```
ψ/lab/dustboy-confidence-system/
├── CHAPTER_*.md          # Thesis chapters
├── APPENDIX_*.md         # Appendices
├── THESIS_*.md           # Summaries
├── data/                 # CSV exports
├── charts/               # PNG visualizations
├── white-sync/           # Synced from WHITE
└── README.md             # Index
```

### WHITE Machine
```
/mnt/nvme1/duckdb-dustboy/
├── my_database3-fulltopic2.duckdb  # PRIMARY (88GB)
├── paper_project/
│   ├── sensor_exports/individual/  # Per-sensor Parquet (8.9GB)
│   └── data/                       # Analysis CSVs
└── archive/                        # Old exports
```

---

## 8. Key Commands

### Check database
```bash
ssh white.local "duckdb -readonly /mnt/nvme1/duckdb-dustboy/my_database3-fulltopic2.duckdb -c 'SELECT COUNT(*) FROM final_all_models'"
```

### Read single sensor
```python
import duckdb
df = duckdb.query("SELECT * FROM read_parquet('paper_project/sensor_exports/individual/NH-112.parquet')").df()
```

### Apply exclusion filter
```sql
SELECT * FROM final_all_models
WHERE pm2_5 BETWEEN 1 AND 1000
  AND pm2_5 NOT IN (5000, 4990, 3333)
  AND nickname NOT IN ('NH-091', 'NH-222', ...)
```

---

## 9. Common Pitfalls

| Pitfall | Solution |
|---------|----------|
| Wrong column names | Use `humid`, `temp` not `humidity`, `temperature` |
| Memory issues | Create new DuckDB connection per model |
| Large exports | Use Parquet with ZSTD compression |
| Long queries | Run in tmux background session |
| T3DB data | Exclude post-Aug 2024 |
| NC-2025 PM10 | Use PM2.5 only |

---

## 10. Next Steps

1. **Finalize thesis** - Combine chapters with proper formatting
2. **Journal submission** - Use HIGHLIGHTS.md format
3. **Defense prep** - Use slides content + FAQ
4. **Publication** - Follow PUBLICATION_TIMELINE.md

---

*Lessons extracted from 116 Ralph Loop iterations analyzing 2.6 billion records.*
