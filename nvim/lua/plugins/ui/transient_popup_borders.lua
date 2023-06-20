local WIN_HIGHLIGHT = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:Search"

-- Enable borders for nvim-cmp and noice.nvim popups (includes autocomplete, lsp hover, etc.)
return {
  {
    "nvim-cmp",
    opts = {
      window = {
        completion = require("cmp.config.window").bordered({ winhighlight = WIN_HIGHLIGHT }),
        documentation = require("cmp.config.window").bordered({ winhighlight = WIN_HIGHLIGHT }),
        preview = require("cmp.config.window").bordered({ winhighlight = WIN_HIGHLIGHT }),
      },
    },
  },
}
