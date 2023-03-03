local wezterm = require 'wezterm'

local M = {
    -- Useful default binds:
    -- Ctrl + Shift + x => ActivateCopyMode
    -- Ctrl + Shift + z => TogglePaneZoomState
    -- Ctrl + Shift + space => QuickSelect
    keys = {
        {key = 'f', mods = 'CTRL', action = wezterm.action.TogglePaneZoomState},
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
        }, {
            key = 'h',
            mods = 'SHIFT|ALT',
            action = wezterm.action.AdjustPaneSize {"Left", 1}
        }, {
            key = 'l',
            mods = 'SHIFT|ALT',
            action = wezterm.action.AdjustPaneSize {"Right", 1}
        }, {
            key = 'j',
            mods = 'SHIFT|ALT',
            action = wezterm.action.AdjustPaneSize {"Down", 1}
        }, {
            key = 'k',
            mods = 'SHIFT|ALT',
            action = wezterm.action.AdjustPaneSize {"Up", 1}
        },
        {
            key = 'h',
            mods = 'ALT',
            action = wezterm.action.ActivatePaneDirection 'Left'
        }, {
            key = 'l',
            mods = 'ALT',
            action = wezterm.action.ActivatePaneDirection 'Right'
        },
        {
            key = 'j',
            mods = 'ALT',
            action = wezterm.action.ActivatePaneDirection 'Down'
        },
        {
            key = 'k',
            mods = 'ALT',
            action = wezterm.action.ActivatePaneDirection 'Up'
        },
        {
            key = 't',
            mods = 'CTRL',
            action = wezterm.action.SpawnTab 'DefaultDomain'
        }
    }
}

return M
