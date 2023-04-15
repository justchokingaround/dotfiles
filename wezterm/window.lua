local use_background_image = false

local padding = 40
local window_padding = {
    left = padding,
    right = padding,
    top = padding,
    bottom = padding
}

local M = {
    window_padding = window_padding,
    window_background_image_hsb = {brightness = 0.3},
    -- window_background_opacity = 0.9,
    window_decorations = 'RESIZE',
    window_close_confirmation = 'NeverPrompt',
    adjust_window_size_when_changing_font_size = false
}

if use_background_image then
    M.window_background_image = '/home/chokerman/.config/wezterm/background.png'
end

return M
