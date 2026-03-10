# InfluxDB Epoch Precision: Use epoch=s for Telegraf Data

**Date**: 2025-12-29

## What We Learned

- InfluxDB 1.x returns timestamps in **nanoseconds** by default
- Telegraf outputs timestamps in **seconds** (Unix epoch)
- Queries like `WHERE time > now() - 24h` work, but returned timestamps are unreadable
- Add `epoch=s` parameter to get human-readable seconds

```bash
# Wrong - returns nanosecond timestamps (hard to read)
curl "http://influxdb.example.com/query?db=mydb&q=SELECT * FROM v1 LIMIT 1"
# Returns: 1766931300000000000

# Correct - returns second timestamps
curl "http://influxdb.example.com/query?db=mydb&epoch=s&q=SELECT * FROM v1 LIMIT 1"
# Returns: 1766931300 (readable, matches Telegraf output)
```

## How Things Connect

- Telegraf → MQTT → InfluxDB writes in seconds
- Grafana works because it handles precision automatically
- Direct queries fail silently (empty or confusing results) without epoch=s
- CLI tool `/opt/homebrew/opt/influxdb@1/bin/influx` also needs `-precision s`

## Why It Matters

- Debugging data pipelines requires matching timestamp precision
- "Empty results" often means precision mismatch, not missing data
- Grafana hiding this complexity can mask underlying issues

## Tags

`influxdb` `telegraf` `timestamp` `epoch` `precision` `debugging`
