-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


------------------------------------------------------------------


-- # ======== #
-- # MONITORS #
-- # ======== #

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- # CENTER 21:9, LEFT 16:9

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "3440x1440", -- ? "3440x1440@144"
    position = "0x0",
    scale    = "1",
})

hl.monitor({
    output   = "HDMI-A-2",
    mode     = "1920x1080", -- ? "1920x1080@60"
    position = "-1920x0",
    scale    = "1",
})


-- # =========== #
-- # UPON LAUNCH #
-- # =========== #

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function () 
    -- HYPRLAND STARTUP SEQUENCE
    hl.exec_cmd("copyq --start-server")
    hl.exec_cmd("dunst")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("${HOME}/.config/hypr/scripts/xdg-portal-hyprland")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")


    --  # AUTOSTART PROGRAMS
    hl.exec_cmd("waybar")
    hl.exec_cmd("mullvad-vpn") -- (on workspace 10 pls?)
    --hl.exec_cmd("hyprshade")


    -- # SET CURSOR THEME (maybe move to "env vars" section?)
    hl.exec_cmd("hyprctl setcursor Vimix-cursors 36")
end)


---------------------
---- MY PROGRAMS ----
---------------------

-- # ========= #
-- # VARIABLES #
-- # ========= #

-- "DEFAULT PROGRAMS"
local term      = "kitty"
local files     = "nautilus"
local browser   = "firefox"
local code      = "code"
local pw        = "bitwarden-desktop"

-- # UTILS
local lockscreen                    = "hyprlock"
local rofi                          = "killall rofi || rofi -show drun -theme ~/.config/rofi/rofi.conf"
local screenshot_selected_region    = "mkdir -p ~/Pictures/Screenshots && hyprshot -m region -o ~/Pictures/Screenshots -f 'screenshot-'$(date +%Y%m%d-%H%M%S).png"
local next_keyboard_layout          = "hyprctl switchxkblayout current next"

-- # SCRIPTS
local next_wallpaper                = "${HOME}/.config/hypr/scripts/next-wallpaper-and-colorscheme"
local sync_config_folders           = "${HOME}/.config/hypr/scripts/sync-config-folders"





-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

--hl.env("XCURSOR_SIZE", "24")
--hl.env("HYPRCURSOR_SIZE", "24")

--          env = XCURSOR_SIZE, 36
--          env = XCURSOR_THEME, Vimix-cursors
--          env = HYPRCURSOR_SIZE, 36
--          env = HYPRCURSOR_THEME, Vimix-cursors






-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")





-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 9,

        border_size = 7,

        col = {
            active_border   = 0x05ffffff   --{ colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = 0x37373737,
        },

        -- gaps_workspaces = 0

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 0,
        --rounding_power = 2,

        -- OPACITY
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,

        shadow = {
            enabled      = true,
            offset       = 0 0
            range        = 17,
            render_power = 4,
            color        = 0xff000000,
        },

        -- BLUR
        blur = {
            enabled   = true,
            size      = 5,
            passes    = 3,
            --vibrancy  = 0.1696,

            new_optimizations = true
            ignore_opacity = false
            popups = true
        },
    },

    animations = {
        enabled = true,
    },
})



--[[ ALL DEFAULT ANIMATIONS INCL. CURVES AND SPRINGS (from default hyprland.lua)

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })


-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

]]


hl.curve("overshot",    { type = "bezier", points = { {0.05, 0.9},  {0.1, 1.05}     } })
hl.curve("smoothOut",   { type = "bezier", points = { {0.36, 0},    {0.66, -0.56}   } })
hl.curve("smoothIn",    { type = "bezier", points = { {0.25, 1},    {0.5, 1}        } })

hl.animation({ leaf = "windows",        enabled = true,  speed = 5,     bezier = "overshot",    style = "slide" })
hl.animation({ leaf = "windowsOut",     enabled = true,  speed = 4,     bezier = "smoothOut",   style = "slide" })
hl.animation({ leaf = "windowsMove",    enabled = true,  speed = 4,     bezier = "default" })
hl.animation({ leaf = "border",         enabled = true,  speed = 10,    bezier = "default" })
hl.animation({ leaf = "fade",           enabled = true,  speed = 10,    bezier = "smoothIn" })
hl.animation({ leaf = "fadeDim",        enabled = true,  speed = 10,    bezier = "smoothIn" })
hl.animation({ leaf = "workspaces",     enabled = true,  speed = 6,     bezier = "default" })


-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
        smart_split = true, -- (experimental, maybe turn off again)
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 0, -- "-1",    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us,de",
        --kb_variant = "",
        --kb_model   = "",
        --kb_options = "",
        --kb_rules   = "",

        follow_mouse = 2,

        sensitivity = -1 , -- -1.0 - 1.0, 0 means no modification.

        --[[
        touchpad = {
            natural_scroll = false,
        },
        ]]
    },
})

