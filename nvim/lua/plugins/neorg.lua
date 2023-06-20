return {
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
}
