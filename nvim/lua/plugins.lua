local M = {}

function M.setup()
	-- Indicate first time installation
	local packer_bootstrap = false

	-- packer.nvim configuration
	local conf = {
		profile = {
			enable = true,
			threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
		},

		display = {
			open_fn = function()
				return require("packer.util").float { border = "rounded" }
			end,
		},
	}

	-- Check if packer.nvim is installed
	-- Run PackerCompile if there are changes in this file
	local function packer_init()
		local fn = vim.fn
		local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
		if fn.empty(fn.glob(install_path)) > 0 then
			packer_bootstrap = fn.system {
				"git",
				"clone",
				"--depth",
				"1",
				"https://github.com/wbthomason/packer.nvim",
				install_path,
			}
			vim.cmd [[packadd packer.nvim]]
		end
		vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
	end

	-- Plugins
	local function plugins(use)
		use { "wbthomason/packer.nvim" }
		use { "nvim-lua/plenary.nvim", module = "plenary" }
		use { "lewis6991/impatient.nvim" }

		-- Autocompletion
		use {
			"hrsh7th/cmp-buffer",
		}
		use {
			"hrsh7th/cmp-nvim-lsp",
		}
		use {
			"hrsh7th/nvim-cmp",
			config = function()
				require("config.cmp").setup()
			end,
		}
		use {
			"danymat/neogen",
			config = function()
				require('neogen').setup {}
			end,
			requires = "nvim-treesitter/nvim-treesitter",
		}

		-- Autopair
		use {
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup()
			end,
		}

		-- Better Comment
		use {
			"numToStr/Comment.nvim",
			opt = true,
			keys = { "gc", "gcc", "gbc" },
			config = function()
				require("Comment").setup {}
			end,
		}

		-- Better icons
		use {
			"kyazdani42/nvim-web-devicons",
			module = "nvim-web-devicons",
			config = function()
				require("nvim-web-devicons").setup { default = true }
			end,
		}

		-- Bufferline
		use {
			"akinsho/bufferline.nvim",
			tag = "v2.*",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("bufferline").setup {}
			end,
		}

		-- Colorscheme
		-- use {
		-- 	"lunarvim/synthwave84.nvim",
		-- }
		-- use {
		-- 	"akai54/2077.nvim",
		-- 	config = function()
		-- 		vim.cmd "colorscheme 2077"
		-- 	end,
		-- }
		use {
			"projekt0n/github-nvim-theme",
			config = function()
				vim.cmd "colorscheme github_dark"
			end,
		}

		-- Colorizer
		use {
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup()
			end,
		}

		-- Cockpilot
		use {
			"github/copilot.vim",
			config = function()
				require("config.cockpilot").setup()
			end
		}

		-- Code runner
		use {
			"CRAG666/code_runner.nvim",
			config = function()
				require("config.code_runner").setup()
			end,
		}

		-- Dap
		use {
			"mfussenegger/nvim-dap",
			config = function()
				require("config.dap").setup()
			end,
		}
		-- use {
		-- 	"rcarriga/nvim-dap-ui",
		-- 	requires = "mfussenegger/nvim-dap",
		-- }
		-- use {
		-- 	"theHamsta/nvim-dap-virtual-text",
		-- 	requires = "mfussenegger/nvim-dap",
		-- }
		-- use {
		-- 	"nvim-telescope/telescope-dap.nvim",
		-- }

		-- Discord Presence
		use {
			"andweeb/presence.nvim",
			config = function()
				require("config.presence").setup()
			end,
		}

		-- Easy hopping
		use {
			"phaazon/hop.nvim",
			cmd = { "HopWord", "HopChar1" },
			config = function()
				require("hop").setup {}
			end,
		}

		-- Easy motion
		use {
			"ggandor/lightspeed.nvim",
			keys = { "f", "F", "t", "T" },
			config = function()
				require("lightspeed").setup {}
			end,
		}

		-- Git
		use {
			"kdheepak/lazygit.nvim"
		}
		use {
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("config.gitsigns").setup()
			end,
		}


		-- IndentLine
		use {
			"lukas-reineke/indent-blankline.nvim",
			event = "BufReadPre",
			config = function()
				require("config.indentblankline").setup()
			end,
		}

		-- Lualine
		use {
			"nvim-lualine/lualine.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("config.lualine").setup()
			end,
		}

		-- Lsp stuff
		use {
			"neovim/nvim-lspconfig",
			config = function()
				require("config.lsp")
			end,
		}
		use {
			"jose-elias-alvarez/null-ls.nvim",
		}
		use {
			"RRethy/vim-illuminate",
		}
		use {
			"williamboman/mason.nvim",
			config = function()
				require("config.lsp.mason").setup()
			end,
		}
		use {
			"williamboman/mason-lspconfig.nvim",
		}

		--- nnn
		use {
			"luukvbaal/nnn.nvim",
			config = function()
				require("nnn").setup()
			end
		}

		-- Snippets
		use {
			"L3MON4D3/LuaSnip",
		}
		use {
			"rafamadriz/friendly-snippets",
		}

		-- Startup screen
		use {
			"goolord/alpha-nvim",
			on = "VimEnter",
			config = function()
				require("config.alpha").setup()
			end,
		}

		-- Telescope
		use {
			"nvim-telescope/telescope.nvim",
			config = function()
				require("config.telescope").setup()
			end,
		}

		-- Terminal
		use {
			"akinsho/nvim-toggleterm.lua",
			config = function()
				require("config.toggleterm").setup()
			end,
		}

		-- Treesitter
		use {
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = function()
				require("config.treesitter").setup()
			end,
		}

		-- WhichKey
		use {
			"folke/which-key.nvim",
			event = "VimEnter",
			config = function()
				require("config.whichkey").setup()
			end,
		}

		if packer_bootstrap then
			print "Restart Neovim required after installation!"
			require("packer").sync()
		end
	end

	packer_init()

	local packer = require "packer"
	packer.init(conf)
	packer.startup(plugins)
end

return M
