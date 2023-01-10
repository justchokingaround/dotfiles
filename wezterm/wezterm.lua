local wezterm = require("wezterm")
return {
	default_cursor_style = "SteadyBar",
	-- font = wezterm.font 'JetBrains Mono',
	font = wezterm.font("Liga SFMono Nerd Font"),
	font_size = 16.0,
	-- color_scheme = "DanQing (base16)",
	color_scheme = "kanagawabones",
	enable_tab_bar = false,
	enable_wayland = true,
	window_background_opacity = 0.5,
	window_close_confirmation = "NeverPrompt",
	-- default_prog = { "nu" },
	default_prog = { "zsh" },
	-- window_background_image = "/home/chokerman/pix/wallpapers/cyberpunk_moon.jpg",
	-- window_background_image_hsb = {
	--     brightness = 0.3,
	--     hue = 1.0,
	--     saturation = 1.0,
	--   },
}
