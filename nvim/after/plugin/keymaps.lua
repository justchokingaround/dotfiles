local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Better escape using jk in insert and terminal mode
keymap("i", "jj", "<ESC>", default_opts)

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", default_opts)
keymap("n", "<C-j>", "<C-w>j", default_opts)
keymap("n", "<C-k>", "<C-w>k", default_opts)
keymap("n", "<C-l>", "<C-w>l", default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)

-- Switch buffer
keymap("n", "<S-h>", ":bprevious<CR>", default_opts)
keymap("n", "<S-l>", ":bnext<CR>", default_opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)
keymap("n", "<leader>h", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<Up>", ":resize -1<CR>", default_opts)
keymap("n", "<Down>", ":resize +1<CR>", default_opts)

-- Remap <C-f> to do the same as /
keymap("n", "<C-f>", "/", default_opts)

-- Remap <C-s> to save
keymap("n", "<C-s>", ":w<CR>", default_opts)

-- Remap <C-a> to select all in insert mode
keymap("i", "<C-a>", "<Esc>ggVG", default_opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", default_opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>", default_opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", default_opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", default_opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", default_opts)
keymap("n", "<leader>fc", ":Telescope colorscheme<CR>", default_opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", default_opts)

-- Shellcheck
keymap("n", "<leader>H", ":!shellcheck %<CR>", default_opts)
