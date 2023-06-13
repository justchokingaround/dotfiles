return {
  "folke/noice.nvim",
  event = "VimEnter", -- Load on VimEnter to prevent blocking (_press enter to..._) notifications on startup
  priority = 1000, -- An attempt to make noice load before any blocking message comes in (from lazy).
  opts = {
    presets = {
      command_palette = true,
      bottom_search = false,
      long_message_to_split = true, -- long messages will be sent to a split
    },
  },
}
