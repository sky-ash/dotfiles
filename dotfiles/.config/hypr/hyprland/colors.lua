-- colors.lua — reads pywal's plain color list into a table indexed 0-15
local M = {}

local function hex_to_rgba(hex, alpha)
    alpha = alpha or "ee"
    hex = hex:gsub("#", "")
    return "rgba(" .. hex .. alpha .. ")"
end

local function load_wal()
    local home = os.getenv("HOME")
    local f = io.open(home .. "/.cache/wal/colors", "r")
    if not f then return nil end

    local c = {}
    local i = 0
    for line in f:lines() do
        c[i] = line:gsub("%s+", "")
        i = i + 1
    end
    f:close()
    return c
end

M.raw = load_wal()
M.rgba = hex_to_rgba

return M