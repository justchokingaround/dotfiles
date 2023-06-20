return {
  "folke/noice.nvim",
  event = "VimEnter", -- Load on VimEnter to prevent blocking (_press enter to..._) notifications on startup
  config = function()
    require("noice").setup({
      cmdline = {
        format = {
          cmdline = { pattern = "^:", icon = " ", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
          help = { pattern = "^:%s*h%s+", icon = "" },
        },
      },
      opts = {
        views = {
          cmdline_popup = {
            position = { row = 0, col = "50%" },
            size = { width = "98%" },
          },
        },
        win_options = {
          winhighlight = {
            Normal = "NormalFloat",
            FloatBorder = "FloatBorder",
          },
        },
        presets = { long_message_to_split = true, lsp_doc_border = false },
        popupmenu = { backend = "cmp" },
        format = {},
        lsp = {
          progress = { enabled = true },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
      },
    })
  end,
}
