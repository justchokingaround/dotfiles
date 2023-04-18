local M = {}

M.general = {
  i = {
    ["jk"] = { "<ESC>", "escape insert mode" },
    ["<C-s>"] = { "<cmd>:w<CR>" },
  },
  n = {
    ["<C-s>"] = { "<cmd>:w<CR>" },
    ["<leader><leader>"] = { "<cmd> Telescope find_files<CR>", "find files" },
    ["<leader>ps"] = { "<cmd> Lazy sync<CR>", "Lazy Sync" },
    ["gh"] = { "<cmd>Lspsaga lsp_finder<CR>", "lsp finder" },
    ["gp"] = { "<cmd>Lspsaga peek_definition<CR>", "lsp finder" },
    ["go"] = { "<cmd>Lspsaga outline<CR>", "outline" },
    ["K"] = { "<cmd>Lspsaga hover_doc<CR>", "hover docs" },
    ["<leader>Z"] = { "<cmd>ZenMode<CR>", "zen mode" },
    -- ["<leader>ls"] = { "<cmd>Telescope symbols<CR>", "lsp finder" },
  },
}

M.treesitter = {
  n = {
    ["<leader>cu"] = { "<cmd> TSCaptureUnderCursor <CR>", "find media" },
  },
}

M.shade = {
  n = {
    ["<Bslash>"] = {
      function()
        require("shade").toggle()
      end,

      "toggle shade.nvim",
    },
  },
}

M.nvterm = {
  n = {
    ["<leader>gc"] = {
      function()
        require("nvterm.terminal").send("clear && g++ -o out " .. vim.fn.expand "%" .. " && ./out", "vertical")
      end,

      "compile & run a cpp file",
    },
  },
}

M.disabled = {
  i = {
    ["<C-e>"] = "",
  },
  n = {
    ["K"] = "",
    ["<leader>ls"] = "",
  },
}

return M
