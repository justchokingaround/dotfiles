return {
  -- Git conflict
  -- Easily fix merge conflicts
  -- > - co — choose ours
  -- > - ct — choose theirs
  -- > - cb — choose both
  -- > - c0 — choose none
  -- > - ]x — move to previous conflict
  -- > - [x — move to next conflict
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
  },

  -- Diffview
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },

    diff_binaries = false,
    enhanced_diff_hl = false,
    use_icons = true,
    icons = {
      folder_closed = "",
      folder_open = "",
    },
    signs = {
      folder_closed = "",
      folder_open = "",
    },
    file_panel = {
      position = "left",
      width = 35,
      height = 10,
      listing_style = "list",
      tree_options = {
        flatten_dirs = true,
        folder_statuses = "only_folded",
      },
    },
    file_history_panel = {
      position = "bottom",
      width = 35,
      height = 16,
      log_options = {
        max_count = 256,
        follow = false,
        all = false,
        merges = false,
        no_merges = false,
        reverse = false,
      },
    },
    default_args = {
      DiffviewOpen = {},
      DiffviewFileHistory = {},
    },
    hooks = {},
  },

  -- Neogit
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "sindrets/diffview.nvim",
    },
    opts = {
      signs = {
        -- { CLOSED, OPENED }
        section = { "󰕏", "󰕎" },
        item = { "󰕏", "󰕎" },
        hunk = { "", "" },
      },
    },
  },

  -- Octo for github
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup({
        use_local_fs = false,                      -- use local files on right side of reviews
        default_remote = { "upstream", "origin" }, -- order to try remotes
        ssh_aliases = {},                          -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`
        reaction_viewer_hint_icon = "",         -- marker for user reactions
        user_icon = " ",                        -- user icon
        timeline_marker = "",                   -- timeline marker
        timeline_indent = "2",                     -- timeline indentation
        right_bubble_delimiter = "",            -- bubble delimiter
        left_bubble_delimiter = "",             -- bubble delimiter
        github_hostname = "",                      -- GitHub Enterprise host
        snippet_context_lines = 4,                 -- number or lines around commented lines
        gh_env = {},                               -- extra environment variables to pass on to GitHub CLI, can be a table or function returning a table
        timeout = 5000,                            -- timeout for requests between the remote server
        ui = {
          use_signcolumn = true,                   -- show "modified" marks on the sign column
        },
        issues = {
          order_by = {            -- criteria to sort results of `Octo issue list`
            field = "CREATED_AT", -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
            direction = "DESC",   -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
          },
        },
        pull_requests = {
          order_by = {                              -- criteria to sort the results of `Octo pr list`
            field = "CREATED_AT",                   -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
            direction = "DESC",                     -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
          },
          always_select_remote_on_create = "false", -- always give prompt to select base remote repo when creating PRs
        },
        file_panel = {
          size = 10,        -- changed files panel rows
          use_icons = true, -- use web-devicons in file panel (if false, nvim-web-devicons does not need to be installed)
        },
      })
    end,
  },
}
