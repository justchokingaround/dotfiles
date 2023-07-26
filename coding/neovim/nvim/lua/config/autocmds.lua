-- disable autoformat for markdown files, (not work good with material mkdocs)
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown" },
  callback = function()
    vim.b.autoformat = false
  end,
})
