local M = {}

function M.setup()
	require("presence"):setup({
			auto_update         = true,
			debounce_timeout    = 20,
			neovim_image_text   = "nano hater btw",
			main_image          = "file",
			enable_line_number  = false,
			buttons             = true,

			editing_text        = "editing %s",
			file_explorer_text  = "browsing %s",
			git_commit_text     = "committing changes",
			plugin_manager_text = "managing plugins",
			reading_text        = "reading %s",
			workspace_text      = "working on %s",
			line_number_text    = "line %s out of %s",
	})
end

return M
