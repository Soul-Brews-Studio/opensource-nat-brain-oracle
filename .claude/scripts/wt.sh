#!/bin/bash
#
# wt.sh - Git Worktree Display Script
#
# Displays git worktree list as a formatted table with current location highlighting.
# Used by /wt slash command for quick worktree overview.
#
# Features:
#   - Parse git worktree output
#   - Format as table (Worktree, Branch, Commit columns)
#   - Mark current directory with HERE indicator
#   - Color output for better readability
#
# Usage:
#   .claude/scripts/wt.sh [options]
#
# Options:
#   -h, --help     Show this help message
#   -n, --no-color Disable color output
#   -s, --short    Show short paths (relative to repo root)
#   -v, --verbose  Show additional worktree information
#
# Author: Claude Code
# Version: 1.0.0
# Compatibility: bash 3.2+ (macOS default)
#

set -uo pipefail
# Note: -e removed because grep returning no match (exit 1) should not abort

# =============================================================================
# Configuration
# =============================================================================

# Colors (ANSI escape codes)
readonly COLOR_RESET='\033[0m'
readonly COLOR_BOLD='\033[1m'
readonly COLOR_GREEN='\033[32m'
readonly COLOR_YELLOW='\033[33m'
readonly COLOR_BLUE='\033[34m'
readonly COLOR_CYAN='\033[36m'
readonly COLOR_DIM='\033[2m'

# Table formatting characters (Unicode box drawing)
readonly CORNER_TL="┌"
readonly CORNER_TR="┐"
readonly CORNER_BL="└"
readonly CORNER_BR="┘"
readonly VERTICAL="│"
readonly HORIZONTAL="─"
readonly T_LEFT="├"
readonly T_RIGHT="┤"
readonly T_TOP="┬"
readonly T_BOTTOM="┴"
readonly CROSS="┼"

# Default settings
USE_COLOR=true
SHORT_PATHS=false
VERBOSE=false

# Global arrays (bash 3.2 compatible - no namerefs)
declare -a WORKTREE_DATA=()
declare -a COL_WIDTHS=(9 6 6 4)  # Worktree, Branch, Commit, HERE

# =============================================================================
# Functions
# =============================================================================

# Print help message
show_help() {
    cat << 'EOF'
wt.sh - Git Worktree Display Script

USAGE:
    wt.sh [OPTIONS]

OPTIONS:
    -h, --help      Show this help message
    -n, --no-color  Disable color output
    -s, --short     Show short paths (relative to repo root)
    -v, --verbose   Show additional worktree information

DESCRIPTION:
    Displays all git worktrees in a formatted table with columns for:
    - Worktree path
    - Branch name
    - Commit hash (short)

    The current directory's worktree is highlighted with a HERE indicator.

EXAMPLES:
    # Basic usage
    wt.sh

    # Show short paths without colors
    wt.sh -n -s

    # Verbose output with full information
    wt.sh -v

EOF
}

# Print colored text if colors are enabled
print_color() {
    local color="$1"
    local text="$2"

    if [[ "$USE_COLOR" == true ]]; then
        printf "${color}%s${COLOR_RESET}" "$text"
    else
        printf "%s" "$text"
    fi
}

# Get the repo root directory
get_repo_root() {
    git rev-parse --show-toplevel 2>/dev/null || echo ""
}

# Get current working directory's worktree
get_current_worktree() {
    git rev-parse --show-toplevel 2>/dev/null || echo ""
}

