return {
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
}
