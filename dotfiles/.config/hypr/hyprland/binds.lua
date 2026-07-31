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

-- MOVE AND RESIZE WINDOWS WITH ARROW KEYS
hl.bind("SHIFT + SUPER + right",    hl.dsp.window.resize({ x = 10, y = 0, relative = true}), { repeating = true })
hl.bind("SHIFT + SUPER + left",     hl.dsp.window.resize({ x = -10, y = 0, relative = true}), { repeating = true })

-- SWITCH WORKSPACE AND MOVE WINDOW TO WORKSPACE (1-10)
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind("SUPER + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind("SUPER + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- SCROLL THROUGH WORKSPACES
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))