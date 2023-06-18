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
  { "ellisonleao/gruvbox.nvim", opts = { palette_overrides = {} } },
}

return {
  build_colorscheme_spec(colorschemes),

  -- Effortlessly sync the terminal background with Neovim.
  -- As a side effect, get effortless transparency across color schemes!
  {
    "typicode/bg.nvim",
    lazy = false,
    cond = function()
      return os.getenv("NVIM_COLORSYNC") == nil
    end,
  },

  -- Configure LazyVim to load oxocarbon
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "oxocarbon",
    },
  },
}
