-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

local function list(value, str, sep)
  sep = sep or ","
  str = str or ""
  value = type(value) == "table" and table.concat(value, sep) or value
  return str ~= "" and table.concat({ value, str }, sep) or value
end

opt.number = false
opt.relativenumber = false
-- opt.clipboard = ""
opt.clipboard = "unnamedplus"

-- <leader>uc to change this, i prefer seeing evertyhing by default, when editing markdown or neorg files
opt.conceallevel = 0
vim.g.maplocalleader = ","

if vim.g.neovide then
  vim.g.neovide_transparency = 0.8
  vim.g.neovide_no_idle = true
  vim.g.neovide_refresh_rate = 165
  vim.g.neovide_padding_top = 40
  vim.g.neovide_padding_bottom = 40
  vim.g.neovide_padding_left = 40
  vim.g.neovide_padding_right = 40
  -- vim.opt.guifont = { "ComicCodeLigatures", ":h14" }
  vim.opt.guifont = { "Liga SFMono Nerd Font", ":h14" }
end

opt.list = true
opt.listchars = {
  trail = "·",
  precedes = "«",
  extends = "»",
  -- eol = "↲", -- This is a bit too much
  tab = "▸ ",
}

-- opt.listchars = list({
--   "tab: ──",
--   "lead:·",
--   "trail:·",
--   "nbsp:␣",
--   -- "eol:↵",
--   "precedes:«",
--   "extends:»",
-- })
opt.fillchars = list({
  -- "vert:▏",
  "vert:│",
  "diff:╱",
  "foldclose:",
  "foldopen:",
  "fold: ",
  "msgsep:─",
})

opt.showbreak = "⤷ "
opt.concealcursor = "nc"
opt.writebackup = true
opt.undofile = true
opt.undolevels = 10000
opt.isfname:append(":")
opt.cursorline = false

vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#0A2B2B" })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#393939", bg = "#161616" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = "#161616" })
vim.api.nvim_set_hl(0, "DiffText", { bg = "#161616" })
