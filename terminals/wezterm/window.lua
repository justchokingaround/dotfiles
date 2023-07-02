local padding = 40
local window_padding = {
  left = padding,
  right = padding,
  top = padding,
  bottom = padding,
}

local M = {
  window_padding = window_padding,
  -- window_background_opacity = 0.8,
  window_background_opacity = 1,
  window_decorations = "RESIZE",
  window_close_confirmation = "NeverPrompt",
  adjust_window_size_when_changing_font_size = false,
  command_palette_bg_color = "#262626",
  command_palette_fg_color = "#ffffff",
  command_palette_font_size = 20.0,
}

return M
