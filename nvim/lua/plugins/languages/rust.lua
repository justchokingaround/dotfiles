return {

  -- add rust to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "rust")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "simrat39/rust-tools.nvim" },
    opts = {
      setup = {
        rust_analyzer = function(_, opts)
          require("lazyvim.util").on_attach(function(client, buffer)
            if client.name == "rust_analyzer" then
              vim.keymap.set(
                "n",
                "<leader>co",
                "<cmd>RustHoverActions<cr>",
                { buffer = buffer, desc = "Hover Actions (Rust)" }
              )
              vim.keymap.set(
                "n",
                "<leader>cR",
                "<cmd>RustCodeActionGroup<cr>",
                { buffer = buffer, desc = "Code Action (Rust)" }
              )
              vim.keymap.set("n", "<leader>cc", "<cmd>RustRunnables<cr>", { buffer = buffer, desc = "Rust runnables" })
            end
          end)
          local rust_opts = {
            server = vim.tbl_deep_extend("force", {
              settings = {
                ["rust-analyzer"] = {
                  checkOnSave = true,
                  check = {
                    command = "clippy",
                    features = "all",
                  },
                  lens = {
                    enable = true,
                  },
                  procMacro = {
                    enable = true,
                  },
                  cargo = {
                    features = "all",
                  },
                  rustfmt = {
                    extraArgs = { "+nightly" },
                  },
                },
              },
            }, opts, opts.server or {}),
            tools = { -- rust-tools options
              -- options same as lsp hover / vim.lsp.util.open_floating_preview()
              hover_actions = {
                -- whether the hover action window gets automatically focused
                auto_focus = true,
              },
            },
          }
          require("rust-tools").setup(rust_opts)
          return true
        end,
      },
    },
  },

  {
    "saecki/crates.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup({
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      })
    end,
  },
}
