local wezterm = require 'wezterm'

local M = {
    keys = {
        {
            key = 'n',
            mods = 'ALT',
            action = wezterm.action.SplitHorizontal {
                domain = 'CurrentPaneDomain'
            }
        }, {
            key = 'n',
            mods = 'SHIFT|ALT',
            action = wezterm.action.SplitVertical {domain = 'CurrentPaneDomain'}
        }
    }
}

return M
