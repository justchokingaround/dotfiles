local wezterm = require("wezterm")
return {
	default_cursor_style = "SteadyUnderline",
	font = wezterm.font("Liga SFMono Nerd Font"),
	color_scheme = "Oxocarbon Dark",
	font_size = 16.0,
	enable_tab_bar = false,
	use_fancy_tab_bar = false,
	window_decorations = "RESIZE",
	enable_wayland = true,
	window_background_opacity = 1,
	--window_background_opacity = 0.6,
	window_close_confirmation = "NeverPrompt",
	window_padding = {
		left = 40,
		top = 40,
	},
	-- default_prog = { "nu" },
	default_prog = { "zsh" },
}
