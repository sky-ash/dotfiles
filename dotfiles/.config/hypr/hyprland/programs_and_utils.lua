--[[    # ========= #
        # VARIABLES #
        # ========= #       ]]

-- "DEFAULT PROGRAMS"
global term      = "kitty"
global files     = "nautilus"
global browser   = "firefox"
global code      = "code"
global pw        = "bitwarden-desktop"

-- UTILS
global lockscreen                    = "hyprlock"
global rofi                          = "killall rofi || rofi -show drun -theme ~/.config/rofi/rofi.conf"
global screenshot_selected_region    = "mkdir -p ~/Pictures/Screenshots && hyprshot -m region -o ~/Pictures/Screenshots -f 'screenshot-'$(date +%Y%m%d-%H%M%S).png"
global next_keyboard_layout          = "hyprctl switchxkblayout current next"

-- SCRIPTS
global next_wallpaper                = "${HOME}/.config/hypr/scripts/next-wallpaper-and-colorscheme"
global copy_config                   = "${HOME}/.config/hypr/scripts/copyconfig.sh"
