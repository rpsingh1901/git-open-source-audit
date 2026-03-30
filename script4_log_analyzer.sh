#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author: [Your Name] | Roll: [Your Roll Number]
# Course: Open Source Software | Chosen Software: Git
# Purpose: Reads a log file line by line, counts occurrences
#          of a keyword, and prints a summary with matching
#          lines. Demonstrates while-read loop and counters.
# Usage  : ./script4_log_analyzer.sh /var/log/syslog [keyword]
#          Default keyword is 'error' if not specified.
# ============================================================

# --- Accept log file path as first argument ($1) ---
LOGFILE=$1

# --- Accept keyword as second argument; default to 'error' ---
KEYWORD=${2:-"error"}

# --- Counter variable to track matches ---
COUNT=0

# --- Array to store matching lines (for later display) ---
MATCHING_LINES=()

echo "================================================================"
echo "              LOG FILE ANALYZER                                "
echo "================================================================"

# --- Validate: check if a filename was provided ---
if [ -z "$LOGFILE" ]; then
    echo "  ERROR: No log file specified."
    echo "  Usage: $0 /path/to/logfile [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    exit 1
fi

# --- Retry loop: if file doesn't exist, prompt for another path ---
# This demonstrates a do-while style retry pattern in bash
ATTEMPTS=0
MAX_ATTEMPTS=3

while [ ! -f "$LOGFILE" ]; do
    ATTEMPTS=$((ATTEMPTS + 1))
    echo "  WARNING: File '$LOGFILE' not found. (Attempt $ATTEMPTS/$MAX_ATTEMPTS)"

    # Exit if maximum retries reached
    if [ "$ATTEMPTS" -ge "$MAX_ATTEMPTS" ]; then
        echo "  ERROR: Exceeded maximum retry attempts. Exiting."
        exit 1
    fi

    # Ask user for a new path interactively
    read -p "  Enter a valid log file path (or press Ctrl+C to cancel): " LOGFILE
done

echo "  Log File  : $LOGFILE"
echo "  Keyword   : '$KEYWORD' (case-insensitive)"
echo "----------------------------------------------------------------"

# --- Check if the file is empty before processing ---
if [ ! -s "$LOGFILE" ]; then
    echo "  WARNING: Log file is empty. No lines to analyze."
    exit 0
fi

# --- while-read loop: process the log file line by line ---
while IFS= read -r LINE; do
    # if-then: check if this line contains the keyword (case-insensitive)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        # Increment counter
        COUNT=$((COUNT + 1))
        # Store matching line in array (limit to last 5 for display)
        MATCHING_LINES+=("$LINE")
    fi
done < "$LOGFILE"

# --- Report total line count of the file ---
TOTAL_LINES=$(wc -l < "$LOGFILE")

echo ""
echo "  RESULTS:"
echo "  Total lines in file    : $TOTAL_LINES"
echo "  Lines with '$KEYWORD'  : $COUNT"

# --- Calculate percentage of matching lines ---
if [ "$TOTAL_LINES" -gt 0 ]; then
    # Use awk for floating-point percentage calculation
    PERCENT=$(awk "BEGIN { printf \"%.2f\", ($COUNT / $TOTAL_LINES) * 100 }")
    echo "  Match percentage       : $PERCENT%"
fi

echo ""
echo "----------------------------------------------------------------"

# --- Display the last 5 matching lines ---
if [ "$COUNT" -gt 0 ]; then
    echo "  LAST 5 MATCHING LINES (containing '$KEYWORD'):"
    echo "----------------------------------------------------------------"

    # Get the total number of stored matching lines
    TOTAL_MATCHES=${#MATCHING_LINES[@]}

    # Calculate starting index for last 5 (or all if fewer than 5)
    START=$(( TOTAL_MATCHES > 5 ? TOTAL_MATCHES - 5 : 0 ))

    # Loop through and print the last 5 matches
    for (( i=START; i<TOTAL_MATCHES; i++ )); do
        # Truncate long lines to 100 chars for readability
        echo "  ${MATCHING_LINES[$i]}" | cut -c1-100
    done
else
    echo "  No lines containing '$KEYWORD' were found."
fi

echo "================================================================"
