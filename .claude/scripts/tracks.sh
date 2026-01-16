#!/bin/bash
# Tracks viewer - show all tracks grouped by time-decay

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TRACKS_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)/ψ/inbox/tracks"

# Time thresholds (in seconds)
HOT_THRESHOLD=3600       # 1 hour
WARM_THRESHOLD=86400     # 24 hours
COOLING_THRESHOLD=604800 # 7 days
DORMANT_THRESHOLD=2592000 # 30 days

now=$(date +%s)

get_decay_status() {
    local mtime=$1
    local age=$((now - mtime))

    if [[ $age -lt $HOT_THRESHOLD ]]; then
        echo "hot"
    elif [[ $age -lt $WARM_THRESHOLD ]]; then
        echo "warm"
    elif [[ $age -lt $COOLING_THRESHOLD ]]; then
        echo "cooling"
    elif [[ $age -lt $DORMANT_THRESHOLD ]]; then
        echo "cold"
    else
        echo "dormant"
    fi
}

get_decay_emoji() {
    case "$1" in
        hot)     echo "🔥" ;;
        warm)    echo "🟢" ;;
        cooling) echo "🟡" ;;
        cold)    echo "🔴" ;;
        dormant) echo "⚪" ;;
    esac
}

format_age() {
    local age=$1
    if [[ $age -lt 60 ]]; then
        echo "${age}s ago"
    elif [[ $age -lt 3600 ]]; then
        echo "$((age / 60))m ago"
    elif [[ $age -lt 86400 ]]; then
        echo "$((age / 3600))h ago"
    else
        echo "$((age / 86400))d ago"
    fi
}

# Arrays for grouping
declare -a hot_tracks warm_tracks cooling_tracks cold_tracks dormant_tracks

# Scan tracks
for file in "$TRACKS_DIR"/*.md; do
    [[ -f "$file" ]] || continue
    [[ "$(basename "$file")" == "INDEX.md" ]] && continue

    filename=$(basename "$file" .md)
    mtime=$(stat -f %m "$file" 2>/dev/null || stat -c %Y "$file" 2>/dev/null)
    age=$((now - mtime))
    status=$(get_decay_status "$mtime")
    emoji=$(get_decay_emoji "$status")
    age_str=$(format_age "$age")

    # Extract title from filename (YYMMDDHHMM-title)
    title="${filename#*-}"

    entry="$emoji $title ($age_str)"

    case "$status" in
        hot)     hot_tracks+=("$entry") ;;
        warm)    warm_tracks+=("$entry") ;;
        cooling) cooling_tracks+=("$entry") ;;
        cold)    cold_tracks+=("$entry") ;;
        dormant) dormant_tracks+=("$entry") ;;
    esac
done

# Output
echo "# Tracks ($(date '+%H:%M'))"
echo ""
echo "> 🔥 Hot (<1h) | 🟢 Warm (<24h) | 🟡 Cooling (1-7d) | 🔴 Cold (>7d) | ⚪ Dormant (>30d)"
echo ""

print_group() {
    local name=$1
    shift
    local -a tracks=("$@")

    if [[ ${#tracks[@]} -gt 0 ]]; then
        echo "## $name"
        for track in "${tracks[@]}"; do
            echo "- $track"
        done
        echo ""
    fi
}

print_group "🔥 Hot" "${hot_tracks[@]}"
print_group "🟢 Warm" "${warm_tracks[@]}"
print_group "🟡 Cooling" "${cooling_tracks[@]}"
print_group "🔴 Cold" "${cold_tracks[@]}"
print_group "⚪ Dormant" "${dormant_tracks[@]}"

total=$((${#hot_tracks[@]} + ${#warm_tracks[@]} + ${#cooling_tracks[@]} + ${#cold_tracks[@]} + ${#dormant_tracks[@]}))
if [[ $total -eq 0 ]]; then
    echo "No tracks. Use /jump [topic] to start one."
fi
