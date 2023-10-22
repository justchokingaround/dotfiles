return {
	-- MINI
	{ "echasnovski/mini.ai" },
	{ "echasnovski/mini.comment" },
	{ "echasnovski/mini.indentscope" },
	-- { "echasnovski/mini.pairs" },
	{
		"famiu/bufdelete.nvim",
		config = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "BDeletePost*",
				callback = function(event)
					local fallback_name = vim.api.nvim_buf_get_name(event.buf)
					local fallback_ft = vim.api.nvim_buf_get_option(event.buf, "filetype")
					local fallback_on_empty = fallback_name == "" and fallback_ft == ""
					if fallback_on_empty then
						require("neo-tree").close_all()
						vim.cmd(event.buf .. "bwipeout")
					end
				end,
			})
		end,
	},

	-- NEO-TREE
	{
		"nvim-neo-tree/neo-tree.nvim",
		keys = {
			{
				"<leader>e",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
				end,
				desc = "Explorer",
			},
		},
		opts = {
			close_if_last_window = true,
			filesystem = {
				follow_current_file = true,
				group_empty_dirs = true,
			},
			use_popups_for_input = true,
			popup_border_style = "rounded",
			default_component_configs = {
				indent = { with_markers = false },
				name = {
					use_git_status_colors = false, -- removes the goofy orange default color
				},
				git_status = {
					symbols = {
						deleted = "",
						renamed = "凜",
						untracked = "",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},
			},
			mappings = {
				["<space>"] = {
					"toggle_node",
					nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
				},
				["<cr>"] = "open",
				["<esc>"] = "revert_preview",
				["P"] = { "toggle_preview", config = { use_float = true } },
				["l"] = "focus_preview",
				["S"] = "open_split",
				["s"] = "open_vsplit",
				["t"] = "open_tabnew",
				["w"] = "open_with_window_picker",
				["C"] = "close_node",
				["z"] = "close_all_nodes",
				["a"] = {
					"add",
					config = {
						show_path = "none", -- "none", "relative", "absolute"
					},
				},
				["A"] = "add_directory",
				["d"] = "delete",
				["r"] = "rename",
				["y"] = "copy_to_clipboard",
				["x"] = "cut_to_clipboard",
				["p"] = "paste_from_clipboard",
				["c"] = "copy",
				["m"] = "move",
				["q"] = "close_window",
				["R"] = "refresh",
				["?"] = "show_help",
				["<"] = "prev_source",
				[">"] = "next_source",
			},
			window = {
				mappings = {
					["<bs>"] = "navigate_up",
					["."] = "set_root",
					["H"] = "toggle_hidden",
					["/"] = "fuzzy_finder",
					["D"] = "fuzzy_finder_directory",
					["#"] = "fuzzy_sorter",
					["f"] = "filter_on_submit",
					["<c-x>"] = "clear_filter",
					["[g"] = "prev_git_modified",
					["]g"] = "next_git_modified",
				},
			},
		},
	},

	-- TELESCOPE
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		cmd = "Telescope",
		opts = {
			defaults = {
				sorting_strategy = "ascending",
				prompt_prefix = "   ",
				selection_caret = "  ",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				winblend = 0,
				mappings = {
					i = {
						["<C-j>"] = function(...)
							return require("telescope.actions").move_selection_next(...)
						end,
						["<C-k>"] = function(...)
							return require("telescope.actions").move_selection_previous(...)
						end,
						["<C-p>"] = function(...)
							return require("telescope.actions.layout").toggle_preview(...)
						end,
					},
					n = {
						["j"] = function(...)
							return require("telescope.actions").move_selection_next(...)
						end,
						["k"] = function(...)
							return require("telescope.actions").move_selection_previous(...)
						end,
						["gg"] = function(...)
							return require("telescope.actions").move_to_top(...)
						end,
						["G"] = function(...)
							return require("telescope.actions").move_to_bottom(...)
						end,
						["<C-p>"] = function(...)
							return require("telescope.actions.layout").toggle_preview(...)
						end,
					},
				},
			},
		},
	},

	-- SYMBOLS-OUTLINE
	{
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
		keys = {
			{
				"<leader>cs",
				"<cmd>SymbolsOutline<cr>",
				desc = "Symbols Outline",
			},
		},
		config = function()
			local icons = require("lazyvim.config").icons
			require("symbols-outline").setup({
				symbols = {
					File = { icon = icons.kinds.File, hl = "TSURI" },
					Module = { icon = icons.kinds.Module, hl = "TSNamespace" },
					Namespace = { icon = icons.kinds.Namespace, hl = "TSNamespace" },
					Package = { icon = icons.kinds.Package, hl = "TSNamespace" },
					Class = { icon = icons.kinds.Class, hl = "TSType" },
					Method = { icon = icons.kinds.Method, hl = "TSMethod" },
					Property = { icon = icons.kinds.Property, hl = "TSMethod" },
					Field = { icon = icons.kinds.Field, hl = "TSField" },
					Constructor = { icon = icons.kinds.Constructor, hl = "TSConstructor" },
					Enum = { icon = icons.kinds.Enum, hl = "TSType" },
					Interface = { icon = icons.kinds.Interface, hl = "TSType" },
					Function = { icon = icons.kinds.Function, hl = "TSFunction" },
					Variable = { icon = icons.kinds.Variable, hl = "TSConstant" },
					Constant = { icon = icons.kinds.Constant, hl = "TSConstant" },
					String = { icon = icons.kinds.String, hl = "TSString" },
					Number = { icon = icons.kinds.Number, hl = "TSNumber" },
					Boolean = { icon = icons.kinds.Boolean, hl = "TSBoolean" },
					Array = { icon = icons.kinds.Array, hl = "TSConstant" },
					Object = { icon = icons.kinds.Object, hl = "TSType" },
					Key = { icon = icons.kinds.Key, hl = "TSType" },
					Null = { icon = icons.kinds.Null, hl = "TSType" },
					EnumMember = { icon = icons.kinds.EnumMember, hl = "TSField" },
					Struct = { icon = icons.kinds.Struct, hl = "TSType" },
					Event = { icon = icons.kinds.Event, hl = "TSType" },
					Operator = { icon = icons.kinds.Operator, hl = "TSOperator" },
					TypeParameter = { icon = icons.kinds.TypeParameter, hl = "TSParameter" },
				},
			})
		end,
	},

	-- ACCELERATED-JK
	{
		"rainbowhxch/accelerated-jk.nvim",

		config = function()
			require("accelerated-jk").setup({
				mode = "time_driven",
				enable_deceleration = false,
				acceleration_motions = {},
				acceleration_limit = 75,
				acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
				deceleration_table = { { 150, 9999 } },
			})
		end,
	},

	-- TERMINAL
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				size = 20,
				highlights = {
					Normal = { guibg = "#161616" },
					NormalFloat = { link = "Normal" },
					FloatBorder = { guifg = "#ee5396", guibg = "#161616" },
				},
				hide_numbers = true,
				start_in_insert = true,
				direction = "float",
				close_on_exit = true,
				shell = "/usr/bin/zsh",
				float_opts = { border = "curved" },
			})
		end,
	},

	-- HOP
	{
		"phaazon/hop.nvim",
		event = { "CursorHold", "CursorHoldI" },
		config = function()
			require("hop").setup()
		end,
		keys = {
			{ "gh", "<cmd>HopWord<cr>",    desc = "Hop to word" },
			{ "s",  "<cmd>HopPattern<cr>", desc = "Hop to pattern" },
			{ "f",  "<cmd>HopChar1<cr>",   desc = "Hop to char" },
		},
	},

	-- TODO: customize edgy for vscode like experience
	-- EDGY
	{
		"folke/edgy.nvim",
		keys = {
			{
				"<leader>uE",
				function()
					require("edgy").select()
				end,
				desc = "Edgy Select Window",
			},
			{
				"<leader>ue",
				function()
					require("edgy").toggle()
				end,
				desc = "Edgy Toggle",
			},
		},
		event = "VeryLazy",
		init = function()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
		end,
		opts = {
			wo = {
				spell = false,
			},
			animate = {
				enabled = false,
			},
		},
	},
	-- NVIM-RECORDER
	-- Enhance the usage of macros in Neovim.
	{
		"chrisgrieser/nvim-recorder",
		dependencies = "rcarriga/nvim-notify",
		opts = {},
	},
}
