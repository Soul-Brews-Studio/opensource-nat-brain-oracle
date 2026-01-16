#!/bin/bash
# Jump - Multi-track topic management with time-decay visibility

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BASE_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)/ψ/inbox"
TRACKS_DIR="$BASE_DIR/tracks"
INDEX="$TRACKS_DIR/INDEX.md"
STACK="$BASE_DIR/jump-stack.log"
FOCUS="$BASE_DIR/focus.md"

now() {
    date '+%Y-%m-%d %H:%M'
}

now_short() {
    date '+%H:%M'
}

# Get next track number (NNN format)
next_number() {
    local max=0
    for file in "$TRACKS_DIR"/*.md; do
        [[ -f "$file" ]] || continue
        local filename=$(basename "$file")
        [[ "$filename" == "INDEX.md" ]] && continue
        local num="${filename%%-*}"
        num="${num#0}"  # Remove leading zeros
        num="${num#0}"
        [[ "$num" -gt "$max" ]] && max="$num"
    done
    printf "%03d" $((max + 1))
}

# Calculate time decay status from file mtime
get_status() {
    local filepath="$1"

    # Get file mtime
    local file_epoch
    file_epoch=$(stat -f %m "$filepath" 2>/dev/null)
    if [[ -z "$file_epoch" ]]; then
        echo "?"
        return
    fi

    local now_epoch
    now_epoch=$(date "+%s")
    local age_hours=$(( (now_epoch - file_epoch) / 3600 ))
    local age_days=$(( age_hours / 24 ))

    if [[ $age_hours -lt 1 ]]; then
        echo "Hot"
    elif [[ $age_hours -lt 24 ]]; then
        echo "Warm"
    elif [[ $age_days -lt 7 ]]; then
        echo "Cooling"
    elif [[ $age_days -lt 30 ]]; then
        echo "Cold"
    else
        echo "Dormant"
    fi
}

get_status_emoji() {
    case "$1" in
        Hot) echo "🔥" ;;
        Warm) echo "🟢" ;;
        Cooling) echo "🟡" ;;
        Cold) echo "🔴" ;;
        Dormant) echo "⚪" ;;
        *) echo "❓" ;;
    esac
}

read_focus() {
    if [[ -f "$FOCUS" ]]; then
        grep '^TASK:' "$FOCUS" | cut -d':' -f2- | xargs
    else
        echo "(none)"
    fi
}

write_focus() {
    local task="$1"
    local track_file="$2"
    cat > "$FOCUS" << EOF
STATE: jumped
TASK: $task
TRACK: $track_file
SINCE: $(now_short)
EOF
}

# Regenerate INDEX.md from track files
regenerate_index() {
    local hot=()
    local warm=()
    local cooling=()
    local cold=()
    local dormant=()

    # Scan all track files
    for file in "$TRACKS_DIR"/*.md; do
        [[ -f "$file" ]] || continue
        local filename=$(basename "$file")
        [[ "$filename" == "INDEX.md" ]] && continue

        local status=$(get_status "$file")
        local title="${filename#*-}"        # Remove prefix (NNN-)
        title="${title%.md}"                 # Remove .md
        local prefix="${filename%%-*}"       # Get NNN

        # Extract next action from file
        local next_action
        next_action=$(grep -A1 '^## Next Action' "$file" 2>/dev/null | tail -1 | sed 's/^\[//' | sed 's/\]$//')
        [[ -z "$next_action" || "$next_action" == "## Next Action" ]] && next_action="[Define next step]"

        # Extract last touched
        local last_touched
        last_touched=$(grep '^\*\*Last touched\*\*:' "$file" | cut -d':' -f2- | xargs)
        [[ -z "$last_touched" ]] && last_touched="Unknown"

        local entry="| $title | [$prefix]($filename) | $last_touched | $next_action |"

        case "$status" in
            Hot) hot+=("$entry") ;;
            Warm) warm+=("$entry") ;;
            Cooling) cooling+=("$entry") ;;
            Cold) cold+=("$entry") ;;
            Dormant) dormant+=("$entry") ;;
        esac
    done

    # Write INDEX.md
    cat > "$INDEX" << 'EOF'
# Tracks

> Hot (<1h) | Warm (<24h) | Cooling (1-7d) | Cold (>7d) | Dormant (>30d)

EOF

    # Hot section
    if [[ ${#hot[@]} -gt 0 ]]; then
        echo "## Hot" >> "$INDEX"
        echo "" >> "$INDEX"
        echo "| Track | File | Last touch | Next action |" >> "$INDEX"
        echo "|-------|------|------------|-------------|" >> "$INDEX"
        for entry in "${hot[@]}"; do
            echo "$entry" >> "$INDEX"
        done
        echo "" >> "$INDEX"
    fi

    # Warm section
    if [[ ${#warm[@]} -gt 0 ]]; then
        echo "## Warm" >> "$INDEX"
        echo "" >> "$INDEX"
        echo "| Track | File | Last touch | Next action |" >> "$INDEX"
        echo "|-------|------|------------|-------------|" >> "$INDEX"
        for entry in "${warm[@]}"; do
            echo "$entry" >> "$INDEX"
        done
        echo "" >> "$INDEX"
    fi

    # Cooling section
    if [[ ${#cooling[@]} -gt 0 ]]; then
        echo "## Cooling (need attention?)" >> "$INDEX"
        echo "" >> "$INDEX"
        echo "| Track | File | Last touch | Next action |" >> "$INDEX"
        echo "|-------|------|------------|-------------|" >> "$INDEX"
        for entry in "${cooling[@]}"; do
            echo "$entry" >> "$INDEX"
        done
        echo "" >> "$INDEX"
    fi

    # Cold section
    if [[ ${#cold[@]} -gt 0 ]]; then
        echo "## Cold (forgotten?)" >> "$INDEX"
        echo "" >> "$INDEX"
        echo "| Track | File | Last touch | Next action |" >> "$INDEX"
        echo "|-------|------|------------|-------------|" >> "$INDEX"
        for entry in "${cold[@]}"; do
            echo "$entry" >> "$INDEX"
        done
        echo "" >> "$INDEX"
    fi

    # Dormant section
    if [[ ${#dormant[@]} -gt 0 ]]; then
        echo "## Dormant (archive?)" >> "$INDEX"
        echo "" >> "$INDEX"
        echo "| Track | File | Last touch | Next action |" >> "$INDEX"
        echo "|-------|------|------------|-------------|" >> "$INDEX"
        for entry in "${dormant[@]}"; do
            echo "$entry" >> "$INDEX"
        done
        echo "" >> "$INDEX"
    fi

    # Footer
    cat >> "$INDEX" << 'EOF'
---

*Filename format: NNN-title.md*
*Auto-updated by /jump command*
EOF
}

cmd_list() {
    # Regenerate index first
    regenerate_index

    cat "$INDEX"
    echo ""
    echo "---"
    echo "Current focus: $(read_focus)"
}

cmd_back() {
    if [[ ! -f "$STACK" ]]; then
        echo "Stack empty"
        return 1
    fi

    local prev
    prev=$(grep "| JUMP |" "$STACK" | tail -1 | cut -d'|' -f3 | xargs)

    if [[ -z "$prev" ]]; then
        echo "No JUMP entries"
        return 1
    fi

    echo "$(now) | BACK | $prev" >> "$STACK"
    write_focus "$prev" ""
    echo "Back to: $prev"
}

cmd_jump() {
    local topic="$*"
    local current
    current=$(read_focus)

    # Sanitize topic for filename (lowercase, hyphens)
    local safe_topic
    safe_topic=$(echo "$topic" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-')

    local num
    num=$(next_number)
    local filename="${num}-${safe_topic}.md"
    local filepath="$TRACKS_DIR/$filename"

    # Create track file
    cat > "$filepath" << EOF
# Track: $topic

**Created**: $(now)
**Last touched**: $(now)
**Status**: Hot

---

## Goal

[To be filled]

## Current State

[Starting fresh]

## Next Action

[Define next step]

## Context

[Links, issues, notes]
EOF

    # Push current to stack
    echo "$(now) | JUMP | $current" >> "$STACK"

    # Update focus with track reference
    write_focus "$topic" "$filename"

    # Regenerate index
    regenerate_index

    echo "Created track: $filename"
    echo "Focus: $topic"
    echo ""
    echo "Edit: $filepath"
}

# Main
ACTION="${1:-}"

case "$ACTION" in
    ""|list)
        cmd_list
        ;;
    back)
        cmd_back
        ;;
    *)
        cmd_jump "$@"
        ;;
esac
