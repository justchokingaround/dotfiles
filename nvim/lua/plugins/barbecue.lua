return {
  "utilyre/barbecue.nvim", -- Wait for my PR to get merged
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = {
    -- The navic config that ships with Lazyvim already attaches
    -- for us, besides `barbecue/issue#35`
    attach_navic = false,
    -- Window number as leading section
    lead_custom_section = function(_, winnr)
      return string.format("%d || ", vim.api.nvim_win_get_number(winnr))
    end,

    exclude_filetypes = {
      "DressingInput",
      "neo-tree",
      "toggleterm",
      "Trouble",
    },
  },
}
