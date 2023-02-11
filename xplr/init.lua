---@diagnostic disable
version = "0.20.1"

local xplr = xplr
local key = xplr.config.modes.builtin.default.key_bindings.on_key
---@diagnostic enable

xplr.config.general.show_hidden = false

xplr.config.general.enable_recover_mode = true

xplr.config.layouts.builtin.default = "Table"

-- xpm keybind
key.x = {
	help = "xpm",
	messages = {
		"PopMode",
		{ SwitchModeCustom = "xpm" },
	},
}

-- PLUGINS
local home = os.getenv("HOME")
package.path = home .. "/.config/xplr/plugins/?/init.lua;" .. home .. "/.config/xplr/plugins/?.lua;" .. package.path

-- xpm package manager
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

package.path = package.path .. ";" .. xpm_path .. "/?.lua;" .. xpm_path .. "/?/init.lua"

os.execute(string.format("[ -e '%s' ] || git clone '%s' '%s'", xpm_path, xpm_url, xpm_path))

require("xpm").setup({
	plugins = {
		"dtomvan/xpm.xplr",
		"sayanarijit/fzf.xplr",
		"dtomvan/extra-icons.xplr",
		"sayanarijit/zoxide.xplr",
		"Junker/nuke.xplr",
		"sayanarijit/dual-pane.xplr",
		"sayanarijit/trash-cli.xplr",
		"sayanarijit/preview-tabbed.xplr",
		"sayanarijit/dragon.xplr",
		-- ui plugins
		"prncss-xyz/icons.xplr",
		"sayanarijit/zentable.xplr",
		{
			name = "sayanarijit/command-mode.xplr",
			setup = function()
				local m = require("command-mode")

				m.setup()

				local help = m.silent_cmd("help", "show global help menu")(
					m.BashExec([[glow --pager $XPLR_PIPE_GLOBAL_HELP_MENU_OUT]])
				)

				local doc = m.silent_cmd("doc", "show docs")(m.BashExec([[glow /usr/share/doc/xplr]]))

				-- map `?` to command `help`
				help.bind("default", "?")

				-- map `ctrl-?` to command `help`
				doc.bind("default", "ctrl-?")
			end,
		},
	},
	auto_install = true,
	auto_cleanup = true,
})

-- plugin configs
require("fzf").setup({
	key = "ctrl-f",
	args = "--preview 'pistol {}'",
})

require("zoxide").setup({
	key = "z",
})

require("extra-icons").setup({
	after = function()
		xplr.config.general.table.row.cols[2] = { format = "custom.icons_dtomvan_col_1" }
	end,
})

require("nuke").setup({
	pager = "bat",
	open = {
		run_executables = true,
		custom = {
			{ extension = "jpg", command = "nsxiv {}" },
			{ mime = "video/mp4", command = "mpv {}" },
			{ mime_regex = "^video/.*", command = "mpv {}" },
			{ mime_regex = "^audio/.*", command = "mpv --audio-display=no {}" },
			{ mime_regex = ".*", command = "xdg-open {}" },
		},
	},
	view = {
		show_line_numbers = true,
	},
	smart_view = {
		custom = {
			{ extension = "so", command = "ldd -r {} | less" },
		},
	},
})
key.v = {
	help = "nuke",
	messages = { "PopMode", { SwitchModeCustom = "nuke" } },
}
key["f3"] = xplr.config.modes.custom.nuke.key_bindings.on_key.v
key["enter"] = xplr.config.modes.custom.nuke.key_bindings.on_key.o

require("dual-pane").setup({
	active_pane_width = { Percentage = 70 },
	inactive_pane_width = { Percentage = 30 },
})

-- press ; to access "action to"
require("preview-tabbed").setup({
	mode = "default",
	key = "p",
	fifo_path = "/tmp/xplr.fifo",
	previewer = os.getenv("HOME") .. "/.config/nnn/plugins/preview-tui",
})
