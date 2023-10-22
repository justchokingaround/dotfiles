return {
	-- CMP
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter" },
		opts = function(_, opts)
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			local confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			}
			local border_opts = {
				border = "rounded",
				winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
			}

			local window = {
				completion = cmp.config.window.bordered(border_opts),
				documentation = cmp.config.window.bordered(border_opts),
			}

			local kind_icons = {
				Text = "  ",
				Method = "  ",
				Function = "  ",
				Constructor = "  ",
				Field = "  ",
				Variable = "  ",
				Class = "  ",
				Interface = "  ",
				Module = "  ",
				Property = "  ",
				Unit = "  ",
				Value = "  ",
				Enum = "  ",
				Keyword = "  ",
				Snippet = "  ",
				Color = "  ",
				File = "  ",
				Reference = "  ",
				Folder = "  ",
				EnumMember = "  ",
				Constant = "  ",
				Struct = "  ",
				Event = "  ",
				Operator = "  ",
				TypeParameter = "  ",
			}

			local source_mapping = {
				buffer = "[Buffer]",
				calc = "[calc]",
				latex_symbols = "[LaTeX]",
				luasnip = "[Snippet]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
				path = "[Path]",
				spell = "[Spell]",
			}

			local formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
					vim_item.menu = (source_mapping)[entry.source.name]
					return vim_item
				end,
			}

			local snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			}

			local mapping = {
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
				["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
				["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				}),
			}

			local sources = {
				{ name = "nvim_lsp", keyword_length = 2, max_item_count = 30 },
				{ name = "luasnip",  keyword_length = 1, max_item_count = 30 },
				{ name = "buffer",   keyword_length = 2, max_item_count = 30 },
				{ name = "path",     keyword_length = 3, max_item_count = 30 },
				{ name = "nvim_lua", keyword_length = 1, max_item_count = 30 },
				{ name = "spell",    keyword_length = 2, max_item_count = 30 },
			}

			opts.confirm_opts = confirm_opts
			opts.formatting = formatting
			opts.mapping = mapping
			opts.snippet = snippet
			opts.sources = sources
			opts.window = window
		end,

		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"f3fora/cmp-spell",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
		},
	},

	-- TREESITTER
	{
		"nvim-treesitter/nvim-treesitter",
		enabled = true,
		build = ":TSUpdate",
		opts = {
			incremental_selection = {
				enable = true,
				keymaps = {
					node_incremental = "v",
					node_decremental = "V",
				},
			},
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"css",
				"go",
				"gomod",
				"html",
				"java",
				"javascript",
				"json",
				"latex",
				"lua",
				"make",
				"markdown",
				"markdown_inline",
				"norg",
				"python",
				"regex",
				"rust",
				"typescript",
				"vim",
				"vimdoc",
				"vue",
				"yaml",
			},
		},
	},

	-- MASON
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"shfmt",
				"shellcheck",
				"bash-language-server",
				"bash-debug-adapter",
				"json-lsp",
				"lua-language-server",
				"glow",
				"jdtls",
				"java-debug-adapter",
				"java-test",
				"rust-analyzer",
				"rustfmt",
				"pyright",
				"black",
			},
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "",
					package_uninstalled = "✗",
				},
			},
		},
	},

	{
		"stevearc/conform.nvim",
		opts = function()
			return {
				command = "shfmt",
				args = { "-i", "4", "-ci" },
			}
		end,
	},
}
