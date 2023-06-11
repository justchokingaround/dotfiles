-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- This file is automatically loaded by lazyvim.config.init
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
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

map("", "<C-d>", "<C-d>zz", { noremap = false, silent = true })
map("", "<C-u>", "<C-u>zz", { noremap = false, silent = true })
map("n", "n", "nzzzv", { noremap = false, silent = true })
map("n", "N", "Nzzzv", { noremap = false, silent = true })

-- buffers
if Util.has("bufferline.nvim") then
  map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
  map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
end

-- ToggleTerm keymaps
map({ "n", "v", "i", "t" }, "<A-i>", "<cmd>lua require('toggleterm').toggle()<CR>", { desc = "Toggle terminal" })
-- Fix Ctrl-l in terminal mode (for clearing)
vim.keymap.del("t", "<C-l>")

-- Resizing panes
map("n", "<Left>", ":vertical resize +1<CR>")
map("n", "<Right>", ":vertical resize -1<CR>")
map("n", "<Up>", ":resize +1<CR>")
map("n", "<Down>", ":resize -1<CR>")

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "J", ":move '>+1<CR>gv-gv")

-- Paste over currently selected text without yanking it
map("v", "p", '"_dP')

-- Hop keymaps
map(
  { "n", "v" },
  "f",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, })<cr>",
  {}
)
map(
  { "n", "v" },
  "F",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, })<cr>",
  {}
)
map(
  "o",
  "f",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, inclusive_jump = true })<cr>",
  {}
)
map(
  "o",
  "F",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, inclusive_jump = true })<cr>",
  {}
)
map(
  { "n", "v" },
  "t",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, hint_offset = -1 })<cr>",
  {}
)
map(
  { "n", "v" },
  "T",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, hint_offset = -1 })<cr>",
  {}
)
map(
  "o",
  "t",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, hint_offset = -1, inclusive_jump = true })<cr>",
  {}
)
map(
  "o",
  "T",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, hint_offset = -1, inclusive_jump = true })<cr>",
  {}
)
-- run :HopAnywhere on `s`
map("n", "s", "<cmd>lua require'hop'.hint_char1( { current_line_only = false } )<cr>", {})
map("", "S", "<cmd>lua require'hop'.hint_patterns()<cr>", {})
map("", "L", "<cmd>lua require'hop'.hint_lines()<cr>", {})

-- Diffview keymaps
