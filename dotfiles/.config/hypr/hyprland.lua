
-- HYPRLAND CONFIGURATION --



require("hyprland/monitors")
require("hyprland/programs_and_utils")



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



require("hyprland/looks")
require("hyprland/animations")



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



require("hyprland/binds")



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