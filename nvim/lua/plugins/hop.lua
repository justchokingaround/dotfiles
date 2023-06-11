return {
  "phaazon/hop.nvim",
  config = function()
    require("hop").setup({
      current_line_only = true,
      jump_on_sole_occurrence = true,
    })
  end,
}
