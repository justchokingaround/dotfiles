return {
  "jackMort/ChatGPT.nvim",
  enabled = false,
  config = function()
    require("chatgpt").setup({
      openai_params = {
        model = "gpt-3.5-turbo",
      },
    })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