# Parse git worktree list output and populate WORKTREE_DATA
# Format: path|commit|branch|is_current
parse_worktrees() {
    local current_wt
    current_wt=$(get_current_worktree)

    local repo_root
    repo_root=$(get_repo_root)

    WORKTREE_DATA=()

    while read -r line; do
        [[ -z "$line" ]] && continue

        # Parse format: /path/to/worktree  commit [branch]
        local path commit branch

        # Extract path (first field, ends before the hash)
        path=$(echo "$line" | sed -E 's/^(.+)[[:space:]]+[a-f0-9]+[[:space:]]+\[.+\]$/\1/' | sed 's/[[:space:]]*$//')

        # Extract commit (8 char hex)
        commit=$(echo "$line" | grep -oE '[a-f0-9]{7,}' | head -1)

        # Extract branch (inside brackets)
        branch=$(echo "$line" | grep -oE '\[.+\]' | tr -d '[]')

        # Handle detached HEAD
        if [[ -z "$branch" ]]; then
            branch="(detached)"
        fi

        # Determine if this is current worktree
        local is_current="false"
        if [[ "$path" == "$current_wt" ]]; then
            is_current="true"
        fi

        # Shorten path if requested
        local display_path="$path"
        if [[ "$SHORT_PATHS" == true && -n "$repo_root" ]]; then
            local short="${path#$repo_root}"
            if [[ -z "$short" ]]; then
                display_path="."
            else
                display_path=".${short}"
            fi
        fi

        WORKTREE_DATA+=("${display_path}|${commit}|${branch}|${is_current}")
    done < <(git worktree list 2>/dev/null)
}

