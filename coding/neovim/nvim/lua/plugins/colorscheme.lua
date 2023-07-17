local function build_colorscheme_spec(colorschemes)
  return vim.tbl_map(function(colorscheme)
    local fqn = type(colorscheme) == "string" and colorscheme or colorscheme[1]
    local spec =
        vim.tbl_extend("force", { fqn, event = "VeryLazy" }, type(colorscheme) == "table" and colorscheme or {})
    return spec
  end, colorschemes)
end

local colorschemes = {

  "nyoom-engineering/oxocarbon.nvim",
  "sindrets/oxocarbon-lua.nvim",
  "ellisonleao/gruvbox.nvim",
  "akai54/2077.nvim",
  "thedenisnikulin/vim-cyberpunk",
  "lunarvim/synthwave84.nvim"
}

return {
  build_colorscheme_spec(colorschemes),

  -- Configure LazyVim to load oxocarbon
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "oxocarbon",
    },
  },
}
