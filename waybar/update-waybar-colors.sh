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

#Restart waybar
killall waybar 2>/dev/null
waybar &
