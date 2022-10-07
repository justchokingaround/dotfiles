-- to avoid colorizer bug on startup
vim.o.termguicolors = true
require("plugins").setup()
require("config.lsp").setup()
