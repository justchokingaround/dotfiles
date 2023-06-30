local jdtls_opts = function()
  local home = os.getenv("HOME")
  local jdtls = require("jdtls")
  local root_markers = { "gradlew", "mvnw", ".git" }
  local root_dir = require("jdtls.setup").find_root(root_markers)
  local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  -- TODO: replace with an LspAttach function
  local on_attach = function(_client, _bufnr)
    jdtls.setup_dap({ hotcodereplace = "auto" })
    jdtls.setup.add_commands()

    -- -- Default keymaps
    -- local bufopts = { noremap = true, silent = true, buffer = bufnr }
    -- require("lsp.defaults").on_attach(client, bufnr)

    -- -- Java extensions
    -- remap("n", "<leader>vc", jdtls.test_class, bufopts, "Test class (DAP)")
    -- remap("n", "<leader>vm", jdtls.test_nearest_method, bufopts, "Test method (DAP)")
    local wk = require("which-key")
    local bufnr = vim.api.nvim_get_current_buf()

    local extract_variable = function()
      jdtls.extract_variable(true)
    end
    local extract_method = function()
      jdtls.extract_method(true)
    end

    wk.register({
      ["<leader>cJ"] = { name = "+java", buffer = bufnr, mode = { "n", "v" } },
    })

    wk.register({
      i = { jdtls.organize_importsorganize_imports, "Organize imports" },
      -- NOTE: Tests won't work unless we setup DAP and vscode-java-test
      t = { jdtls.test_class, "Test class" },
      n = { jdtls.test_nearest_method, "Test nearest method" },
      e = { extract_variable, "Extract variable" },
      M = { extract_method, "Extract method" },
    }, {
      prefix = "<leader>cJ",
      buffer = bufnr,
    })

    wk.register({
      e = { extract_variable, "Extract variable" },
      M = { extract_method, "Extract method" },
    }, {
      mode = "v",
      prefix = "<leader>cJ",
      buffer = bufnr,
    })
  end

  local bundles = {
    -- TODO: add the java-debug plugin
    -- vim.fn.glob(
    --   home .. "/Projects/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
    -- ),
  }
  -- TODO: add the vscode-java-test plugin
  -- vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/Projects/vscode-java-test/server/*.jar"), "\n"))

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  return {
    cmd = { vim.fn.stdpath("data") .. "/mason/bin/jdtls", "-data", workspace_folder },
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 80,
    },
    init_options = {
      bundles = bundles,
    },
    root_dir = root_dir,
    settings = {
      java = {
        -- format = {
        --   settings = {
        --     url = "/.local/share/eclipse/eclipse-java-google-style.xml",
        --     profile = "GoogleStyle",
        --   },
        -- },
        signatureHelp = { enabled = true },
        contentProvider = { preferred = "fernflower" },
        completion = {
          favoriteStaticMembers = {
            "org.hamcrest.MatcherAssert.assertThat",
            "org.hamcrest.Matchers.*",
            "org.hamcrest.CoreMatchers.*",
            "org.junit.jupiter.api.Assertions.*",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse",
            "org.mockito.Mockito.*",
          },
          filteredTypes = {
            "com.sun.*",
            "io.micrometer.shaded.*",
            "java.awt.*",
            "jdk.*",
            "sun.*",
          },
        },
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
        codeGeneration = {
          toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
          },
          hashCodeEquals = {
            useJava7Objects = true,
          },
          useBlocks = true,
        },
        configuration = {
          -- Add additional configuration/settings for the Eclipse JDT LS. See
          -- https://github.com/mfussenegger/nvim-jdtls/#java-xy-language-features-are-not-available
          runtimes = {
            -- Example:
            -- {
            --   name = "JavaSE-19",
            --   path = "~/.sdkman/candidates/java/19.ea.1.pma-open/",
            -- },
          },
        },
      },
    },
  }
end

local function setup_jdtls()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
      local jdtls = require("jdtls")
      jdtls.start_or_attach(jdtls_opts())
      jdtls.setup_dap({ hotcodereplace = "auto" })
    end,
  })

  return true
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mfussenegger/nvim-jdtls" },
    opts = {
      setup = {
        jdtls = setup_jdtls,
      },
    },
  },
}