--[[
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})
]]

--[[
-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})
]]


---------------------
---- KEYBINDINGS ----
---------------------

--[[
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

]]



-- # =============================== #
-- # BINDS: PROGRAMS, UTILS, SCRIPTS #
-- # =============================== #


-- # LAUNCH PROGRAMS
hl.bind("SUPER + Q", hl.dsp.exec_cmd(term))
hl.bind("SUPER + W", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + E", hl.dsp.exec_cmd(files))
hl.bind("SUPER + C", hl.dsp.exec_cmd(code))
hl.bind("SUPER + B", hl.dsp.exec_cmd(pw))

-- # UTILS
hl.bind("SUPER + L", hl.dsp.exec_cmd(lockscreen))
hl.bind("SUPER + Space", hl.dsp.exec_cmd(rofi))
hl.bind("CTRL + Space", hl.dsp.exec_cmd(screenshot_selected_region))
hl.bind("SUPER + ALT + Space", hl.dsp.exec_cmd(next_keyboard_layout))

-- # SCRIPTS
hl.bind("CTRL + ALT + N", hl.dsp.exec_cmd(next_wallpaper))
hl.bind("CTRL + ALT + U", hl.dsp.exec_cmd(sync_config_folders))


-- # ================= #
-- # BINDS: MULTIMEDIA #
-- # ================= #

-- #binde = , XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+
-- #binde = , XF86AudioLowerVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-
--binde = Super_R, bracketright, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+     # = , XF86AudioRaiseVolume
--binde = Super_R, bracketleft, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-      # = , XF86AudioLowerVolume
-- #binde = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
-- #bind = , XF86AudioPlay, exec, playerctl play-pause
-- #bind = , XF86AudioPause, exec, playerctl play-pause
-- #bind = , XF86AudioNext, exec, playerctl next
-- #bind = , XF86AudioPrev, exec, playerctl previous


--[[
-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
]]




-- # ===================================== #
-- # BINDS: WORKSPACES & WINDOW MANAGEMENT #
-- # ===================================== #

-- SHUTDOWN
-- hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- # WINDOW MANAGEMENT
hl.bind("ALT + Space", hl.dsp.window.float({ action = "toggle" }))
local closeWindowBind = hl.bind("SUPER + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)

-- # SWITCH FOCUSED WINDOW
hl.bind("SUPER + left",  hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up",    hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down",  hl.dsp.focus({ direction = "down" }))

-- # RESIZE WINDOW
bind = SHIFT SUPER, left, resizeactive, -60 0
bind = SHIFT SUPER, right, resizeactive, 60 0
bind = SHIFT SUPER, up, resizeactive, 0 -60
bind = SHIFT SUPER, down, resizeactive, 0 60

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- # SWITCH WORKSPACE AND MOVE WINDOW TO WORKSPACE (1-10)
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind("SUPER + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind("SUPER + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

--[[
-- Example special workspace (scratchpad)
hl.bind("SUPER + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
]]

--[[
-- Scroll through existing workspaces with mainMod + up/down arrow (must test out, idk)
hl.bind("SUPER + ALT + up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + ALT + down",   hl.dsp.focus({ workspace = "e-1" }))
]]


-- Scroll through existing workspaces with mainMod + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))



--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)





hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})


-- SELECT FILE/FOLDER POP UPS

hl.window_rule({
    name = "openfile-popup",
    match = { title = "Open File" },

    float   = true,
    center  = true,
    size    = { 800, 600 },
})

hl.window_rule({
    name = "openfolder-popup",
    match = { title = "Open Folder" },

    float   = true,
    center  = true,
    size    = { 800, 600 },
})

-- FILE ROLLER FOR ZIP FILES ETC.

hl.window_rule({
    name = "fileroller-popup",
    match = { title = "File Roller" },

    float   = true,
    center  = true,
    size    = { 800, 600 },
})

-- VOLUME CONTROL (PAVUCONTROL)

hl.window_rule({
    name = "pavu-volume-control",
    match = { title = "^(Volume Control)$" },

    float   = true,
    center  = true,
    size    = { 800, 600 },
    move    = "75 monitor_h*0.44",
})


-- FIREFOX PICTURE-IN-PICTURE (POP OUT VIDEOS)

hl.window_rule({
    name = "ff-picture-in-picture",
    match = { class = "^(firefox)$", title = "^(Picture-in-Picture)$" },

    float   = true,
    center  = true,
    size    = { 1280, 720 },
})



-- # =========== #
-- # LAYER RULES #
-- # =========== #

hl.layer_rule({
    name = "rofi-anim-slide",
    match = { namespace = "rofi" },

    animation   = "slide",
})