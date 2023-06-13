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

-- ===================
-- QoL and consistency
-- ===================

-- Navigate tab completion w/ <C-j> and <C-k>

--- Map `key` to `mapped_to` if the nvim-native popup
--- menu is visible.
---
--- @param mode string  Mode shortstring
--- @param lhs  string  LHS
--- @param rhs  string  RHS
--- @param fb   string|nil  Fallback key triggered on popup absence.
---                         If `nil`, `lhs` is triggered instead.
---
--- @see https://vim.fandom.com/wiki/Improve_completion_popup_menu
local function map_if_pumvisible_else(mode, lhs, rhs, fb)
  vim.keymap.set(mode, lhs, function()
    return vim.fn.pumvisible() == 1 and rhs or fb or lhs
  end, { expr = true, noremap = true })
end

local function map_if_pumvisible(mode, lhs, rhs)
  map_if_pumvisible_else(mode, lhs, rhs, nil)
end

-- Better command-completion mappings
map_if_pumvisible_else("c", "<C-k>", "<C-p>", "<Up>")
map_if_pumvisible_else("c", "<C-j>", "<C-n>", "<Down>")
map_if_pumvisible("c", "<Esc>", "<C-e>")
map_if_pumvisible("c", "<CR>", "<C-y>")

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
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Open diffview" })

-- Octo (github integration) keymaps
-- General keymap
map("n", "<leader>go", "<cmd>Octo actions<cr>", { desc = "Open Octo menu" })
-- Issue keymaps
map("n", "<leader>il", "<cmd>Octo issue list<cr>", { desc = "List issues" })
map("n", "<leader>ic", "<cmd>Octo issue close<cr>", { desc = "Close issue" })
map("n", "<leader>ir", "<cmd>Octo issue reopen<cr>", { desc = "Reopen issue" })
map("n", "<C-r>", "<cmd>Octo issue reload<cr>", { desc = "Reload issue" })
map("n", "<C-b>", "<cmd>Octo issue browser<cr>", { desc = "Open issue in browser" })
map("n", "<C-y>", "<cmd>Octo issue url<cr>", { desc = "Copy issue url" })
map("n", "<leader>aa", "<cmd>Octo assignee add<cr>", { desc = "Add assignee" })
map("n", "<leader>ad", "<cmd>Octo assignee remove<cr>", { desc = "Remove assignee" })
map("n", "<leader>ala", "<cmd>Octo label add<cr>", { desc = "Add label" })
map("n", "<leader>ald", "<cmd>Octo label remove<cr>", { desc = "Remove label" })
map("n", "<leader>aca", "<cmd>Octo comment add<cr>", { desc = "Add comment" })
map("n", "<leader>acd", "<cmd>Octo comment delete<cr>", { desc = "Delete comment" })
-- PRs keymaps
map("n", "<leader>pl", "<cmd>Octo pr list<cr>", { desc = "List PRs" })
-- the rest of the pr keymaps are defined by default
