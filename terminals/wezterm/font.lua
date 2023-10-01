local wezterm = require("wezterm")

local font_size = 16
local stretch = true
local font_family = ({
	"{{font.family}}",          -- [1]
	"BlexMono Nerd Font",       -- [2]
	"Iosevka Nerd Font Mono",   -- [3]
	"JetBrainsMono Nerd Font",  -- [4]
	"FiraCode Nerd Font",       -- [5]
	"ComicCodeLigatures",       -- [6]
	"Nouveau IBM",              -- [7]
	"IBM Plex Mono",            -- [8]
	"Source Code Pro",          -- [9]
	"NotoSansMono Nerd Font",   -- [10]
	"FantasqueSansM Nerd Font", -- [11]
	"JetBrainsMono",            -- [12]
})[1]

local options = {}
if stretch then
	options["stretch"] = "UltraExpanded"
end

local font = wezterm.font(font_family, options)

return { font = font, font_size = font_size }
