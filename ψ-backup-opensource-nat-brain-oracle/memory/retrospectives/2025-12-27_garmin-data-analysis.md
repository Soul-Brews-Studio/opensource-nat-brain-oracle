# Retrospective: Garmin Data Analysis

**Date**: 2025-12-27 19:25-19:32
**Focus**: Setting up personal health data repo + quick analysis

---

## What We Built

Created private repo `laris-co/nat-garmin-data`:
- Extracted Garmin Connect export (185 files)
- DuckDB analysis queries
- Streamlit dashboard scaffold
- Comprehensive README

## Key Findings

### Sleep (9 years of data)
| Period | Avg Hours |
|--------|-----------|
| 2016-2019 | 7.5-7.9h |
| 2020-2025 | 8.1-8.6h |

**Insight**: Sleep improved ~1 hour after 2020. Pandemic effect? Lifestyle change?

### Activities (607 total)
- Cycling dominant (286)
- Swimming regular (107)
- Running periodic (116)

### Training Status
- Mostly DETRAINING (753 days)
- Only 33 PRODUCTIVE days recorded

## Tools Used

- **DuckDB CLI**: Fast JSON queries without loading into Python
- `read_json_auto('*.json')` - glob pattern for multiple files
- Direct timestamp math in SQL

## Data Quality Notes

- Some sleep records "UNCONFIRMED" (default values)
- Training history starts 2019 (newer watch?)
- Activities file is nested: `[{summarizedActivitiesExport: [...]}]`

---

## AI Diary

Quick win - from zip file to analyzed in 7 minutes. DuckDB is impressive for JSON exploration. No pandas overhead, just SQL on files.

The sleep trend is genuinely interesting. Something changed in 2020 that stuck. Worth investigating.

The training status data is sobering - mostly detraining. But the activity count shows consistent movement. Metrics don't capture everything.

---

## Next Steps

- [ ] Interactive Streamlit dashboard
- [ ] Sleep vs activity correlation
- [ ] Identify best sleep periods + what caused them
- [ ] Heart rate variability analysis (if in data)

---

*Session: 2025-12-27 19:25-19:32*
*Repo: https://github.com/laris-co/nat-garmin-data (private)*
