#!/bin/bash

# Stop waybar process
killall waybar 2>/dev/null

# Wait for it to properly shut down (optional but recommended)
sleep 1

# Start waybar in the background
waybar & disown

