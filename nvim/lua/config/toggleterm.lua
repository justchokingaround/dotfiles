local M = {}

function M.setup()
  require("toggleterm").setup {
    size = 20,
    hide_numbers = true,
    open_mapping = [[<C-e>]],
    shade_filetypes = {},
    shade_terminals = false,
    shading_factor = 0.3,
    start_in_insert = true,
    persist_size = true,
    direction = "float",
  }
end

return M
