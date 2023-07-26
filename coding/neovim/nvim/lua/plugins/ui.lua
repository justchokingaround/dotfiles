return {
	-- COLORSCHEMES
	{
		"nyoom-engineering/oxocarbon.nvim",
	},

	-- ALPHA
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = [[
    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣛⡝⡙⢍⠫⡛⢟⠟⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢟⣫⣾⣾⡷⣗⣮⡲⣅⣂⢢⢨⠨⠠⢈⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢟⣵⡿⣟⡯⡟⢽⢹⢪⢪⢮⢪⢎⣗⣝⠨⠠⡙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢣⢟⣗⣏⢧⡳⢪⢪⢯⠪⣪⡺⣕⢧⣳⣳⡳⣕⡌⡜⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⣻⢮⢮⣳⢝⠮⡢⢇⠧⡳⣝⢮⡳⣕⢗⣟⣞⢮⡪⢺⣿⣿⣿⣿⣿⣿⣿⣿⣿
    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⡮⡯⠏⠋⠁⠄⡄⠠⠀⡀⠀⢀⠈⠈⠊⢕⢗⣯⡳⡽⣘⣿⣿⣿⣿⣿⣿⣯⡿⣿
    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⢱⠕⠀⠐⠈⠀⡈⡝⡀⠠⠀⠌⠀⠀⠀⠄⠀⠙⡮⡫⡯⡲⣿⣿⣿⣿⣿⣷⣯⡯⣿
    ⣿⣿⣿⣿⡿⣯⣟⡯⣿⡸⠁⠐⠈⠀⢠⠀⠈⣜⣄⢤⡨⡄⠀⠠⠀⠀⠀⢟⢜⢎⣺⣿⣿⣿⣿⣿⢿⣺⢯⢿
    ⣿⣿⣯⣷⣿⣟⡮⣞⡵⡕⠀⠁⠀⠀⢬⣢⢮⡿⣾⣻⣽⣟⣦⡵⠀⠌⠈⠄⢝⠐⣼⣿⣿⣿⣿⡯⣻⡪⡯⣫
    ⣿⢯⡿⣿⣯⡿⡮⣳⣝⣇⢐⡀⠀⠈⠠⣟⣿⣻⣯⢿⡾⣯⡷⡟⠀⠂⠀⠅⡂⢌⣺⡿⣿⣻⣟⣟⢞⢮⢯⡺
    ⡯⣏⢯⢗⣗⢯⡻⣪⢞⢮⠢⠨⠠⠁⠄⠈⠙⠾⣯⣷⡿⠝⡋⠀⠐⠀⠀⠡⡐⣰⢯⣟⢞⢮⣺⡪⡯⣳⡳⡽
    ⡯⡮⣫⡳⣳⢝⡮⣳⡫⡯⡳⣅⠅⡡⢁⡡⠦⠀⢀⠁⠐⠌⠌⠐⠀⢰⡼⡐⣸⡺⣝⡮⡯⣳⡳⣝⣞⡵⡯⣺
    ⡏⣞⢜⢜⠸⡨⣫⢞⣽⡺⣝⢮⣳⠠⢹⡀⠀⠀⠀⠀⠀⠀⠀⠀⠂⢱⠬⡀⣺⣺⣳⡽⣝⢮⣺⢵⣳⣿⣯⣗
    ⡓⡧⡣⡢⡱⡘⣝⣗⣽⡯⡺⡕⡣⡣⠘⠀⠀⠀⠀⠀⠀⢀⠀⠠⠀⠀⢃⠄⣢⢻⣿⣝⢮⣳⣝⡷⣽⣿⣿⣗
    ⣳⣻⣳⣷⣳⣕⣗⢵⣿⡟⡍⣮⡺⡌⠄⠀⠀⠀⠀⠀⠈⠀⠀⠀⢀⡴⣝⢥⡪⡺⡜⣷⣿⣷⣯⢫⢳⣟⡿⣟
    ⣿⣿⣿⣿⣿⣿⣾⢽⡟⡜⡞⡮⣺⣽⣢⡀⠀⠀⠀⠄⠀⠀⠀⣔⡯⣞⢮⡳⣝⢎⢧⡣⡻⣿⡪⡘⡸⠸⡽⣗
    ⣿⣿⣿⣿⣟⣿⡿⣽⢣⢮⢹⢪⢗⢿⡽⣗⣄⠠⠀⠀⠀⢠⣻⡽⣽⣺⡳⡻⡪⣫⢪⡪⡢⣻⡆⣷⠕⡕⣝⣯
    ⣿⣿⣿⣿⣟⣾⣟⡯⡪⡮⡳⣝⢮⢧⢯⣪⢺⢔⠀⠐⠨⡩⡎⡾⣜⡦⣗⣵⡻⡮⡪⡮⣣⢚⡷⣽⢧⢯⡺⣷
    ⣿⣿⣿⡯⡷⣿⣿⢃⢯⢺⣕⣗⡯⡿⣝⢾⡸⣸⠀⠐⠈⢧⢳⣝⢮⢯⣗⣗⡯⣯⡺⣝⢮⡢⣻⣿⡽⣕⢯⢏
    ⣿⡯⡷⣝⢮⣷⡟⡸⡕⡧⣳⡳⡽⣝⡗⣽⡺⡜⠀⢀⠀⢱⣣⡳⣝⡯⣞⡾⣽⢳⢝⢮⡳⡕⡜⣿⡯⡮⡳⣕
    ⡯⡯⣞⢮⣳⡻⣘⢮⣫⢺⡪⡎⡯⣺⢕⢷⢝⠎⠀⠀⠀⠐⣕⢧⢳⡫⣗⢯⢿⡸⡕⡗⣟⡜⣕⢽⡿⣝⣝⢮
    ⡯⣚⢮⠣⢣⠱⡸⣕⢯⢺⢸⢪⣚⢮⡳⣹⢽⠁⠀⠀⠂⠀⢯⡳⡝⡞⣎⢏⢿⢜⢎⡯⡪⣎⢮⠪⣟⢮⢮⡳
    ⡯⣪⡳⡑⢅⢕⡝⣮⢳⢹⢸⢪⢪⡪⡺⢼⡝⠀⠀⠀⠀⠀⢹⢜⢎⢮⢪⢎⢯⡳⡱⡝⡜⡮⡪⡣⢱⢣⢓⢍
    ]]

			dashboard.section.header.val = vim.split(logo, "\n")
			dashboard.section.buttons.val = {
				dashboard.button("f", " " .. " find file", ":Telescope find_files <CR>"),
				dashboard.button("r", " " .. " recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("p", " " .. " projects", ":Telescope projects <CR>"),
				dashboard.button("g", " " .. " find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", " " .. " open config", ":e $MYVIMRC <CR>"),
				dashboard.button("s", " " .. " restore session", [[:lua require("persistence").load() <cr>]]),
				dashboard.button("l", "󰒲 " .. " lazy", ":Lazy<CR>"),
				dashboard.button("q", " " .. " quit", ":qa<CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.section.footer.opts.hl = "AlphaFooter"
			dashboard.opts.layout[1].val = 8
			return dashboard
		end,
		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},

	-- BUFFERLINE
	{
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				numbers = "none",
				close_command = "Bdelete! %d",
				right_mouse_command = "Bdelete! %d",
				max_name_length = 30,
				max_prefix_length = 30,
				show_buffer_icons = true,
				show_buffer_close_icons = false,
				show_close_icon = false,
				show_tab_indicators = true,
				separator_style = "thin",
				color_icons = false,
				diagnostics = false,
				highlights = {
					buffer_selected = {
						gui = "none",
					},
				},
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
					{
						filetype = "Outline",
						text = "Symbols Outline",
						highlight = "TSType",
						text_align = "left",
					},
				},
			},
		},
	},

	-- LUALINE
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			local function lsp_name(msg)
				msg = msg or "Inactive"
				local buf_clients = vim.lsp.get_active_clients()
				if next(buf_clients) == nil then
					if type(msg) == "boolean" or #msg == 0 then
						return "Inactive"
					end
					return msg
				end
				local buf_client_names = {}

				for _, client in pairs(buf_clients) do
					if client.name ~= "null-ls" then
						table.insert(buf_client_names, client.name)
					end
				end

				return table.concat(buf_client_names, ", ")
			end

			opts.sections = vim.tbl_deep_extend("force", opts.sections, {
				lualine_y = {
					{
						lsp_name,
						icon = "",
						color = { gui = "none" },
					},
					{
						"progress",
						separator = " ",
						padding = { left = 1, right = 0 }
					},
					{ "location", padding = { left = 0, right = 1 } },
				},
			})
		end,
	},

	-- ZEN MODE
	{
		"folke/zen-mode.nvim",
		opts = {
			plugins = {
				options = {
					enabled = true,
					ruler = false,
					showcmd = true,
				},
				wezterm = {
					enabled = true,
					font = "+2",
				},
			},
		},
	},

	-- COLORIZER
	{
		"norcalli/nvim-colorizer.lua", -- highlight colors #fff #ffa #a9423f
		opts = {
			["*"] = {
				RGB = true,
				RRGGBB = true,
				RRGGBBAA = true,
				rgb_fn = true,
				hsl_fn = true,
				css = true,
				css_fn = true,
			},
		},
	},

	-- DRESSING
	-- improve the look of neovim's default UI
	{ "stevearc/dressing.nvim" },

	-- NOICE
	{ "folke/noice.nvim" },

	-- NUI
	-- neovim UI components
	{ "MunifTanjim/nui.nvim" },

	-- ICONS
	{ "DaikyXendo/nvim-material-icon" },

	-- HYDRA
	{
		"anuvyklack/hydra.nvim",
		init = function()
			-- SIDE SCROLL
			require("hydra")({
				name = "Side scroll",
				mode = "n",
				body = "z",
				hint = "Side scroll",
				heads = {
					{ "h", "5zh" },
					{ "l", "5zl", { desc = "←/→" } },
					{ "H", "zH" },
					{ "L", "zL", { desc = "half screen ←/→" } },
				},
			})

			-- RUST
			require("hydra")({
				name = " Rust",
				hint = [[
		                 Rust

		  _r_: runnables      _m_: expand macro
		  _d_: debugabbles    _c_: open cargo
		  _s_: rustssr        _p_: parent module
		  _h_: hover actions  _w_: reload workspace
		  _D_: open docs      _g_: view create graph
		^
		  _i_: Toggle Inlay Hints   _<Esc>_: Exit
		    ]],
				config = {
					color = "amaranth",
					invoke_on_body = true,
					hint = {
						border = "rounded",
						position = "middle",
					},
				},
				mode = { "n", "x" },
				body = "<leader>r",
				heads = {
					{ "r",     function() vim.cmd("RustRunnables") end,        { exit = true } },
					{ "d",     function() vim.cmd("RustDebuggables") end,      { exit = true } },
					{ "s",     function() vim.cmd("RustSSR") end,              { exit = true } },
					{ "h",     function() vim.cmd("RustHoverActions") end,     { exit = true } },
					{ "D",     function() vim.cmd("RustOpenExternalDocs") end, { exit = true } },
					{ "m",     function() vim.cmd("RustExpandMacro") end,      { exit = true } },
					{ "c",     function() vim.cmd("RustOpenCargo") end,        { exit = true } },
					{ "p",     function() vim.cmd("RustParentModule") end,     { exit = true } },
					{ "w",     function() vim.cmd("RustReloadWorkspace") end,  { exit = true } },
					{ "g",     function() vim.cmd("RustViewCrateGraph") end,   { exit = true } },
					{ "i",     function() vim.cmd("RustToggleInlayHints") end },
					{ "<Esc>", nil,                                            { exit = true, nowait = true } },
				},

			})

			-- TELESCOPE
			require("hydra")({
				name = "Telescope",
				hint = [[
           _o_: old files   _g_: live grep
           _p_: projects    _/_: search in file
           _r_: resume      _f_: find files
   ▁
           _h_: vim help    _c_: execute command
           _k_: keymaps     _;_: commands history
           _O_: options     _?_: search history
  ^
  _<Esc>_         _<Enter>_: NvimTree
    ]],
				config = {
					color = "amaranth",
					invoke_on_body = true,
					hint = {
						border = "rounded",
						position = "middle",
					},
				},
				mode = { "n", "x" },
				body = "<leader>f",
				heads = {
					{ "o",       "<cmd>Telescope oldfiles<cr>",                  { exit = true } },
					{ "p",       "<cmd>Telescope projects<cr>",                  { exit = true } },
					{ "r",       "<cmd>Telescope resume<cr>",                    { exit = true } },
					{ "h",       "<cmd>Telescope help_tags<cr>",                 { exit = true } },
					{ "k",       "<cmd>Telescope keymaps<cr>",                   { exit = true } },
					{ "O",       "<cmd>Telescope vim_options<cr>",               { exit = true } },
					{ "g",       "<cmd>Telescope live_grep<cr>",                 { exit = true } },
					{ "/",       "<cmd>Telescope current_buffer_fuzzy_find<cr>", { exit = true } },
					{ "f",       "<cmd>Telescope find_files<cr>",                { exit = true } },
					{ "c",       "<cmd>Telescope commands<cr>",                  { exit = true } },
					{ ";",       "<cmd>Telescope command_history<cr>",           { exit = true } },
					{ "?",       "<cmd>Telescope search_history<cr>",            { exit = true } },
					{ "<Enter>", "<cmd>Neotree toggle<cr>",                      { exit = true } },
					{ "<Esc>",   nil,                                            { exit = true, nowait = true } },
				}
			})

			-- LSP
			require("hydra")({
				name = "LSP",
				hint = [[
					  			LSP Actions
^
	_a_: code action           _r_: rename
	_p_: preview definition    _P_: go to definition
	_t_: type definition       _K_: documentation
	_o_: outline               _d_: line diagnostics
^
										_<Esc>_
					]],
				config = {
					color = "amaranth",
					invoke_on_body = true,
					hint = {
						border = "rounded",
						position = "middle",
					},
				},
				mode = { "n", "x" },
				body = "<leader>l",
				heads = {
					{ "a",     "<cmd>Lspsaga code_action<cr>",           { exit = true } },
					{ "r",     "<cmd>Lspsaga rename<cr>",                { exit = true } },
					{ "p",     "<cmd>Lspsaga preview_definition<cr>",    { exit = true } },
					{ "P",     "<cmd>Lspsaga goto_definition<cr>",       { exit = true } },
					{ "t",     "<cmd>Lspsaga goto_type_definition<cr>",  { exit = true } },
					{ "K",     "<cmd>Lspsaga hover_doc<cr>",             { exit = true } },
					{ "o",     "<cmd>Lspsaga outline<cr>",               { exit = true } },
					{ "d",     "<cmd>Lspsaga show_line_diagnostics<cr>", { exit = true } },
					{ "<Esc>", nil,                                      { exit = true, nowait = true } },
				}
			})

			-- LAZY
			require("hydra")({
				name = "Lazy",
				hint = [[
		Lazy
^
		_i_ => install  _u_ => update
		_s_ => sync     _c_ => clean
		_L_ => log      _D_ => debug
		_p_ => profile  _h_ => help
^
		_<Esc>_ _<Enter>_: Lazy
					]],
				config = {
					color = "amaranth",
					invoke_on_body = true,
					hint = {
						border = "rounded",
						position = "middle",
					},
				},
				mode = { "n", "x" },
				body = "<leader>L",
				heads = {
					{ "i",       "<cmd>Lazy install<cr>", { exit = true } },
					{ "u",       "<cmd>Lazy update<cr>",  { exit = true } },
					{ "s",       "<cmd>Lazy sync<cr>",    { exit = true } },
					{ "c",       "<cmd>Lazy clean<cr>",   { exit = true } },
					{ "L",       "<cmd>Lazy log<cr>",     { exit = true } },
					{ "D",       "<cmd>Lazy debug<cr>",   { exit = true } },
					{ "p",       "<cmd>Lazy profile<cr>", { exit = true } },
					{ "h",       "<cmd>Lazy help<cr>",    { exit = true } },
					{ "<Enter>", "<cmd>Lazy<cr>",         { exit = true } },
					{ "<Esc>",   nil,                     { exit = true, nowait = true } },
				}
			})

			-- UI OPTIONS
			require("hydra")({
				name = "UI Options",
				hint = [[
      UI Options
		  ^
		  _v_ %{ve} virtual edit
		  _i_ %{list} invisible characters
		  _s_ %{spell} spell
		  _w_ %{wrap} wrap
		  _c_ %{cul} cursor line
		  _n_ %{nu} number
		  _r_ %{rnu} relative number
			_z_ %{ve} zen mode	
		  ^
	 	 _<Esc>_
		]],
				config = {
					color = "amaranth",
					invoke_on_body = true,
					hint = {
						border = "rounded",
						position = "middle",
					},
				},
				mode = { "n", "x" },
				body = "<leader>u",
				heads = {
					{ "n", function() vim.o.number = not vim.o.number end, { desc = "number" } },
					{
						"r",
						function() vim.o.relativenumber = not vim.o.relativenumber end,
						{ desc = "relativenumber" },
					},
					{
						"v",
						function()
							if vim.o.virtualedit == "all" then
								vim.o.virtualedit = "block"
							else
								vim.o.virtualedit = "all"
							end
						end,
						{ desc = "virtualedit" },
					},
					{ "i", function() vim.o.list = not vim.o.list end,     { desc = "show invisible" } },
					{ "s", function() vim.o.spell = not vim.o.spell end,   { exit = true, desc = "spell" } },
					{ "w", function() vim.o.wrap = not vim.o.wrap end,     { desc = "wrap" } },
					{
						"c",
						function() vim.o.cursorline = not vim.o.cursorline end,
						{ desc = "cursor line" },
					},
					{ "z",     "<cmd>ZenMode<cr>", { exit = true, desc = "zen mode" } },
					{ "<Esc>", nil,                { exit = true } },
				},
			})
		end,

	}

}
