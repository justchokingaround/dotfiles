local api = vim.api
local g = vim.g
local opt = vim.opt

-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "

opt.termguicolors = true
opt.hlsearch = true
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 300
opt.signcolumn = "yes"
opt.clipboard = "unnamedplus"

-- Better search
opt.path:remove "/usr/include"
opt.path:append "**"

opt.wildignorecase = true
opt.wildignore:append "**/node_modules/*"
opt.wildignore:append "**/.git/*"
