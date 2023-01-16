return {
  ["nyoom-engineering/oxocarbon.nvim"] = {},
  ["github/copilot.vim"] = {},
  ["folke/which-key.nvim"] = {
    disable = false,
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["williamboman/mason.nvim"] = {
    override_options = {
      ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- web dev
        "json-lsp",

        -- python
        "pyright",
        "black",

        -- rust
        "rust-analyzer",
        -- shell
        "shfmt",
        "shellcheck",

        -- C/C++
        "clangd",
        "clang-format",
      },
    },
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },
  ["tpope/vim-fugitive"] = {
    disable = false,
  },
  ["nvim-treesitter/nvim-treesitter"] = {
    config = function()
      require "plugins.configs.treesitter"
      require "custom.plugins.treesitter"
    end,
  },
}
