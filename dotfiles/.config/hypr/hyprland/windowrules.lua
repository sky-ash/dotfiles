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