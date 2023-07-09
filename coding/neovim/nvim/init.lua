-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#0A2B2B" })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#393939", bg = "#161616" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = "#161616" })
vim.api.nvim_set_hl(0, "DiffText", { bg = "#161616" })

-- if vim.g.neovide then
-- vim.g.neovide_transparency = 0.8
-- vim.g.neovide.transparency = 1
-- vim.g.neovide_no_idle = true
-- vim.g.neovide_refresh_rate = 165
-- vim.g.neovide_cursor_vfx_mode = "railgun"
--   vim.opt.guifont = { "Liga SFMono Nerd Font", ":h14" }
-- end

-- if vim.g.neovide then
-- vim.g.neovide.transparency = 1
-- vim.g.neovide_cursor_vfx_mode = "railgun"

-- vim.g.neovide_transparency = 0.8
-- vim.g.neovide_no_idle = true
-- vim.g.neovide_refresh_rate = 165
-- vim.opt.guifont = { "Liga SFMono Nerd Font", ":h14" }
--   vim.g.neovide_padding_top = 40
--   vim.g.neovide_padding_bottom = 40
--   vim.g.neovide_padding_right = 40
--   vim.g.neovide_padding_left = 40
-- end
