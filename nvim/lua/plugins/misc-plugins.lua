-- Highlight YAML front matter
vim.api.nvim_set_var("vim_markdown_frontmatter ", 1)

return {
  -- markdown support
  { "godlygeek/tabular" }, -- required by vim-markdown
  { "plasticboy/vim-markdown" },
}
