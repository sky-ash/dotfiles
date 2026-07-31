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