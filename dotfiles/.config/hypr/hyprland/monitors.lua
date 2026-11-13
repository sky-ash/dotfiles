--[[    # ======== #
        # MONITORS #
        # ======== #    ]]

-- ULTRAWIDE (21:9) MONITOR CENTER
hl.monitor({
    --output   = "HDMI-A-1",
    output   = "DP-1",
    mode     = "3440x1440@99.99", -- ? "3440x1440@144"
    position = "0x0",
    scale    = 1,
    transform = 0, -- set to 2 for 180 degree rotation (upside down mounted monitors) (beware this only affects hyprland sessions; grub menu, login screen and tty's will still be upside down) (1 and 3 are for vertically mounted monitors)
})

-- 16:9 MONITOR TO THE... 
hl.monitor({
    --output   = "HDMI-A-2",
    output   = "DP-2",
    mode     = "1920x1080@59.96", -- ? "1920x1080@60"
    --position = "3440x0",    -- RIGHT
    position = "-1080x0",   -- LEFT
    scale    = 1,
    transform = 3,
})