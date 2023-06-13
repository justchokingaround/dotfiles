return {
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
}
