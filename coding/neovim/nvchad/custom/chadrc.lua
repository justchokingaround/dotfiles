---@type ChadrcConfig
local M = {}

M.plugins = "custom.plugins" -- path for lazy.nvim

M.ui = {
theme='oxocarbon',
  transparency = false,

  -- tabufline = {
  --   show_numbers = true
  -- }
}

M.mappings = require "custom.mappings"

return M
