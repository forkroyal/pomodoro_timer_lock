#!/bin/bash
echo "Pomodoro is starting!"
read -p "How long do you want to work (in minutes) [Press Enter for 30]: " MINUTES
MINUTES=${MINUTES:-30}

# Validate input with decimals allowed
if ! [[ "$MINUTES" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
    echo "Invalid input. Please enter a number."
    exit 1
fi

# Calculate remaining seconds (float to int)
REMAINING=$(echo "$MINUTES * 60" | bc)
REMAINING=${REMAINING%.*} # Remove decimal part if any

echo "Starting Pomodoro for $MINUTES minutes..."

while [ $REMAINING -gt 0 ]; do
    mins=$((REMAINING / 60))
    secs=$((REMAINING % 60))

    # Overwrite the same line
    printf "\rTime left: %02d:%02d" "$mins" "$secs"
    sleep 6
    REMAINING=$((REMAINING - 6))
done

echo -e "\\nTime's up! Locking screen..."
loginctl lock-session
