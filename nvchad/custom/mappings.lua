local M = {}

M.general = {
  i = {
    ["<C-h>"] = {
      "copilot#Accept()",
      "ﮧ  copilot completion",
      opts = {
        silent = true,
        script = true,
        expr = true,
      },
    },
    ["<C-j>"] = {
      'copilot#Accept("<CR>")',
      "ﮧ  copilot completion",
      opts = {
        silent = true,
        script = true,
        expr = true,
      },
    },
    ["<C-s>"] = { "<cmd>:w<CR>" },
  },
  n = {
    ["<leader><leader>"] = { "<cmd> Telescope find_files<CR>", "find files" },
    ["<leader>ps"] = { "<cmd> PackerSync<CR>", "Packer Sync" },
  },
}

M.disabled = {
  i = {
    ["<C-j>"] = "",
    ["<C-k>"] = "",
  },
}

-- more keybinds!

return M
