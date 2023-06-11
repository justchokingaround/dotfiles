return {
  "TimUntersberger/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- "sindrets/diffview.nvim",
  },
  opts = {
    signs = {
      -- { CLOSED, OPENED }
      section = { "󰕏", "󰕎" },
      item = { "󰕏", "󰕎" },
      hunk = { "", "" },
    },
  },
}
