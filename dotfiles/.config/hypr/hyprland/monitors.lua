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