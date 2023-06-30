local M = {}

local util = require("config.utils")

---@param plugins ({[1]: string, opts: table}|string)[]
---@param ft_covered string[]
M.neotest_extension_spec = function(plugins, ft_covered)
  -- We don't want to add the dep at all if neotest isn't enabled
  -- TODO: check if require("lazy.core.config").spec has the information we're trying to hack around with this global
  if type(NeotestLayerEnabled) == nil or NeotestLayerEnabled ~= true then
    return {}
  end

  local dependencies = {}
  for _, spec in ipairs(plugins) do
    local plugin_name = type(spec) == string and spec or spec[1]
    table.insert(dependencies, plugin_name)
  end

  local r = {
    "nvim-neotest/neotest",
    cond = function()
      return require("lazyvim.util").has("neotest")
    end,
    dependencies = dependencies,
    opts = function(_, opts)
      if opts.adapters == nil then
        opts.adapters = {}
      end
      if opts.vimtest_ignore == nil then
        opts.vimtest_ignore = {}
      end

      for _, spec in ipairs(plugins) do
        -- Split string in domain/name
        local plugin_name = type(spec) == string and spec or spec[1]
        ---@diagnostic disable-next-line: param-type-mismatch (type inferrence is wrong)
        local _, rname = plugin_name:match("([^/]+)/([^/]+)")
        local mod = require(rname)
        if spec.opts == nil then
          table.insert(opts.adapters, mod)
        else
          table.insert(opts.adapters, mod(opts))
        end
      end
      util.list_insert_unique(opts.vimtest_ignore, ft_covered)
    end,
  }
  return r
end

return M
