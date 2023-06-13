local wezterm = require("wezterm")

local M = {
	-- Useful default binds:
	-- Ctrl + Shift + x => ActivateCopyMode
	-- Ctrl + Shift + z => TogglePaneZoomState
	-- Ctrl + Shift + space => QuickSelect
	-- Ctrl + Shift + p => CommandPalette
	keys = {
		{ key = "f", mods = "CTRL|SHIFT", action = wezterm.action.TogglePaneZoomState },
		{
			key = "n",
			mods = "ALT",
			action = wezterm.action.SplitHorizontal({
				domain = "CurrentPaneDomain",
			}),
		},
		{
			key = "n",
			mods = "SHIFT|ALT",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "w",
			mods = "ALT",
			action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
		},
		{
			key = "t",
			mods = "CTRL",
			action = wezterm.action.SpawnTab("DefaultDomain"),
		},
		{
			key = "h",
			mods = "SHIFT|ALT",
			action = wezterm.action.AdjustPaneSize({ "Left", 2 }),
		},
		{
			key = "l",
			mods = "SHIFT|ALT",
			action = wezterm.action.AdjustPaneSize({ "Right", 2 }),
		},
		{
			key = "j",
			mods = "SHIFT|ALT",
			action = wezterm.action.AdjustPaneSize({ "Down", 2 }),
		},
		{
			key = "k",
			mods = "SHIFT|ALT",
			action = wezterm.action.AdjustPaneSize({ "Up", 2 }),
		},
		{
			key = "h",
			mods = "ALT",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "ALT",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
		{
			key = "j",
			mods = "ALT",
			action = wezterm.action.ActivatePaneDirection("Down"),
		},
		{
			key = "k",
			mods = "ALT",
			action = wezterm.action.ActivatePaneDirection("Up"),
		},
	},
}

return M
