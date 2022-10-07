-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
  end,
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = { "AlphaReady" },
  callback = function()
    vim.cmd [[
      set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]]
  end,
})

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
	end,
})

-- Set ray settings

-- let g:ray_options =
-- \ {
-- \ 'colors' : 'midnight',
-- \ 'background' : 'true',
-- \ 'darkMode' : 'true',
-- \ 'padding' : '64',
-- \ 'language' : 'auto'
-- \  }

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function ()
    vim.cmd "let g:ray_options = {'colors': 'breeze', 'background': 'true', 'darkMode': 'true', 'padding': '32', 'language': 'auto'}"
  end
})

-- Save cursor position
vim.cmd [[autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]
vim.cmd [[autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif]]
vim.cmd [[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]]
