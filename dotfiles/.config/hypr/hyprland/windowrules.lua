--[[    # ============ #
        # WINDOW RULES #
        # ============ #        ]]

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

-- qBit Float
hl.window_rule({
    name = "qbit-popup-float",
    match = { class = "org.qbittorrent.qBittorrent" },

    float   = true,
    center  = true,
    size    = { 1700, 720 },
})

-- qBit Main Window Anti-Float
hl.window_rule({
    name = "qbit-popup-anti-float",
    match = { class = "org.qbittorrent.qBittorrent", title = "qBittorrent v5.2.4" }, --  title = "qBittorrent v5.2.4"

    float   = false,
--    center  = true,
--    size    = { 800, 600 },
})

-- Render VCam even if on unfocused workspace
hl.window_rule({
    name = "vcam-render",
    match = { class = "^(steam_app_1325860)$" },

    render_unfocused = true,
    float            = true,
    pin              = true,
    monitor          = 1,
    size             = { 350, 654 },
    move             = { -355, 764 },
})



hl.window_rule({
    name = "DOOOOOOM",
    match = { class = "^(steam_app_379720)$" },

    render_unfocused = false,
    float            = false,
    pin              = false,
    fullscreen       = true,
})
