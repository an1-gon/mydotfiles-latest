#!/bin/bash

WALLPAPER_PATH="$HOME/dotfiles/Wallpapers/$1"

# Check if wallpaper file exists
if [ ! -f "$WALLPAPER_PATH" ]; then
    echo "Error: Wallpaper file not found: $WALLPAPER_PATH"
    exit 1
fi

echo "Applying wallpaper: $WALLPAPER_PATH"

# Update hyprpaper configuration
HYPRPAPER_CONFIG="$HOME/.config/hypr/hyprpaper.conf"

# Create or update hyprpaper.conf
cat > "$HYPRPAPER_CONFIG" << EOF
preload = $WALLPAPER_PATH
wallpaper = ,$WALLPAPER_PATH
splash = false
ipc = on
EOF

echo "Hyprpaper config updated!"
# Use hyprctl to change wallpaper without restart (if hyprpaper is already running)
if pgrep hyprpaper > /dev/null; then
    echo "Updating wallpaper via hyprctl..."
    hyprctl hyprpaper preload "$WALLPAPER_PATH"
    hyprctl hyprpaper wallpaper ",$WALLPAPER_PATH"
    echo "Wallpaper updated!"
else
    echo "Starting hyprpaper..."
    hyprpaper > /tmp/hyprpaper.log 2>&1 &
    echo "Hyprpaper started with new wallpaper!"
fi


#Reset wallpaper pass the new wallpaper as a arg
wal -i ~/dotfiles/Wallpapers/"$WALLPAPER_PATH" --backend wal

# Kitty reads from ~/.cache/wal/colors-kitty.conf — just reload the config:
kitty @ set-colors -a ~/.cache/wal/colors-kitty.conf

#Update waybar script 
~/.config/waybar/update-waybar-colors.sh

