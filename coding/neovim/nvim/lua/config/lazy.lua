local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
	spec = {
		{
			"LazyVim/LazyVim",
			import = "lazyvim.plugins",
		},

		{ import = "lazyvim.plugins.extras.lang.typescript" },
		{ import = "lazyvim.plugins.extras.lang.json" },
		{ import = "lazyvim.plugins.extras.lang.go" },
		{ import = "lazyvim.plugins.extras.lang.java" },
		{ import = "lazyvim.plugins.extras.lang.rust" },
		{ import = "lazyvim.plugins.extras.test.core" },
		{ import = "lazyvim.plugins.extras.util.project" },
		{ import = "lazyvim.plugins.extras.ui.edgy" },
		{ import = "lazyvim.plugins.extras.linting.eslint" },
		{ import = "lazyvim.plugins.extras.formatting.prettier" },

		{ import = "plugins" },
	},
	defaults = {
		lazy = false,
		version = false, -- always use the latest git commit
	},
	install = { colorscheme = { "oxocarbon" } },
	checker = { enabled = true }, -- automatically check for plugin updates
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
