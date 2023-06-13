return {
  "stevearc/overseer.nvim",
  config = function()
    require("overseer").setup()
  end,
  cmd = { "OverseerRun", "OverseerRestartLast", "OverseerToggle" },
}
