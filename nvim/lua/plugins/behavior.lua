return {
  {
    -- Only highlight cursorline of the active window
    -- Makes it easier to tell what window is active in the
    -- Absence of a prominent cursor (such as with lighter-colored themes)
    "tummetott/reticle.nvim",
    event = "VeryLazy",
    opts = {
      always = {
        cursorline = {
          "neo-tree", -- reticle messes up with Neo-tree cursorline in search mode
        },
      },
    },
  },
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<F28>",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete buffer",
      },
    },
  },
  {
    "echasnovski/mini.indentscope",
    opts = function(_, og)
      local overrides = {
        draw = {
          animation = require("mini.indentscope").gen_animation.none(),
          delay = 50,
        },
      }

      return vim.tbl_deep_extend("force", og, overrides)
    end,
  },
  {
    -- draw `:h colorcolumn` with a virtual text + a character
    "lukas-reineke/virt-column.nvim",
    config = true,
  },

  -- >  Treesitter based structural search and replace plugin for Neovim.
  -- Ref: https://www.jetbrains.com/help/idea/structural-search-and-replace.html
  {
    "cshuaimin/ssr.nvim",
    event = "BufReadPre",
    keys = {
      {
        "<leader>sR",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural Replace",
      },
    },
  },

  { -- indent guides for Neovim
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      char = "▏", -- from lazyvim: "│",

      -- add neorg and org
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "neorg", "org" },
    },
  },
}
