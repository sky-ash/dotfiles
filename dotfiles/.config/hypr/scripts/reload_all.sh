# reload wallpaper (next in iteration) and update color-scheme
~/.config/hypr/scripts/next-wallpaper-and-colorscheme

# reloading hyprland config
echo -e "running 'hyprctl reload' to reevaluate hyprland.lua:\n"
hyprctl reload

# restart waybar
echo -e "restarting waybar:\n"
killall waybar
nohup waybar > /dev/null 2>&1 &
echo -e "waybar running.\n"

# reload swaync config and css
swaync-client -R
swaync-client -rs