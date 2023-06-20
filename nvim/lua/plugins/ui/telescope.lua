return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "dharmx/telescope-media.nvim",
      config = function()
        require("telescope").load_extension("media")
      end,
    },
    {
      "ThePrimeagen/harpoon",
      config = function()
        require("telescope").load_extension("harpoon")
      end,
    },
  },
  keys = {
    {
      "<leader>fc",
      function()
        require("telescope.builtin").commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>fd",
      function()
        require("telescope.builtin").diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>fj",
      function()
        require("telescope.builtin").jumplist()
      end,
      desc = "Jump List",
    },
    {
      "<leader>fk",
      function()
        require("telescope.builtin").keymaps()
      end,
      desc = "Keymaps",
    },
    {
      "<leader>fo",
      function()
        vim.cmd([[ Telescope ]])
      end,
      desc = "Telescope",
    },
    {
      "<leader>fs",
      function()
        require("telescope.builtin").lsp_document_symbols()
      end,
      desc = "Find Document Symbols",
    },
    {
      "<leader>fm",
      function()
        require("telescope").extensions.media.media({
          backend = "chafa",
        })
      end,
      desc = "Find Media",
    },
    {
      "<leader>fh",
      -- :Telescope harpoon marks
      function()
        require("telescope.builtin").help_tags()
      end,
      desc = "Help Tags",
    },
    {
      "<leader>fw",
      function()
        require("telescope.builtin").live_grep({ search_dirs = { vim.fn.expand("%:p") } })
      end,
      desc = "Live Grep in Current File",
    },
    {
      "<leader>*",
      function()
        require("telescope.builtin").grep_string({
          search = vim.fn.expand("<cword>"),
          search_dirs = { vim.fn.expand("%:p") },
        })
      end,
    },
  },
  -- change some options
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
            require("telescope.actions").move_selection_next(...)
          end,
          ["<C-k>"] = function(...)
            require("telescope.actions").move_selection_previous(...)
          end,
        },
      },
    },
  },
}
