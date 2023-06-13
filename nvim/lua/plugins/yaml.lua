return {

  -- add json to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "yaml" })
      end
    end,
  },

  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "SchemaStore.nvim",
    },
    opts = {
      -- make sure mason installs the server
      servers = {
        yamlls = {
          -- lazy-load schemastore when needed
          -- on_new_config = function(new_config)
          --   new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
          --   vim.list_extend(new_config.settings.yaml.schemas, require("schemastore").yaml.schemas())
          -- end,
          settings = {
            yaml = {
              keyOrdering = false,
              format = {
                enable = true,
              },
              validate = { enable = true },
            },
          },
        },
      },
    },
  },
}
