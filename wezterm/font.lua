local wezterm = require 'wezterm'

local font_size = 18
local bold = false
local font_family = ({
    'BlexMono Nerd Font', -- [1]
    'Liga SFMono Nerd Font', -- [2]
    'Iosevka Nerd Font Mono', -- [3]
    'JetBrainsMono Nerd Font', -- [4]
    'FiraCode Nerd Font Mono', -- [5]
    'ComicCodeLigatures', -- [6]
    'Nouveau IBM', -- [7]
    'IBM Plex Mono' -- [8]
})[2]

local options = {}
if bold then options['weight'] = 'Bold' end

local font = wezterm.font(font_family, options)

return {font = font, font_size = font_size}
