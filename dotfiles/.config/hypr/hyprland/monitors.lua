--[[    # ======== #
        # MONITORS #
        # ======== #    ]]

-- ULTRAWIDE (21:9) MONITOR CENTER
hl.monitor({
    output   = "DP-1",
    mode     = "3440x1440@99.99",
    position = "0x0",
    scale    = 1,
    transform = 0,
    bitdepth = 10,
})

-- 16:9 MONITOR CENTERED ABOVE  
hl.monitor({
    output   = "DP-2",
    mode     = "1920x1080@59.88",
    position = "440x-1440",
    scale    = 0.75,
    transform = 2,
    bitdepth = 10,
})
