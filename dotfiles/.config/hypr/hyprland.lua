
-- HYPRLAND CONFIGURATION --



--[[    # ======== #
        # MONITORS #
        # ======== #    ]]

-- ULTRAWIDE (21:9) MONITOR CENTER
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "3440x1440", -- ? "3440x1440@144"
    position = "0x0",
    scale    = "1",
})

-- 16:9 MONITOR TO THE LEFT
hl.monitor({
    output   = "HDMI-A-2",
    mode     = "1920x1080", -- ? "1920x1080@60"
    position = "-1920x0",
    scale    = "1",
})



--[[    # =========== #
        # UPON LAUNCH #
        # =========== #     ]]

hl.on("hyprland.start", function () 

    -- HYPRLAND STARTUP SEQUENCE
    hl.exec_cmd("copyq --start-server")
    hl.exec_cmd("dunst")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("${HOME}/.config/hypr/scripts/xdg-portal-hyprland")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")

    -- AUTOSTART PROGRAMS
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprshade")
    hl.exec_cmd("mullvad connect")                          -- instead of launching mullvad-gui, establish a connection via cli command (turn on or off via waybar)

    -- SET CURSOR THEME 
    hl.exec_cmd("hyprctl setcursor Vimix-cursors 36")       -- (maybe move to "env vars" section?)

end)



--[[    # ========= #
        # VARIABLES #
        # ========= #       ]]

-- "DEFAULT PROGRAMS"
local term      = "kitty"
local files     = "nautilus"
local browser   = "firefox"
local code      = "code"
local pw        = "bitwarden-desktop"

-- UTILS
local lockscreen                    = "hyprlock"
local rofi                          = "killall rofi || rofi -show drun -theme ~/.config/rofi/rofi.conf"
local screenshot_selected_region    = "mkdir -p ~/Pictures/Screenshots && hyprshot -m region -o ~/Pictures/Screenshots -f 'screenshot-'$(date +%Y%m%d-%H%M%S).png"
local next_keyboard_layout          = "hyprctl switchxkblayout current next"

-- SCRIPTS
local next_wallpaper                = "${HOME}/.config/hypr/scripts/next-wallpaper-and-colorscheme"
local sync_config_folders           = "${HOME}/.config/hypr/scripts/sync-config-folders"



--[[    # ============= #
        # LOOK AND FEEL #
        # ============= #       ]]

hl.config({

    -- ##################### --
    -- GAPS, BORDER, GENERAL --
    -- ##################### --

    general = {
        gaps_in  = 5,
        gaps_out = 9,

        border_size = 7,
        resize_on_border = false,           -- resize windows by clicking and dragging on borders and gaps (off, resizing done with SUPER key instead)
        col = {
            active_border   = 0x05ffffff,
            inactive_border = 0x37373737
        },

        allow_tearing = false,
        layout = "dwindle",
    },

    -- ################## --
    -- WINDOW DECORATIONS --
    -- ################## --

    decoration = {

        -- ROUNDING
        rounding       = 0,

        -- OPACITY
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,
        
        -- SHADOW
        shadow = {
            enabled      = true,
            offset       = { 0, 0 },
            range        = 17,
            render_power = 4,
            color        = 0xff000000,
        },

        -- BLUR
        blur = {
            enabled   = true,
            size      = 5,
            passes    = 3,
            new_optimizations = true,
            ignore_opacity = false,
            popups = true
        },
    },

    animations = {
        enabled = true,
    },
})



hl.bind("SHIFT + SUPER + right",    hl.dsp.window.resize({ x = 10, y = 0, relative = true}), { repeating = true })
hl.bind("SHIFT + SUPER + left",     hl.dsp.window.resize({ x = -10, y = 0, relative = true}), { repeating = true })

--[[    # ========= #
        # ANIMATION #
        # ========= #       ]]

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



--[[    # ======= #
        # LAYOUTS #
        # ======= #       ]]

-- DWINDLE LAYOUT 
hl.config({
    dwindle = {
        preserve_split = true,      -- You probably want this
        smart_split = true,         -- (experimental, maybe turn off again)
    },
})

-- MASTER LAYOUT
hl.config({
    master = {
        new_status = "master",
    },
})

-- SCROLLING LAYOUT
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})



--[[    # ==== #
        # MISC #
        # ==== #       ]]

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,     -- If true disables the random hyprland logo / anime girl background. :(
    },
})



--[[    # ===== #
        # INPUT #
        # ===== #       ]]

hl.config({
    input = {
        kb_layout  = "us,de",
        follow_mouse = 2,
        sensitivity = -1 , -- -1.0 - 1.0, 0 means no modification.
    },
})



--[[    # =============================== #
        # BINDS: PROGRAMS, UTILS, SCRIPTS #
        # =============================== #       ]]

-- LAUNCH PROGRAMS
hl.bind("SUPER + Q", hl.dsp.exec_cmd(term))
hl.bind("SUPER + W", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + E", hl.dsp.exec_cmd(files))
hl.bind("SUPER + C", hl.dsp.exec_cmd(code))
hl.bind("SUPER + B", hl.dsp.exec_cmd(pw))

-- UTILS
hl.bind("SUPER + L", hl.dsp.exec_cmd(lockscreen))
hl.bind("SUPER + Space", hl.dsp.exec_cmd(rofi))
hl.bind("CTRL + Space", hl.dsp.exec_cmd(screenshot_selected_region))
hl.bind("SUPER + ALT + Space", hl.dsp.exec_cmd(next_keyboard_layout))

-- SCRIPTS
hl.bind("CTRL + ALT + N", hl.dsp.exec_cmd(next_wallpaper))
--hl.bind("CTRL + ALT + U", hl.dsp.exec_cmd(sync_config_folders))



--[[    # ===================================== #
        # BINDS: WORKSPACES & WINDOW MANAGEMENT #
        # ===================================== #        ]]

-- WINDOW MANAGEMENT
hl.bind("ALT + Space", hl.dsp.window.float({ action = "toggle" }))
local closeWindowBind = hl.bind("SUPER + S", hl.dsp.window.close())
--closeWindowBind:set_enabled(false)

-- SWITCH FOCUSED WINDOW
hl.bind("SUPER + left",  hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up",    hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down",  hl.dsp.focus({ direction = "down" }))

-- RESIZE WINDOW
hl.bind("SHIFT + SUPER + right",    hl.dsp.window.resize({ x = 10, y = 0, relative = true}), { repeating = true })
hl.bind("SHIFT + SUPER + left",     hl.dsp.window.resize({ x = -10, y = 0, relative = true}), { repeating = true })
hl.bind("SHIFT + SUPER + up",       hl.dsp.window.resize({ x = 0, y = 10, relative = true}), { repeating = true })
hl.bind("SHIFT + SUPER + down",     hl.dsp.window.resize({ x = 0, y = -10, relative = true}), { repeating = true })

-- MOVE AND RESIZE WINDOWS WITH MOUSE BUTTONS
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- SWITCH WORKSPACE AND MOVE WINDOW TO WORKSPACE (1-10)
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind("SUPER + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind("SUPER + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- SCROLL THROUGH WORKSPACES
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))



--[[    # ============ #
        # WINDOW RULES #
        # ============ #        ]]

-- Ignore maximize requests from all apps. You'll probably like this.
local suppressMaximizeRule = hl.window_rule({
    
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
--suppressMaximizeRule:set_enabled(false)

-- Fix some dragging issues with XWayland
hl.window_rule({
    
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



--[[    # =========== #
        # LAYER RULES #
        # =========== #        ]]

hl.layer_rule({
    name = "rofi-anim-slide",
    match = { namespace = "rofi" },

    animation   = "slide",
})