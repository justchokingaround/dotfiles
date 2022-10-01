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
		
		-- Load only when required
		use {
			"nvim-lua/plenary.nvim",
			module = "plenary",
		}

    -- Colorscheme
		use {
			'Mofiqul/vscode.nvim',
			config = function()
				vim.cmd "colorscheme vscode"
			end,
		}

    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }

    -- Git
    use {
      "TimUntersberger/neogit",
			cmd = "Neogit",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("config.neogit").setup()
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

		-- Indent line
		use {
			"lukas-reineke/indent-blankline.nvim",
			event = "BufReadPre",
			config = function()
				require("config.indentblankline").setup()
			end,
		}

		-- Status line
		use {
			"nvim-lualine/lualine.nvim",
			event = "VimEnter",
			config = function()
			 require("config.lualine").setup()
			end,
			requires = { "nvim-web-devicons" },
		}

		-- Bufferline
		use {
			"akinsho/bufferline.nvim",
			event = "VimEnter",
			config = function()
				require("config.bufferline").setup()
			end,
			requires = "kyazdani42/nvim-web-devicons",
		}

		-- Treesitter
		use {
			"nvim-treesitter/nvim-treesitter",
			 run = ":TSUpdate",
			 config = function()
				 require("config.treesitter").setup()
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

		-- Better comments
		use {
			"numToStr/Comment.nvim",
			opt = true,
			keys = { "gc", "gcc", "gbc" },
			config = function()
				require("Comment").setup()
			end,
		}

		-- Easy hopping
		use {
			"phaazon/hop.nvim",
			cmd = { "HopWord", "HopChar1" },
			config = function()
				require("config.hop").setup()
			end,
		}

		-- Easy motion
		use {
			"ggandor/lightspeed.nvim",
			keys = { "f", "F", "t", "T", "s", "S" },
			config = function()
				require("lightspeed").setup()
			end,
		}

		-- NvimTree
		use {
			"kyazdani42/nvim-tree.lua",
			cmd = "NvimTreeToggle",
			config = function()
				require("config.nvim-tree").setup()
			end,
		}

		-- Telescope
		use {
			"nvim-telescope/telescope.nvim",
			cmd = "Telescope",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-lua/popup.nvim" },
			},
			config = function()
				require("config.telescope").setup()
			end,
		}

		-- Discord rich presence
		use {
			"andweeb/presence.nvim",
			config = function()
				require("config.presence").setup()
			end,
		}

		-- Markdown
		use {
			"iamcco/markdown-preview.nvim",
			run = function()
				vim.fn["mkdp#util#install"]()
			end,
			ft = "markdown",
			cmd = "MarkdownPreview",
		}

		-- Copilot
		use {
			"github/copilot.vim"
		}
		
		-- Colors
		use {
			"norcalli/nvim-colorizer.lua",
		}

    -- Bootstrap Neovim
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
