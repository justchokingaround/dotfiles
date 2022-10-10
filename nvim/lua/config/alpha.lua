local M = {}

function M.setup()
	local status_ok, alpha = pcall(require, "alpha")
	if not status_ok then
		return
	end

	local dashboard = require "alpha.themes.dashboard"
	dashboard.section.header.val = {
		[[                                                                   ]],
		[[      ████ ██████           █████      ██                    ]],
		[[     ███████████             █████                            ]],
		[[     █████████ ███████████████████ ███   ███████████  ]],
		[[    █████████  ███    █████████████ █████ ██████████████  ]],
		[[   █████████ ██████████ █████████ █████ █████ ████ █████  ]],
		[[ ███████████ ███    ███ █████████ █████ █████ ████ █████ ]],
		[[██████  █████████████████████ ████ █████ █████ ████ ██████]],

	}


	dashboard.section.footer.opts.hl = "Type"
	dashboard.section.header.opts.hl = "Include"
	dashboard.section.buttons.opts.hl = "Keyword"

	dashboard.opts.opts.noautocmd = true
	alpha.setup(dashboard.opts)


	dashboard.section.buttons.val = {
		dashboard.button("r", " " .. " recent files", ":Telescope oldfiles <CR>"),
		dashboard.button("g", " " .. " git status", ":Telescope git_status<CR>"),
		dashboard.button("c", " " .. " config", ":e ~/.config/nvim/init.lua <CR>"),
		dashboard.button("q", "q " .. " quit", ":qa<CR>"),
	}
end

return M
