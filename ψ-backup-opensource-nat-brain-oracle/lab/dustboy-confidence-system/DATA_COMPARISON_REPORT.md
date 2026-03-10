# DustBoy Data Comparison Report

**Date**: 2026-01-02
**Analyst**: Agent 3

---

## Executive Summary

Comparison of OLD (2019-2024) and NEW (Nov 2024-present) InfluxDB exports reveals:

| Finding | Impact |
|---------|--------|
| **Zero sensor overlap** | Different naming conventions (Wplus vs DustBoyTPlus) |
| **PM2.5 significantly lower** | OLD avg: 30.7 μg/m³ → NEW avg: 13.8 μg/m³ |
| **New indoor sensors (T4)** | 91 sensors, avg PM2.5: 7.8 μg/m³ |
| **New GPS mobile (Donaus)** | 35 sensors with lat/lon tracking |
| **Corrupted file** | n-nc-2025.parquet needs re-export |

---

## Dataset Comparison

### Overview

| Metric | OLD (2019-2024) | NEW (Nov 2024+) |
|--------|-----------------|-----------------|
| Records | 1.29 billion | 712 million* |
| Sensors | 1,355 | 385 |
| Models | 10 | 12 |
| Date Range | 2019-09-26 to 2024-10-02 | 2024-11-15 to 2026-01-02 |
| Avg PM2.5 | 30.7 μg/m³ | 13.8 μg/m³ |
| Median PM2.5 | ~15 μg/m³ | ~7 μg/m³ |

*Excluding corrupted n-nc-2025.parquet

### Data Gap

```
OLD:  2019 ════════════════════════════ Oct 2024 ║
NEW:                                    Nov 2024 ════════ Jan 2026
                                         ↑
                                    ~6 week gap
                                  (Oct 2-Nov 15)
```

---

## Key Discoveries

### 1. Different Sensor Models

| OLD Model | NEW Model | Relationship |
|-----------|-----------|--------------|
| Wplus (W+) | TPlus (T+) | **Different hardware** |

**Confirmed by user**: Wplus and TPlus are completely different sensor models, not renamed versions.

**Impact**: OLD and NEW datasets represent different sensor deployments. No direct sensor matching possible.

### 2. New Sensor Types

#### T4 - Indoor Air Quality (NEW!)
| Stat | Value |
|------|-------|
| Sensors | 91 |
| Records | 7.5M |
| Avg PM2.5 | 7.8 μg/m³ |
| Median PM2.5 | 4.0 μg/m³ |
| Period | Jan 2025 - present |

**Insight**: Indoor air is much cleaner than outdoor. Median 4 μg/m³ vs outdoor 10-15 μg/m³.

#### Donaus - GPS Mobile (NEW!)
| Stat | Value |
|------|-------|
| Sensors | 35 |
| Records | 2.5M |
| Avg PM2.5 | 17.8 μg/m³ |
| Period | May 2025 - present |

**Insight**: Mobile sensors with lat/lon tracking. Enables spatial analysis.

### 3. PM2.5 Improvement

| Model | OLD Avg | NEW Avg | Change |
|-------|---------|---------|--------|
| T3 (old) vs TDB (new) | 73.6 | 15.4 | -79% |
| General | 30.7 | 13.8 | -55% |

**Possible explanations**:
1. Sensor recalibration
2. Better data cleaning in new InfluxDB
3. Actually cleaner air
4. Different sensor locations
5. Seasonal variation (winter vs summer)

---

## Schema Differences

### OLD Dataset (Cleaned)
```
model | nickname | time_bucket | pm2_5 | pm10 | humid | temp
```
Simple, pre-aggregated, easy to analyze.

### NEW Dataset (Two Formats)

**Parsed format** (tdb, t4, donaus):
```
name | time | pm2_5 | pm10 | temp | humid | nickname | webid | topic
+ statistics: pm2_5_count, pm2_5_min, pm2_5_max, pm2_5_stdev, pm2_5_s2
```

**Raw format** (n-nbiotdb, etc.):
```
timestamp | raw_line | model
```
Needs parsing before analysis.

---

## Issues Found

### 1. Corrupted File
```
exports_2024_new/n-nc-2025.parquet
- Size: 2.4 GB
- Error: "No magic bytes found at end of file"
- Action: Re-export from WHITE server
```

### 2. Schema Inconsistency
Some new exports have parsed schema, others have raw line protocol.
- Parsed: tdb, t4, t3, donaus, sonydb2
- Raw: n-nbiotdb, n-nh-wifi, n-wifidb, n-wifidb2, n-wifiblackdb, n-wplus-dustboy22

### 3. Missing Fields
- Donaus has lat/lon but pm2_5 is NULL (pm10 only)
- Some files missing nickname field

---

## Recommendations

### Immediate
1. **Re-export n-nc-2025** - File is corrupted
2. **Parse raw files** - Convert raw_line to structured columns
3. **Standardize schemas** - Create unified view across all models

### Analysis
1. **Match sensors** - Try webid or location matching between OLD/NEW
2. **Investigate PM2.5 drop** - Is it real or calibration?
3. **Seasonal analysis** - Compare same months across years

### Dashboard
1. **Add T4** - Indoor air quality page
2. **Add Donaus** - Map visualization with GPS
3. **Compare page** - OLD vs NEW trends

---

## Files Summary

| File | Size | Rows | Status | Schema |
|------|------|------|--------|--------|
| donaus.parquet | 95M | 2.5M | ✅ | Parsed |
| n-nbiotdb.parquet | 205M | 27M | ✅ | Raw |
| n-nc-2025.parquet | 2.4G | ? | ❌ Corrupted | - |
| n-nh-wifi.parquet | 1.6G | 263M | ✅ | Raw |
| n-wifiblackdb.parquet | 582M | 89M | ✅ | Raw |
| n-wifidb.parquet | 537M | 6.5M | ✅ | Raw |
| n-wifidb2.parquet | 596M | 80M | ✅ | Raw |
| n-wplus-dustboy22.parquet | 307M | 50M | ✅ | Raw |
| sonydb2.parquet | 451M | 123M | ✅ | Parsed |
| t3.parquet | 230M | 42M | ✅ | Parsed |
| t4.parquet | 367M | 7.5M | ✅ | Parsed |
| tdb.parquet | 589M | 21M | ✅ | Parsed |

---

*Report generated from DuckDB analysis of both datasets*
