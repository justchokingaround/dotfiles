local M = {}

function M.setup()

	vim.g.copilot_no_tab_map = true
	vim.api.nvim_set_keymap("i", "<C-h>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
	vim.g.copilot_filetypes = {
		["*"] = true,
		["lua"] = true,
		[ "go" ] = false,
		["rust"] = true,
		["c"] = false,
		["python"] = false,
		["java"] = true,
	}

end

return M
