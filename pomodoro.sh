#!/bin/bash

echo "Pomodoro is starting!"
# Inform the user about default
read -p "How long do you want to work (in minutes) [Press Enter for 30]: " MINUTES

# Default to 30 minutes if user just presses Enter
MINUTES=${MINUTES:-30}

# Validate input (must be a number)
if ! [[ "$MINUTES" =~ ^[0-9]+$ ]]; then
    echo "Invalid input. Please enter a number."
    exit 1
fi

REMAINING=$((MINUTES * 60))
echo "Starting Pomodoro for $MINUTES minutes..."

while [ $REMAINING -gt 0 ]; do
    mins=$((REMAINING / 60))
    secs=$((REMAINING % 60))
    # Overwrite the same line
    printf "\rTime left: %02d:%02d" "$mins" "$secs"
    sleep 10
    REMAINING=$((REMAINING - 1))
done

# Move to new line before final message
echo -e "\nTime's up! Locking screen..."
loginctl lock-session
