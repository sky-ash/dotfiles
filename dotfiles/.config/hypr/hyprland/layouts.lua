--[[    # ======= #
        # LAYOUTS #
        # ======= #       ]]

-- DWINDLE LAYOUT 
hl.config({
    dwindle = {
        preserve_split = true,      -- You probably want this
        --smart_split = true,         -- (experimental, maybe turn off again)
        smart_resizing = false,
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