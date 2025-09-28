#!/bin/bash

choice=$(echo -e "Power off\nLock\nLogout" | rofi -dmenu -p "Choose an action")
 if [[ -z "$choice" ]]; then
    exit 0
 fi

if [[ $choice == "Power off" ]]; then
    systemctl poweroff 
elif [[ $choice == "Lock" ]]; then
    hyprlock &> /dev/null
elif [[ $choice == "Logout" ]]; then
    hyprctl dispatch exit
fi

exit 0
