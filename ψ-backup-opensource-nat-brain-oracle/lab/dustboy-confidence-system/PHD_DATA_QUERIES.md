# PhD Thesis Data Queries

> Documentation of each query: WHY we created it and WHAT the result means

## 1. Model Summary

**Why**: Understand the scale and distribution of data across sensor models

```sql
SELECT model, COUNT(DISTINCT nickname) as sensors, COUNT(*) as records,
       AVG(pm2_5) as avg_pm25, MEDIAN(pm2_5) as median_pm25
FROM read_parquet('parquet-exports-by-model/*.parquet')
GROUP BY model ORDER BY records DESC
```

**Result**: NH-WiFi dominates (555M records, 43%), NBIoT cleanest (median 9 μg/m³)

**Thesis use**: Table 1 - Data source overview

---

## 2. Sensor Validity/Uptime

**Why**: Assess data quality - which sensors have gaps?

```sql
SELECT nickname,
       COUNT(DISTINCT CAST(time_bucket AS DATE)) as active_days,
       DATEDIFF('day', MIN(time_bucket), MAX(time_bucket)) + 1 as total_span,
       (active_days / total_span * 100) as uptime_pct
FROM read_parquet('parquet-exports-by-model/*.parquet')
GROUP BY nickname
```

**Result**: Average uptime 85-95%, worst sensors <80%

**Thesis use**: Section 3.2 - Data Quality Assessment

---

## 3. Monthly Trends by Model

**Why**: Identify seasonal patterns (burning season Feb-Apr)

```sql
SELECT model, DATE_TRUNC('month', time_bucket) as month,
       AVG(pm2_5) as avg_pm25
FROM read_parquet('parquet-exports-by-model/*.parquet')
GROUP BY model, DATE_TRUNC('month', time_bucket)
ORDER BY model, month
```

**Result**: Clear peaks Feb-Apr (burning season), lowest Jul-Sep (rainy)

**Thesis use**: Figure X - Seasonal PM2.5 Patterns

---

## 4. Hourly Pattern

**Why**: Understand daily pollution cycle

```sql
SELECT model, EXTRACT(HOUR FROM time_bucket) as hour,
       AVG(pm2_5) as avg_pm25
FROM read_parquet('parquet-exports-by-model/*.parquet')
GROUP BY model, EXTRACT(HOUR FROM time_bucket)
ORDER BY model, hour
```

**Result**: Peak at 8-9 AM (traffic), secondary peak 6-7 PM

**Thesis use**: Figure Y - Diurnal PM2.5 Pattern

---

## 5. Worst Polluted Locations

**Why**: Identify hotspots for targeted intervention

```sql
SELECT nickname, model, AVG(pm2_5) as avg_pm25, COUNT(*) as records
FROM read_parquet('parquet-exports-by-model/*.parquet')
GROUP BY nickname, model
HAVING AVG(pm2_5) > 100
ORDER BY avg_pm25 DESC
```

**Result**: NH-029 (132 μg/m³), NH-083 (128), NH-016 (124)

**Thesis use**: Section 4.1 - Pollution Hotspots

---

## 6. Data Deduplication Impact

**Why**: Quantify duplicate removal in data cleaning

```sql
-- Before: 2.6B records (raw per-sensor exports)
-- After: 1.29B records (deduplicated by-model exports)
-- Reduction: 51% duplicates removed
```

**Result**: 51% reduction (1.3B duplicates removed)

**Thesis use**: Section 3.1 - Data Preprocessing

---

## 7. Invalid Reading Analysis

**Why**: Understand sensor error patterns (>1000 μg/m³)

```sql
SELECT EXTRACT(MONTH FROM time_bucket) as month,
       COUNT(*) as high_readings
FROM read_parquet('parquet-exports/*.parquet')
WHERE pm2_5 > 1000
GROUP BY EXTRACT(MONTH FROM time_bucket)
```

**Result**: July has most >1000 readings (not burning season) → sensor errors, not real

**Thesis use**: Section 3.3 - Data Filtering Rationale

---

## Query Output Files

| Query | Output | Size |
|-------|--------|------|
| Model Summary | `precalc/model_summary.parquet` | ~1KB |
| Sensor Summary | `precalc/sensor_summary.parquet` | ~200KB |
| Sensor Daily | `precalc/sensor_daily.parquet` | ~50MB |
| Monthly by Model | `precalc/model_monthly.parquet` | ~100KB |
| Hourly Pattern | `precalc/model_hourly.parquet` | ~10KB |

## Run All Pre-calculations

```bash
cd ψ/lab/dustboy-confidence-system
uv run python precalculate.py
```

---

*Last updated: 2026-01-02*
