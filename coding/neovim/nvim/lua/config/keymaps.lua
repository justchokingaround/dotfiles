local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	-- do not create the keymap if a lazy keys handler exists
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		if opts.remap and not vim.g.vscode then
			opts.remap = nil
		end
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

local function map_if_pumvisible_else(mode, lhs, rhs, fb)
	vim.keymap.set(mode, lhs, function()
		return vim.fn.pumvisible() == 1 and rhs or fb or lhs
	end, { expr = true, noremap = true })
end

local function map_if_pumvisible(mode, lhs, rhs)
	map_if_pumvisible_else(mode, lhs, rhs, nil)
end

-- ACCELERATED JK
vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})

-- QOL
map_if_pumvisible_else("c", "<C-k>", "<C-p>", "<Up>")
map_if_pumvisible_else("c", "<C-j>", "<C-n>", "<Down>")
map_if_pumvisible("c", "<Esc>", "<C-e>")
map_if_pumvisible("c", "<CR>", "<C-y>")
map("", "<C-d>", "<C-d>zz", { noremap = false, silent = true, desc = "Scroll down" })
map("", "<C-u>", "<C-u>zz", { noremap = false, silent = true, desc = "Scroll up" })
map("n", "n", "nzzzv", { noremap = false, silent = true, desc = "Move to next search match" })
map("n", "N", "Nzzzv", { noremap = false, silent = true, desc = "Move to previous search match" })
map("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear highlights" })
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save" })
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })
if Util.has("bufferline.nvim") then
	map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
	map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
	map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
	map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
end
map("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move selected lines down" })
map("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move selected lines up" })
map("v", "p", '"_dP', { desc = "Paste over selected text without yanking it" })
map("i", "<C-h>", "<C-w>", { noremap = true, desc = "Ctrl Backspace to delete word" })
map("n", "<cr>", "ciw", { desc = "Change current word" })
map("n", "<C-c>", "<cmd>%y+<cr>", { desc = "Yank whole file" })
map("n", "U", "<C-r>", { desc = "Redo" })

-- TERMINAL
map({ "n", "v", "i", "t" }, "<A-i>", "<cmd>lua require('toggleterm').toggle()<CR>", { desc = "Toggle terminal" })

-- PANES
map("n", "<C-h>", "<C-w>h", { desc = "Navigate to pane left" })
map("n", "<C-j>", "<C-w>j", { desc = "Navigate to pane down" })
map("n", "<C-k>", "<C-w>k", { desc = "Navigate to pane up" })
map("n", "<C-l>", "<C-w>l", { desc = "Navigate to pane right" })
map("n", "<Left>", ":vertical resize +1<CR>", { desc = "Resize pane left" })
map("n", "<Right>", ":vertical resize -1<CR>", { desc = "Resize pane right" })
map("n", "<Up>", ":resize +1<CR>", { desc = "Resize pane up" })
map("n", "<Down>", ":resize -1<CR>", { desc = "Resize pane down" })

-- HOP
map("n", "<leader>w", "<cmd>HopWord<cr>", { desc = "Hop word" })
map("n", "<leader>j", "<cmd>HopLine<cr>", { desc = "Hop line" })
map("n", "<leader>k", "<cmd>HopLine<cr>", { desc = "Hop line" })
-- TODO: fix skill issue
-- additionally, i have the following binds in the setup function, due to a skill issue on my side i couldn't include it here
-- { "s", "<cmd>HopPattern<cr>", desc = "Hop to pattern" },
-- { "f", "<cmd>HopChar1<cr>", desc = "Hop to char" },

-- DIFFVIEW
map("n", "<leader>do", "<cmd>DiffviewOpen<cr>", { desc = "Open diffview" })
map("n", "<leader>dc", "<cmd>DiffviewClose<cr>", { desc = "Open diffview" })

-- OCTO
map("n", "<leader>go", "<cmd>Octo actions<cr>", { desc = "Octo actions" })

-- BUFFER DELETE
map("n", "<leader>bd", "<cmd>Bdelete<cr>", { desc = "Delete Buffer" })
map("n", "<localleader>c", "<cmd>Bdelete<cr>", { desc = "Delete Buffer" })
map("n", "<leader>bD", "<cmd>Bdelete!<cr>", { desc = "Delete Buffer (Force)" })

-- LOCALLEADER
map("n", "<localleader>Q", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<localleader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<LocalLeader>z", ":ZenMode<cr>", { desc = "Zen Mode" })
map("n", "<localleader>w", ":w<cr>", { desc = "Save Buffer" })
map("n", "<localleader>W", ":wall<cr>", { desc = "Save All Buffers" })
map("n", "<localleader>p", ":BufferLinePick<cr>", { desc = "Pick Buffer" })

-- LSPSAGA
map("n", "<leader>lf", "<cmd>Lspsaga lsp_finder<CR>", { desc = "LSP Finder" })
map("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })
map("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", { desc = "Rename" })
map("n", "<leader>lp", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Definition" })
map("n", "<leader>ld", "<cmd>Lspsaga goto_definition<CR>", { desc = "Go to Definition" })
map("n", "<leader>lt", "<cmd>Lspsaga goto_type_definition<CR>", { desc = "Go to Type Definition" })
map("n", "<leader>lo", "<cmd>Lspsaga outline<CR>", { desc = "Toggle Outline" })
map("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover Doc" })

map("n", "go", "<cmd>Lspsaga outline<CR>", { desc = "Toggle Outline" })
map("n", "g[", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Prev diagnostic" })
map("n", "g]", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next diagnostic" })
map("n", "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Line diagnostic" })
map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })
map("n", "gr", "<cmd>Lspsaga rename<CR>", { desc = "Rename in file range" })
map("n", "gR", "<cmd>Lspsaga rename ++project<CR>", { desc = "Rename in project range" })
map("v", "ga", "<cmd>Lspsaga code_action<CR>", { desc = "Code action for cursor" })
map("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { desc = "Preview definition" })
map("n", "gD", "<cmd>Lspsaga goto_definition<CR>", { desc = "Goto definition" })
map("n", "gh", "<cmd>Lspsaga finder<CR>", { desc = "Show reference" })
map("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>", { desc = "Show incoming calls" })
map("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>", { desc = "Show outgoing calls" })

-- TELESCOPE
map("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Commands" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
map("n", "<leader>fm", "<cmd>Telescope media_files<cr>", { desc = "Media Files" })
map("n", "<leader>fo", "<cmd>Telescope<cr>", { desc = "Telescope" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document Symbols" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
map("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Grep String" })
map("n", "<leader>f*", "<cmd>Telescope grep_string search=<cword><cr>", { desc = "Grep String" })
