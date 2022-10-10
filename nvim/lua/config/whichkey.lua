local M = {}

function M.setup()
  local whichkey = require "which-key"

  local conf = {
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
    },
  }

  local opts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

	local gopts = vim.tbl_deep_extend("force", opts, { prefix = "g" })


	local gmappings = {
		["D"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration" },
		["d"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition" },
		["I"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to implementation" },
		["l"] = { '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<cr>', "Show diagnostic" },
		["k"] = { '<cmd>lua vim.lsp.buf.hover()<cr>', "Show hover info" },
		["K"] = { '<cmd>lua vim.lsp.buf.signature_help()<cr>', "Show signature help" },
	}

	local mappings = {
		["a"] = { "<cmd>Alpha<cr>", "Alpha" },
		["b"] = {
			"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
			"Buffers",
		},
		["w"] = { "<cmd>w!<CR>", "Save" },
		["x"] = { "<cmd>x<cr>", "Save and quit" },
		["q"] = { "<cmd>q!<CR>", "Quit" },
		["c"] = { "<cmd>bd<cr>", "Close buffer" },
		["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
		["H"] = { "<cmd>!shellcheck %<CR>", "Shellcheck" },
		["f"] = {
			":Telescope find_files<cr>",
			"Find files",
		},
		["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
		-- ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },

		d = {
			name = "Debug",
			C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
			E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
			R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
			S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
			U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
			b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
			c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
			d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
			e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
			g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
			h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
			i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
			o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
			p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
			q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
			r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
			s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
			t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
			u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
			x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
		},

		p = {
			name = "Packer",
			c = { "<cmd>PackerCompile<cr>", "Compile" },
			i = { "<cmd>PackerInstall<cr>", "Install" },
			s = { "<cmd>PackerSync<cr>", "Sync" },
			S = { "<cmd>PackerStatus<cr>", "Status" },
			u = { "<cmd>PackerUpdate<cr>", "Update" },
			p = { "<cmd>PackerProfile<cr>", "Profile" },
		},

		g = {
			name = "Git",
			g = { "<cmd>LazyGit<CR>", "Lazygit" },
			j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
			k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
			l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
			p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
			r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
			R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
			s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
			u = {
				"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
				"Undo Stage Hunk",
			},
			o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
			b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
			c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
			d = {
				"<cmd>Gitsigns diffthis HEAD<cr>",
				"Diff",
			},
		},

		l = {
			name = "LSP",
			a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
			d = {
				"<cmd>Telescope Telescope diagnostics bufnr=0<cr>",
				"Document Diagnostics",
			},
			w = {
				"<cmd>Telescope diagnostics<cr>",
				"Workspace Diagnostics",
			},
			f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
			i = { "<cmd>LspInfo<cr>", "Info" },
			I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
			j = {
				"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
				"Next Diagnostic",
			},
			k = {
				"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
				"Prev Diagnostic",
			},
			l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
			q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
			r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
			s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
			S = {
				"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
				"Workspace Symbols",
			},
		},

		s = {
			name = "Search",
			c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
			h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
			M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
			r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
			R = { "<cmd>Telescope registers<cr>", "Registers" },
			k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
			C = { "<cmd>Telescope commands<cr>", "Commands" },
		},

		r = {
			name = "Code Runner",
			r = { "<cmd>RunCode<cr>", "RunCode" },
			f = { "<cmd>RunFile<cr>", "RunFile" },
			p = { "<cmd>RunProject<cr>", "RunProject" },
			c = { "<cmd>RunClose<cr>", "RunClose" },
		}

	}

		whichkey.setup(conf)
		whichkey.register(mappings, opts)
		whichkey.register(gmappings, gopts)

		local ncommentmappings = {
			gb = 'Togggle block comment',
			gbc = 'Toggle block comment',
			gc = 'Toggle line comment',
			gcc = 'Toggle line comment',
			gco = 'Comment next line',
			gcO = 'Comment prev line',
			gcA = 'Comment end of line',
			["g>"] = 'Comment region',
			["g>c"] = 'Add line comment',
			["g>b"] = 'Add block comment',
			["g<lt>"] = 'Uncomment region',
			["g<lt>c"] = 'Remove line comment',
			["g<lt>b"] = 'Remove block comment',
		}
		local xcommentmappings = {
			gb = 'Togggle block comment',
			gc = 'Toggle line comment',
			["g>"] = 'Comment region',
			["g<lt>"] = 'Uncomment region',
		}
		whichkey.register(ncommentmappings, { mode = 'n' })
		whichkey.register(xcommentmappings, { mode = 'x' })

	end

return M
