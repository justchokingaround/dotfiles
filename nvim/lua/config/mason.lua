local M = {}

function M.setup()

	require("mason").setup({
			ui = {
					icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗"
					}
			}
	})

end

return M
