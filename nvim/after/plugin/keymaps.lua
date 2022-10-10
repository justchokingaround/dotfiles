local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

vim.g.mapleader = ' '

-- Center search results
map("n", "n", "nzz", default_opts)
map("n", "N", "Nzz", default_opts)

-- Visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
map("v", "<", "<gv", default_opts)
map("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
map("v", "p", '"_dP', default_opts)

-- Switch buffer
map("n", "<S-h>", ":bprevious<CR>", default_opts)
map("n", "<S-l>", ":bnext<CR>", default_opts)

-- Cancel search highlighting with ESC
map("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)
map("n", "<Leader>h", ":nohl<CR>", default_opts)

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", default_opts)
map("x", "J", ":move '>+1<CR>gv-gv", default_opts)

-- Resizing panes
map("n", "<Left>", ":vertical resize +1<CR>", default_opts)
map("n", "<Right>", ":vertical resize -1<CR>", default_opts)
map("n", "<Up>", ":resize -1<CR>", default_opts)
map("n", "<Down>", ":resize +1<CR>", default_opts)

-- Hop
map("n", "s", ":HopWord<CR>", default_opts)

-- nnn
map("t", "<Leader>e", "<C-\\><C-n>:NnnExplorer<CR>", default_opts)
map("n", "<Leader>e", ":NnnExplorer %:p:h<CR>", default_opts)
map("n", "<Leader>n", ":NnnPicker %:p:h<CR>", default_opts)
map("n", "<Leader>n", ":NnnPicker %:p:h<CR>", default_opts)
