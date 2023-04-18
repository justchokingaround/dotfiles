local overrides = require "custom.configs.overrides"
local cmp = require "cmp"

return {

  ----------------------------------------- default plugins ------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    opts = {
      sources = {
        -- trigger_characters is for unocss lsp
        { name = "nvim_lsp", trigger_characters = { "-" } },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
      },
      mapping = {
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
      }
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        -- format & linting
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },

    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  -- override default configs
  { "nvim-tree/nvim-tree.lua", opts = overrides.nvimtree },
  { "nvim-treesitter/nvim-treesitter", opts = overrides.treesitter },
  { "williamboman/mason.nvim", opts = overrides.mason },
  {
   "nvim-telescope/telescope.nvim",
   opts = {
     defaults = {
       mappings = {
         i = {
           ["<C-j>"] = function(...)
               require("telescope.actions").move_selection_next(...)
            end,
           ["<C-k>"] = function(...)
               require("telescope.actions").move_selection_previous(...)
            end,
          },
        },
      },
    },
   },

  --------------------------------------------- custom plugins ----------------------------------------------

  -- autoclose tags in html, jsx only
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- get highlight group under cursor
  {
    "nvim-treesitter/playground",
    cmd = "TSCaptureUnderCursor",
    config = function()
      require("nvim-treesitter.configs").setup()
    end,
  },

  -- dim inactive windows
  {
    "andreadev-it/shade.nvim",
    keys = "<Bslash>",
    config = function()
      require("shade").setup {
        exclude_filetypes = { "NvimTree" },
      }
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = function()
      require("trouble").setup()
    end,
  },

  {
    "elkowar/yuck.vim",
    config = function()
      vim.opt.ft = "yuck"
    end,
  },

  {
    "Exafunction/codeium.vim",
    lazy = false,
    config = function ()
      vim.keymap.set('i', '<C-e>', function () return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end,
  },

  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
        require("lspsaga").setup({})
    end,
    dependencies = {
      {"nvim-tree/nvim-web-devicons"},
      --Please make sure you install markdown and markdown_inline parser
      {"nvim-treesitter/nvim-treesitter"}
    }
  },

  -- Lua
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = function()
      require "custom.configs.zenmode"
    end,
  },
}
