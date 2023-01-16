local autocmd = vim.api.nvim_create_autocmd

local set = vim.opt
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.nu = false
-- set.relativenumber = true

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- Auto command for saving cursor position
vim.cmd [[autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]
vim.cmd [[autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif]]
vim.cmd [[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]]

-- Neovide options
vim.g.neovide_transparency = 0.7
vim.g.neovide_no_idle = true
vim.g.neovide_refresh_rate = 165
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.opt.guifont = { "Liga SFMono Nerd Font", ":h14" }

-- Auto command for setting colorscheme
autocmd("BufEnter", {
  pattern = "*",
  command = "colorscheme oxocarbon",
})
