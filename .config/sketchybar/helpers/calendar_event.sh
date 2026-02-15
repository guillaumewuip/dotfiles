#!/bin/bash

# Get current or next calendar event from icalPal
# Returns: "title|sseconds|eseconds|status" or "NO_EVENT"
# Status: "current" if event is happening now, "upcoming" if event is in the future
# Note: Using sseconds/eseconds (Unix timestamps) instead of start_date/end_date

ICALPAL="/opt/homebrew/bin/icalPal"

# First try to get current event
CURRENT=$($ICALPAL eventsNow -o json --li=1 --ea 2>/dev/null)

if [ "$(echo "$CURRENT" | jq 'length')" -gt 0 ]; then
    # Event is happening now
    echo "$CURRENT" | jq -r '.[0] | "\(.title)|\(.sseconds)|\(.eseconds)|current"'
    exit 0
fi

# No current event, get next upcoming event
UPCOMING=$($ICALPAL eventsRemaining -n -o json --li=1 --ea 2>/dev/null)

if [ "$(echo "$UPCOMING" | jq 'length')" -gt 0 ]; then
    # Event is upcoming
    echo "$UPCOMING" | jq -r '.[0] | "\(.title)|\(.sseconds)|\(.eseconds)|upcoming"'
    exit 0
fi

# No events
echo "NO_EVENT"
