return {
	{
		"L3MON4D3/LuaSnip",
		event = "VeryLazy",
		-- Disable default <tab> and <s-tab> behavior in LuaSnip
		keys = function()
			return {}
		end,
	},
	{
		"github/copilot.vim",
		event = "VeryLazy",
		config = function()
			vim.g.copilot_filetypes = {
				["TelescopePrompt"] = false,
				-- rust = false,
			}

			vim.cmd([[
        let g:copilot_assume_mapped = v:true
      ]])
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			local Util = require("lazyvim.util")
			table.insert(opts.sections.lualine_x, 2, {
				function()
					local icon = require("lazyvim.config").icons.kinds.Copilot
					return icon
				end,
				cond = function()
					local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
					return ok and #clients > 0
				end,
				color = function()
					return Util.ui.fg("Special")
				end,
			})
		end,
	},
}
