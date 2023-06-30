
require "custom.commands"

local set = vim.opt
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.nu = false
set.title = true

-- Neovide options
if vim.g.neovide then
  vim.g.neovide_transparency = 0.8
  vim.g.neovide_no_idle = true
  vim.g.neovide_refresh_rate = 165
  -- vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.opt.guifont = { "Liga SFMono Nerd Font", ":h16" }
end

-- vim.filetype.add {
--   filename = {
--     [".mkshrc"] = "sh",
--   },
-- }
--
-- vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter", "tabnew" }, {
--   callback = function()
--     vim.t.bufs = vim.tbl_filter(function(bufnr)
--       return vim.api.nvim_buf_get_option(bufnr, "modified")
--     end, vim.t.bufs)
--   end,
-- })

-- for i = 1, 9, 1 do
--   vim.keymap.set("n", string.format("<A-%s>", i), function()
--     vim.api.nvim_set_current_buf(vim.t.bufs[i])
--   end)
-- end
