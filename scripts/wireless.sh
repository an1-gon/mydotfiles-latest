#!/bin/bash

iwctl station wlan0 scan

echo "Scanning for Wireless Networks...."

sleep 0.5
 
# Get list of networks (skip header line)
NETWORK=$(iwctl station wlan0 get-networks | awk 'NR>4 {print $1}' | fzf --prompt="Select Wi-Fi: ")

# Exit if no network was chosen
[ -z "$NETWORK" ] && echo "No network selected." && exit 1

# Takes in password input -s flag is used to keep input from being printed to echo.
#read command does not print to STDOUT it just takes the input and pass to variable passed as a ARG
read -s -p "Enter passphrase for ${NETWORK}: " PASSPHRASE

#Echo is used to create a new line
echo 

# Connect
echo "$PASSPHRASE" | iwctl station wlan0 connect "${NETWORK}"

# Show status
iwctl station wlan0 show

