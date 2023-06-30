return {

  -- Comment plugin, so that you can easily comment with gcc, gcj, gck etc.
  {
    "numToStr/Comment.nvim",
  },

  -- Compiler
  {
    "zeioth/compiler.nvim",
    dependenciens = { "stevearc/overseer.nvim" },
    cmd = { "CompilerOpen", "CompilerToggleResults" },
    config = function(_, opts)
      require("compiler").setup(opts)
    end,
  },
  {
    "stevearc/overseer.nvim",
    commit = "3047ede61cc1308069ad1184c0d447ebee92d749",
    cmd = { "CompilerOpen", "CompilerToggleResults" },
    opts = {
      -- Tasks are disposed 5 minutes after running to free resources.
      -- If you need to close a task inmediatelly:
      -- press ENTER in the menu you see after compiling on the task you want to close.
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
        bindings = {
          ["q"] = function()
            vim.cmd("OverseerClose")
          end,
        },
      },
    },
    config = function(_, opts)
      require("overseer").setup(opts)
    end,
  },

  -- Lspsaga
  -- TODO: add lspsaga keybinds, and use it as the default lsp plugin for stuff and stuff
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({})
    end,
    keys = { { "<leader>cs", "<cmd>Lspsaga outline<cr>", desc = "Symbols Outline" } },
  },

  -- Markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    -- cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- Mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "shellcheck",
        "bash-language-server",
        "bash-debug-adapter",
        "json-lsp",
        "lua-language-server",
        "glow",
        "jdtls",
        "rust-analyzer",
        "rustfmt",
      },
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Neorg
  -- TODO: extract keybinds
  {
    "nvim-neorg/neorg",
    run = ":Neorg sync-parsers",
    keys = {
      {
        "<leader>oi",
        "<cmd>Neorg index<cr>",
        desc = "org index",
      },
      {
        "<leader>or",
        "<cmd>Neorg return<cr>",
        desc = "org return",
      },
    },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.completion"] = {
            config = { engine = "nvim-cmp" },
          },
          -- for pretty icons
          ["core.concealer"] = {
            config = {
              markup_preset = "conceal",
              icon_preset = "varied",
              -- icon_preset = "diamond",
              icons = {
                heading = {
                  icons = { "◉", "◆", "✿", "○", "▶", "⤷" },
                },
              },
            },
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                home = "~/dox/neorg",
              },
              default_workspace = "home",
            },
          },
        },
      })
    end,
  },

  -- Null LS
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt.with({
            args = { "-i", "4", "-ci" },
          }),
          -- nls.builtins.diagnostics.flake8,
        },
      }
    end,
  },

  -- Nvim Navbuddy
  -- TODO: extract keybind
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    init = function()
      require("lazyvim.util").on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navbuddy").attach(client, buffer)
        end
      end)
    end,
    keys = {
      {
        "<leader>cn",
        function()
          require("nvim-navbuddy").open()
        end,
        desc = "Open document symbol nagivator",
      },
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = "v",
          node_decremental = "V",
        },
      },
      ensure_installed = {
        "bash",
        "elixir",
        "html",
        "heex",
        "java",
        "javascript",
        "json",
        "lua",
        "markdown",
        "regex",
        "tsx",
        "typescript",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- Orgmode (the actual emacs orgmode)
  {
    "nvim-orgmode/orgmode",
    init = function()
      local org = require("orgmode")

      org.setup_ts_grammar()
      org.setup({
        org_agenda_files = { "~/dox/org/**/*" },
        org_default_notes_file = "~/dox/org/inbox.org",
        org_agenda_templates = {
          t = { description = "Todo", template = "* TODO %?" },
          n = { description = "Note", template = "* %?" },
        },
      })
    end,
  },

  -- Overseer
  {
    "stevearc/overseer.nvim",
    config = function()
      require("overseer").setup()
    end,
    cmd = { "OverseerRun", "OverseerRestartLast", "OverseerToggle" },
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        size = 20,
        highlights = {
          Normal = { guibg = "#161616" },
          NormalFloat = { link = "Normal" },
          FloatBorder = { guifg = "#ee5396", guibg = "#161616" },
        },
        hide_numbers = true,
        start_in_insert = true,
        direction = "float",
        close_on_exit = true,
        shell = "/usr/bin/zsh",
        float_opts = { border = "curved" },
      })
    end,
  },
}
