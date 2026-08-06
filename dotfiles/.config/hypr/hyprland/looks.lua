--[[    # ============= #
        # LOOK AND FEEL #
        # ============= #       ]]

local wal = require("hyprland/colors")


local active_col   = 0x05ffffff   -- fallback if wal cache missing
local inactive_col = 0x37373737

if wal.raw then
    active_col   = wal.rgba(wal.raw[1], "ee")  -- color1, ~85% opacity
    inactive_col = wal.rgba(wal.raw[0], "aa")  -- color0 (bg), ~67% opacity
end

hl.config({

    -- ##################### --
    -- GAPS, BORDER, GENERAL --
    -- ##################### --

    general = {
        gaps_in  = 3,
        gaps_out = 7,

        border_size = 2,
        resize_on_border = false,           -- resize windows by clicking and dragging on borders and gaps (off, resizing done with SUPER key instead)
        col = {
            active_border   = active_col,
            inactive_border = inactive_col
        },

        allow_tearing = false,
        layout = "dwindle",
    },

    -- ################## --
    -- WINDOW DECORATIONS --
    -- ################## --

    decoration = {

        -- ROUNDING
        rounding       = 13,

        -- OPACITY
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,
        
        -- SHADOW
        shadow = {
            enabled      = true,
            offset       = { 0, 0 },
            range        = 7,
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