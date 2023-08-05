return {

	-- LSPSAGA
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("lspsaga").setup({
				ui = {
					code_action = "",
				},
			})
		end,
		dependencies = {
			{ "DaikyXendo/nvim-material-icon" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},

	-- LSP LENS
	-- display references and definition info above functions like JB's IDEA
	{
		"VidocqH/lsp-lens.nvim",
		event = "BufRead",
		opts = {
			include_declaration = true,
			sections = {
				definition = false,
				references = true,
				implementation = false,
			},
		},
		keys = {
			{
				"<leader>uL",
				"<cmd>LspLensToggle<CR>",
				desc = "LSP Len Toggle",
			},
		},
	},
	-- DIM
	-- Dim the unused variables and functions using lsp and treesitter.
	{
		"narutoxy/dim.lua",
		event = "BufRead",
		dependencies = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
		config = true,
	},
}
