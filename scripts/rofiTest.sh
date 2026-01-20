#!/bin/bash

# Rofi Wallpaper Picker Script
# Dependencies: rofi, wal (optional), hyprpaper

# Set your wallpaper directory and hyprpaper config path
hyprpaper_conf="$HOME/.config/hypr/hyprpaper.conf"
wallpaper_dir="$HOME/dotfiles/Wallpapers"

# Change to the wallpaper directory
cd "$wallpaper_dir" || exit 1

# Show wallpaper options in rofi with image icons
SELECTED_WALL=$(for a in *.jpg *.png; do 
    echo -en "$a\0icon\x1f$wallpaper_dir/$a\n"
done | rofi -dmenu -show-icons -p "Select wallpaper")

# If wallpaper selected
if [[ -n "$SELECTED_WALL" ]]; then
    selected_path="$wallpaper_dir/$SELECTED_WALL"

    #Reset Pywal colors
    wal -i $selected_path -n --backend xres 

    # Overwrite hyprpaper config
   # echo "preload = $selected_path" > "$hyprpaper_conf"
   cat <<EOF > "$hyprpaper_conf"
  wallpaper {
    monitor = eDP-1
    path = $selected_path
    fit_mode = cover
  }
EOF

    # Restart Hyprpaper to apply new config
    pkill hyprpaper
    sleep 0.5
    hyprpaper & disown
else
    echo "No wallpaper selected."
fi

#Source pywal colors
source ~/.cache/wal/colors.sh

#Update only the @define color line in the existing CSS file
sed -i "s/@define-color backgroundlight #[A-Fa-f0-9]*;/@define-color backgroundlight ${color0};/" ~/.config/waybar/style.css
sed -i "s/@define-color backgrounddark #[A-Fa-f0-9]*;/@define-color backgrounddark ${background};/" ~/.config/waybar/style.css
sed -i "s/@define-color workspacesbackground1 #[A-Fa-f0-9]*;/@define-color workspacesbackground1 ${color1};/" ~/.config/waybar/style.css
sed -i "s/@define-color workspacesbackground2 #[A-Fa-f0-9]*;/@define-color workspacesbackground2 ${color2};/" ~/.config/waybar/style.css
sed -i "s/@define-color bordercolor #[A-Fa-f0-9]*;/@define-color bordercolor ${color3};/" ~/.config/waybar/style.css
sed -i "s/@define-color textcolor1 #[A-Fa-f0-9]*;/@define-color textcolor1 ${foreground};/" ~/.config/waybar/style.css
sed -i "s/@define-color textcolor2 #[A-Fa-f0-9]*;/@define-color textcolor2 ${foreground};/" ~/.config/waybar/style.css
sed -i "s/@define-color textcolor3 #[A-Fa-f0-9]*;/@define-color textcolor3 ${background};/" ~/.config/waybar/style.css
sed -i "s/@define-color iconcolor #[A-Fa-f0-9]*;/@define-color iconcolor ${color4};/" ~/.config/waybar/style.css



# Helper: ensure colors are in rgba() format with full opacity
to_rgba() {
    local hex="${1#\#}"   # remove #
    printf "rgba(%d,%d,%d,1.0)" 0x${hex:0:2} 0x${hex:2:2} 0x${hex:4:2}
}

# Apply with solid (non-transparent) colors
hyprctl keyword general:col.active_border "$(to_rgba "$color1") $(to_rgba "$color2") 45deg"
hyprctl keyword general:col.inactive_border "$(to_rgba "$color8")"

#Restart waybar
killall waybar 2>/dev/null
waybar &

