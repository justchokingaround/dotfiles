-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#0A2B2B" })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#393939", bg = "#161616" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = "#161616" })
vim.api.nvim_set_hl(0, "DiffText", { bg = "#161616" })
