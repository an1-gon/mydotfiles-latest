#!/usr/bin/env bash

echo ##################################
echo Initiating bluetooth
echo ###################################

choice=$(echo -e "bluetooth pair on\nbluetooth pair off" | rofi -dmenu -p "Choose an action")

echo $choice


