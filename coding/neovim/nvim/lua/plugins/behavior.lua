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

  -- Indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      char = "▏",
      -- add neorg and org
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "neorg", "org" },
    },
  },

  -- Accelerated j and k
  {
    "rainbowhxch/accelerated-jk.nvim",

    config = function()
      require("accelerated-jk").setup({
        mode = "time_driven",
        enable_deceleration = false,
        acceleration_motions = {},
        acceleration_limit = 150,
        acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
        -- when 'enable_deceleration = true', 'deceleration_table = { {200, 3}, {300, 7}, {450, 11}, {600, 15}, {750, 21}, {900, 9999} }'
        deceleration_table = { { 150, 9999 } },
      })
    end,
  },

  -- Hop (i prefer this plugin to leap)
  {
    "phaazon/hop.nvim",
    config = function()
      require("hop").setup({
        current_line_only = true,
        jump_on_sole_occurrence = true,
      })
    end,
  },

  -- NNN file browser in neovim
  {
    "luukvbaal/nnn.nvim",
    config = function()
      require("nnn").setup({
        picker = {
          cmd = "tmux new-session nnn -Pp",
          style = { border = "rounded" },
          session = "shared",
        },
      })
    end,
  },

  -- Tabout
  -- Supercharge your workflow and start tabbing out from parentheses, quotes, and similar contexts
  {
    "abecodes/tabout.nvim",
    config = function()
      require("tabout").setup({
        tabkey = "<Tab>",
        backwards_tabkey = "<S-Tab>",
        completion = true,
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
        },
        exclude = {},
      })
    end,
    wants = { "nvim-treesitter" },
    after = { "nvim-cmp" },
  },

  -- Telescope
  -- TODO: extract keybinds
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      {
        "dharmx/telescope-media.nvim",
        config = function()
          require("telescope").load_extension("media")
        end,
      },
    },
    keys = {
      {
        "<leader>fc",
        function()
          require("telescope.builtin").commands()
        end,
        desc = "Commands",
      },
      {
        "<leader>fd",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "Diagnostics",
      },
      {
        "<leader>fj",
        function()
          require("telescope.builtin").jumplist()
        end,
        desc = "Jump List",
      },
      {
        "<leader>fk",
        function()
          require("telescope.builtin").keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>fo",
        function()
          vim.cmd([[ Telescope ]])
        end,
        desc = "Telescope",
      },
      {
        "<leader>fs",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "Find Document Symbols",
      },
      {
        "<leader>fm",
        function()
          require("telescope").extensions.media.media({
            backend = "ueberzug",
          })
        end,
        desc = "Find Media",
      },
      {
        "<leader>fh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Help Tags",
      },
      {
        "<leader>fw",
        function()
          require("telescope.builtin").live_grep({ search_dirs = { vim.fn.expand("%:p") } })
        end,
        desc = "Live Grep in Current File",
      },
      {
        "<leader>*",
        function()
          require("telescope.builtin").grep_string({
            search = vim.fn.expand("<cword>"),
            search_dirs = { vim.fn.expand("%:p") },
          })
        end,
      },
    },
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        prompt_prefix = "   ",
        selection_caret = "  ",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        winblend = 0,
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

  -- WhichKey
  {
    "folke/which-key.nvim",
    opts = function()
      require("which-key").register({
        ["<leader>o"] = {
          name = "+org",
        },
        ["<leader>gd"] = {
          name = "+diffview",
        },
      })
    end,
  },
}
