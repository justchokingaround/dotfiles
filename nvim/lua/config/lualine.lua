local M = {}

function M.setup()

	local colors = {
		blue = "#03d8f3",
		green = "#00ffc8",
		purple = "#ff0055",
		red1 = "#ff007c",
		yellow = "#FCEE0C",
		orange = "#ffb800",
		fg = "#353843",
		bg = "#ff007c",
		gray1 = "#2f404d",
		gray2 = "#3D898d",
		gray3 = "#3e4452",
	}
	require('lualine').setup {

		normal = {
			a = { fg = colors.fg, bg = colors.bg, gui = "bold" },
			b = { fg = colors.fg, bg = colors.bg },
			c = { fg = colors.fg, bg = colors.bg },
		},
		insert = { a = { fg = colors.fg, bg = colors.bg, gui = "bold" } },
		visual = { a = { fg = colors.fg, bg = colors.bg, gui = "bold" } },
		command = { a = { fg = colors.fg, bg = colors.bg, gui = "bold" } },
		replace = { a = { fg = colors.fg, bg = colors.bg, gui = "bold" } },
		inactive = {
			a = { fg = colors.fg, bg = colors.bg },
			b = { fg = colors.fg, bg = colors.bg },
			c = { fg = colors.fg, bg = colors.bg },
		},

		options = {
			component_separators = '|',
			-- section_separators = { left = '', right = '' },
		},
		sections = {
			lualine_b = { 'filename', 'branch' },
			lualine_c = { 'fileformat' },
			lualine_x = {},
			lualine_y = { 'filetype', 'progress' },
		},
		inactive_sections = {
			lualine_a = { 'filename' },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = { 'location' },
		},
		tabline = {},

	}

end

return M
