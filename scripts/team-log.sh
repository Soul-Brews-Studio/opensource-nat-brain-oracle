#!/bin/bash

# team-log.sh - Helper script for /bm and /ampere team commands
# Usage: ./team-log.sh [person] [type] [content]
# Example: ./team-log.sh bm schedule "Jan 5 10:00 Meeting"
# Example: ./team-log.sh ampere buy "นม ไข่"

set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Parse arguments
if [ $# -lt 3 ]; then
    echo -e "${RED}Error: Missing arguments${NC}"
    echo ""
    echo "Usage: ./team-log.sh [person] [type] [content]"
    echo ""
    echo "Persons: bm, ampere"
    echo "Types: schedule, request, note, remind, buy"
    echo ""
    echo "Examples:"
    echo "  ./team-log.sh bm schedule \"Jan 5 10:00 Meeting\""
    echo "  ./team-log.sh bm request \"review PR #123\""
    echo "  ./team-log.sh ampere buy \"นม ไข่ ขนมปัง\""
    echo "  ./team-log.sh ampere schedule \"Dec 25 visit mom\""
    echo ""
    exit 1
fi

PERSON="$1"
TYPE="$2"
CONTENT="$3"

# Validate person
if [ "$PERSON" != "bm" ] && [ "$PERSON" != "ampere" ]; then
    echo -e "${RED}Error: Unknown person '$PERSON'${NC}"
    echo "Allowed: bm, ampere"
    exit 1
fi

# Validate type
case "$TYPE" in
    schedule|request|note|remind|buy)
        ;;
    *)
        echo -e "${RED}Error: Unknown type '$TYPE'${NC}"
        echo "Allowed: schedule, request, note, remind, buy"
        exit 1
        ;;
esac

# Check if 'buy' type is used with non-ampere person
if [ "$TYPE" = "buy" ] && [ "$PERSON" != "ampere" ]; then
    echo -e "${YELLOW}Warning: 'buy' type is typically used with /ampere${NC}"
fi

# Get current time (GMT+7)
# Note: This is a simplified version. For true GMT+7, would need TZ=Asia/Bangkok
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M')
TIMESTAMP_DISPLAY=$(date '+%Y-%m-%d %H:%M')

# Create log directory if needed
LOG_DIR="$REPO_ROOT/ψ/team/$PERSON/logs"
mkdir -p "$LOG_DIR"

# Create log filename
LOG_FILE="$LOG_DIR/${TIMESTAMP}_${TYPE}.md"

# Avoid filename collisions
COUNTER=1
ORIGINAL_LOG_FILE="$LOG_FILE"
while [ -f "$LOG_FILE" ]; do
    LOG_FILE="${ORIGINAL_LOG_FILE%_${TYPE}.md}_${TYPE}-${COUNTER}.md"
    ((COUNTER++))
done

# Determine status and priority based on type
case "$TYPE" in
    schedule)
        STATUS="pending"
        ;;
    request|remind)
        STATUS="pending"
        ;;
    note)
        STATUS="logged"
        ;;
    buy)
        STATUS="pending"
        ;;
esac

# Format person name for display
case "$PERSON" in
    bm)
        PERSON_DISPLAY="BM"
        PRIORITY="Normal"
        ;;
    ampere)
        PERSON_DISPLAY="Ampere"
        PRIORITY="High"
        ;;
esac

# Proper title case for type
case "$TYPE" in
    schedule)
        TYPE_TITLE="Schedule"
        ;;
    request)
        TYPE_TITLE="Request"
        ;;
    note)
        TYPE_TITLE="Note"
        ;;
    remind)
        TYPE_TITLE="Reminder"
        ;;
    buy)
        TYPE_TITLE="Shopping"
        ;;
esac

# Create log file
cat > "$LOG_FILE" << LOGEOF
# ${TYPE_TITLE}: ${CONTENT}

**From**: ${PERSON_DISPLAY}
**Time**: ${TIMESTAMP_DISPLAY} (GMT+7)
**Type**: ${TYPE}
**Status**: ${STATUS}
**Priority**: ${PRIORITY}

---

${CONTENT}

---

*Logged via /${PERSON} command*
LOGEOF

# Output confirmation
echo -e "${GREEN}Log created successfully!${NC}"
echo ""
echo -e "${BLUE}Details:${NC}"
echo "  Person:  $PERSON_DISPLAY"
echo "  Type:    $TYPE"
echo "  Time:    $TIMESTAMP_DISPLAY"
echo "  Priority: $PRIORITY"
echo "  Path:    ${LOG_FILE#$REPO_ROOT/}"
echo ""

# If schedule type, suggest adding to schedule.md
if [ "$TYPE" = "schedule" ]; then
    echo -e "${YELLOW}Reminder: Add this to ψ/inbox/schedule.md${NC}"
    echo "  (via ${PERSON_DISPLAY})"
    echo ""
fi

# If request type, suggest following up
if [ "$TYPE" = "request" ] || [ "$TYPE" = "remind" ]; then
    echo -e "${YELLOW}Note: This is marked as pending - needs action${NC}"
    echo ""
fi

exit 0
