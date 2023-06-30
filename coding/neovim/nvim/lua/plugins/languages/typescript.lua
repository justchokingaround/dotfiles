local util = require("config.utils")

return {
  -- add typescript to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "typescript", "tsx" })
      end
    end,
  },

  -- Add neotest adapter for Jest
  require("config.utils.lang").neotest_extension_spec(
    { { "haydenmeade/neotest-jest" }, { "marilari88/neotest-vitest" } },
    { "javascript", "typescript", "jsx" }
  ),

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      util.list_insert_unique(opts.sources, {
        nls.builtins.code_actions.eslint_d,
      })
      return opts
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "yioneko/nvim-vtsls" },
    opts = function(_, og)
      require("lspconfig.configs").vtsls = require("vtsls").lspconfig

      return vim.tbl_deep_extend("force", og, {
        servers = {
          vtsls = {},
        },
        setup = {
          vtsls = function(_, opts)
            require("lazyvim.util").on_attach(function(client, buffer)
              if client.name == "vtsls" then
                  -- stylua: ignore
                vim.keymap.set("n", "<leader>co", "<cmd>VtsExec organize_imports<CR>", { buffer = buffer, desc = "Organize Imports" })
                  -- stylua: ignore
                vim.keymap.set("n", "<leader>cR", "<cmd>VtsExec rename_file<CR>", { buffer = buffer, desc = "Rename File" })
              end
            end)
            require("lspconfig").vtsls.setup({})
            require("vtsls").config({ lspconfig = opts })
            return true
          end,
        },
      })
    end,
  },
}
