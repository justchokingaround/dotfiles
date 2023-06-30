local M = {}
local wezterm = require 'wezterm'

local function update_right_status(window)
    -- "Wed Mar 3 08:14"
    --- @type string
    local date = wezterm.strftime '%a %b %-d %H:%M'

    window:set_right_status(wezterm.format {Text = date})
end

function M.enable() wezterm.on('update-right-status', update_right_status) end

return M
