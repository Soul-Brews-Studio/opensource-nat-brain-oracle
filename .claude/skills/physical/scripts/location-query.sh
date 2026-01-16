#!/bin/bash
# Fetch location data from GitHub and query with DuckDB
# Usage: ./location-query.sh [current|time|all]

MODE=${1:-all}

# Current location
if [[ "$MODE" == "current" || "$MODE" == "all" ]]; then
  gh api repos/laris-co/nat-location-data/contents/current.csv --jq '.content' | base64 -d
fi

# Time at location (from history)
if [[ "$MODE" == "time" || "$MODE" == "all" ]]; then
  echo "---TIME_AT_LOCATION---"
  gh api repos/laris-co/nat-location-data/contents/history.csv --jq '.content' | base64 -d | duckdb -c "
SELECT
  MIN(updated) as first_seen,
  MAX(updated) as last_seen,
  COUNT(*) as records,
  ROUND(EXTRACT(EPOCH FROM (MAX(updated) - MIN(updated)))/3600, 1) as hours_here
FROM read_csv('/dev/stdin', header=false, ignore_errors=true, null_padding=true,
  columns={'device':'VARCHAR','model':'VARCHAR','battery':'INT','charging':'VARCHAR',
    'lat':'DOUBLE','lon':'DOUBLE','accuracy':'INT','source':'VARCHAR',
    'place':'VARCHAR','place_type':'VARCHAR','locality':'VARCHAR',
    'address':'VARCHAR','updated':'TIMESTAMP'})
WHERE device LIKE '%iPhone%'"
fi
