local function build_colorscheme_spec(colorschemes)
  return vim.tbl_map(function(colorscheme)
    local fqn = type(colorscheme) == "string" and colorscheme or colorscheme[1]
    local spec =
      vim.tbl_extend("force", { fqn, event = "VeryLazy" }, type(colorscheme) == "table" and colorscheme or {})
    return spec
  end, colorschemes)
end

local colorschemes = {
  -- Clean and popular
  -- > A clean, dark Neovim theme written in Lua, with support for
  -- > lsp, treesitter and lots of plugins.
  "folke/tokyonight.nvim",

  -- One of my favorites
  -- > A dark and light Neovim theme written in fennel, inspired by IBM Carbon.
  "nyoom-engineering/oxocarbon.nvim",
  "sindrets/oxocarbon-lua.nvim",

  -- Really cool
  -- > A dark charcoal theme for modern Neovim & classic Vim
  "bluz71/vim-moonfly-colors",
  "bluz71/vim-nightfly-colors",
  "Everblush/nvim",
  "JoosepAlviste/palenightfall.nvim",
  "yonlu/omni.vim",
  "Abstract-IDE/Abstract-cs",
  "Mofiqul/dracula.nvim",
  "LunarVim/horizon.nvim",

  -- > Port of the original
  -- >> A Synthwave inspired colour theme (for VSCode)
  -- >> Source: https://github.com/robb0wen/synthwave-vscode
  "LunarVim/synthwave84.nvim",
  "katawful/kat.nvim",
  "hachy/eva01.vim",
  "igorgue/danger",

  -- > NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai
  "rebelot/kanagawa.nvim",

  -- > Moonbow is a theme for nvim inspired by Gruvbox and Ayu dark
  "arturgoms/moonbow.nvim",

  -- > 🪨 A collection of contrast-based Vim/Neovim colorschemes
  { "mcchrish/zenbones.nvim", dependencies = "rktjmp/lush.nvim" },

  -- > 🍨 Soothing pastel theme for (Neo)vim
  { "catppuccin/nvim", name = "catppuccin" },

  -- > All natural pine, faux fur and a bit of soho vibes for the classy minimalist
  { "rose-pine/neovim", name = "rose-pine" },
  { "ellisonleao/gruvbox.nvim", opts = { palette_overrides = {} } },

  -- Tons of awesome color schemes in base16. Really nice!
  "RRethy/nvim-base16",

  { "scysta/pink-panic.nvim", dependencies = "rktjmp/lush.nvim" },

  {
    "jesseleite/nvim-noirbuddy",
    dependencies = { "tjdevries/colorbuddy.nvim", branch = "dev" },
  },

  {
    "maxmx03/fluoromachine.nvim",
    -- Setting these also enables the colorscheme. Poor
    -- opts = {
    --   -- glow = true,
    -- },
  },
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
