#!/bin/bash

INTERFACE="wlan0"

# Scan first
iwctl station "$INTERFACE" scan >/dev/null 2>&1
sleep 2

# Get network selection
NETWORK=$(
    iwctl station "$INTERFACE" get-networks \
    | sed -E 's/\x1b\[[0-9;]*[mK]//g' \
    | tail -n +5 \
    | sed 's/^[[:space:]]*>[[:space:]]*//' \
    | rofi -dmenu -i -p "Select Wi-Fi"
)

# User cancelled
[ -z "$NETWORK" ] && exit 0

# Password prompt
PASSPHRASE=$(
    printf '\n' |
    rofi -dmenu \
         -password \
         -p "Password for $NETWORK"
)

# User cancelled
[ -z "$PASSPHRASE" ] && exit 0

# Connect
if iwctl --passphrase "$PASSPHRASE" station "$INTERFACE" connect "$NETWORK"; then
    notify-send "Wi-Fi" "Connected to $NETWORK"
else
    notify-send "Wi-Fi" "Failed to connect to $NETWORK"
fii
