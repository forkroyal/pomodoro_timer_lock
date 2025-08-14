#!/bin/bash

echo "Pomodoro is starting!"
read -p "How long do you want to work (in minutes)? " MINUTES

# If user pressed Enter with no input, default to 30 minutes
MINUTES=${MINUTES:-30}

# Ensure the input is only numbers
if ! [[ "$MINUTES" =~ ^[0-9]+$ ]]; then
    echo "Invalid input. Please enter a number."
    exit 1
fi

REMAINING=$((MINUTES * 60))
echo "Starting Pomodoro for $MINUTES minutes..."

while [ $REMAINING -gt 0 ]; do
    mins=$((REMAINING / 60))
    secs=$((REMAINING % 60))
    echo "Time left: $(printf "%02d:%02d" $mins $secs)"
    sleep 1
    REMAINING=$((REMAINING - 1))
done

echo "Time's up! Locking screen..."
loginctl lock-session