# Calculate column widths based on data
calculate_widths() {
    # Start with header widths
    COL_WIDTHS=(9 6 6 4)  # Worktree, Branch, Commit, HERE

    for entry in "${WORKTREE_DATA[@]}"; do
        IFS='|' read -r path commit branch is_current <<< "$entry"

        # Update widths if data is wider
        [[ ${#path} -gt ${COL_WIDTHS[0]} ]] && COL_WIDTHS[0]=${#path}
        [[ ${#branch} -gt ${COL_WIDTHS[1]} ]] && COL_WIDTHS[1]=${#branch}
        [[ ${#commit} -gt ${COL_WIDTHS[2]} ]] && COL_WIDTHS[2]=${#commit}
    done
}

# Print horizontal separator line
print_separator() {
    local left="$1"
    local mid="$2"
    local right="$3"

    printf "%s" "$left"
    for i in 0 1 2 3; do
        local width=$((${COL_WIDTHS[$i]} + 2))
        printf "%${width}s" | tr ' ' "$HORIZONTAL"
        if [[ $i -lt 3 ]]; then
            printf "%s" "$mid"
        fi
    done
    printf "%s\n" "$right"
}

# Print table header
print_header() {
    # Top border
    print_separator "$CORNER_TL" "$T_TOP" "$CORNER_TR"

    # Header row
    printf "%s" "$VERTICAL"
    print_color "$COLOR_BOLD" " $(printf "%-${COL_WIDTHS[0]}s" "Worktree") "
    printf "%s" "$VERTICAL"
    print_color "$COLOR_BOLD" " $(printf "%-${COL_WIDTHS[1]}s" "Branch") "
    printf "%s" "$VERTICAL"
    print_color "$COLOR_BOLD" " $(printf "%-${COL_WIDTHS[2]}s" "Commit") "
    printf "%s" "$VERTICAL"
    print_color "$COLOR_BOLD" " $(printf "%-${COL_WIDTHS[3]}s" "") "
    printf "%s\n" "$VERTICAL"

    # Header separator
    print_separator "$T_LEFT" "$CROSS" "$T_RIGHT"
}

# Print a single table row
print_row() {
    local path="$1"
    local branch="$2"
    local commit="$3"
    local is_current="$4"

    printf "%s" "$VERTICAL"

    # Path column - highlight current worktree
    if [[ "$is_current" == "true" ]]; then
        print_color "$COLOR_GREEN$COLOR_BOLD" " $(printf "%-${COL_WIDTHS[0]}s" "$path") "
    else
        print_color "$COLOR_DIM" " $(printf "%-${COL_WIDTHS[0]}s" "$path") "
    fi
    printf "%s" "$VERTICAL"

    # Branch column - different colors for current vs others
    if [[ "$is_current" == "true" ]]; then
        print_color "$COLOR_CYAN$COLOR_BOLD" " $(printf "%-${COL_WIDTHS[1]}s" "$branch") "
    else
        print_color "$COLOR_BLUE" " $(printf "%-${COL_WIDTHS[1]}s" "$branch") "
    fi
    printf "%s" "$VERTICAL"

    # Commit column - always yellow for visibility
    print_color "$COLOR_YELLOW" " $(printf "%-${COL_WIDTHS[2]}s" "$commit") "
    printf "%s" "$VERTICAL"

    # HERE indicator column
    if [[ "$is_current" == "true" ]]; then
        print_color "$COLOR_GREEN$COLOR_BOLD" " $(printf "%-${COL_WIDTHS[3]}s" "HERE") "
    else
        printf " $(printf "%-${COL_WIDTHS[3]}s" "") "
    fi
    printf "%s\n" "$VERTICAL"
}

# Print table footer
print_footer() {
    print_separator "$CORNER_BL" "$T_BOTTOM" "$CORNER_BR"
}

# Print verbose information about current worktree
print_verbose_info() {
    local current_wt
    current_wt=$(get_current_worktree)

    echo ""
    print_color "$COLOR_BOLD" "Current worktree: "
    print_color "$COLOR_GREEN" "$current_wt"
    echo ""
    echo ""

    # Show git status summary for current worktree
    local status_count
    status_count=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')

    if [[ "$status_count" -gt 0 ]]; then
        print_color "$COLOR_YELLOW" "Warning: "
        echo "$status_count uncommitted change(s) in current worktree"
    else
        print_color "$COLOR_GREEN" "Clean: "
        echo "No uncommitted changes in current worktree"
    fi

    # Show ahead/behind status if tracking branch exists
    local tracking_info
    tracking_info=$(git status -sb 2>/dev/null | head -1 | grep -oE '\[.*\]' || echo "")
    if [[ -n "$tracking_info" ]]; then
        echo ""
        print_color "$COLOR_DIM" "Tracking: "
        echo "$tracking_info"
    fi

    echo ""
}

# Main display function - orchestrates the table rendering
display_worktrees() {
    # Parse worktrees into global array
    parse_worktrees

    # Check if we have any worktrees
    if [[ ${#WORKTREE_DATA[@]} -eq 0 ]]; then
        echo "No worktrees found. Are you in a git repository?"
        exit 1
    fi

    # Calculate optimal column widths
    calculate_widths

    # Print title with count
    echo ""
    print_color "$COLOR_BOLD" "Git Worktrees"
    print_color "$COLOR_DIM" " (${#WORKTREE_DATA[@]} total)"
    echo ""
    echo ""

    # Print the table
    print_header

    for entry in "${WORKTREE_DATA[@]}"; do
        IFS='|' read -r path commit branch is_current <<< "$entry"
        print_row "$path" "$branch" "$commit" "$is_current"
    done

    print_footer
    echo ""

    # Show verbose info if requested
    if [[ "$VERBOSE" == true ]]; then
        print_verbose_info
    fi
}

# =============================================================================
# Argument Parsing
# =============================================================================

parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                show_help
                exit 0
                ;;
            -n|--no-color)
                USE_COLOR=false
                shift
                ;;
            -s|--short)
                SHORT_PATHS=true
                shift
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            *)
                echo "Unknown option: $1"
                echo "Use -h or --help for usage information"
                exit 1
                ;;
        esac
    done
}

# =============================================================================
# Main Entry Point
# =============================================================================

main() {
    # Parse command line arguments
    parse_arguments "$@"

    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not in a git repository"
        exit 1
    fi

    # Check if git worktree is available
    if ! git worktree list > /dev/null 2>&1; then
        echo "Error: git worktree command not available"
        exit 1
    fi

    # Display the worktrees
    display_worktrees
}

# Run main function with all arguments
main "$@"
