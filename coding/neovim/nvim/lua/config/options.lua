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
