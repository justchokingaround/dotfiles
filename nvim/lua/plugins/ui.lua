return {
  -- Alpha Dashboard
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
},
-- Window Bar
{
  "utilyre/barbecue.nvim",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    attach_navic = false,
    lead_custom_section = function(_, winnr)
      return string.format("%d || ", vim.api.nvim_win_get_number(winnr))
    end,

    exclude_filetypes = {
      "DressingInput",
      "neo-tree",
      "toggleterm",
      "Trouble",
    },
  },
},
-- TODO: A pretty window for previewing, navigating and editing your LSP locations
{
  "dnlhc/glance.nvim",
},
-- Lualine
-- TODO: make it look better
{
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    return {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      },
    }
  end,
},
-- Noice
{
  "folke/noice.nvim",
  event = "VimEnter", -- Load on VimEnter to prevent blocking (_press enter to..._) notifications on startup
  config = function()
    require("noice").setup({
      cmdline = {
        format = {
          cmdline = { pattern = "^:", icon = " ", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
          help = { pattern = "^:%s*h%s+", icon = "" },
        },
      },
      opts = {
        views = {
          cmdline_popup = {
            position = { row = 0, col = "50%" },
            size = { width = "98%" },
          },
        },
        win_options = {
          winhighlight = {
            Normal = "NormalFloat",
            FloatBorder = "FloatBorder",
          },
        },
        presets = { long_message_to_split = true, lsp_doc_border = false },
        popupmenu = { backend = "cmp" },
        format = {},
        lsp = {
          progress = { enabled = true },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
      },
    })
  end,
},
-- Notifications
{
  "rcarriga/nvim-notify",
  opts = {
    timeout = 10,
    render = "minimal",
    background_colour = "#000000",
  },
},
-- Zen Mode
{
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  config = true,
  keys = { { "<leader>Z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
}
