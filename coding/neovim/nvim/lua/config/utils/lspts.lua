local M = {}

M.NON_LSP_CLIENTS = { "", "copilot", "null-ls", "luasnip" }

local logger = require("config.utils").logger

M.get_active_lsp = function()
  for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
    if not vim.tbl_contains(M.NON_LSP_CLIENTS, client.name) then
      return client.name
    end
  end
  return nil
end

function M.is_treesitter_active()
  local buf = vim.api.nvim_get_current_buf()
  local highlighter = require("vim.treesitter.highlighter")
  if highlighter.active[buf] then
    return true
  end
  return false
end

return M
