return {

  "jose-elias-alvarez/null-ls.nvim",

  opts = function()
    local nls = require("null-ls")
    return {
      root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
      sources = {
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.shfmt.with({
          args = { "-i", "4", "-ci" },
        }),
        -- nls.builtins.diagnostics.flake8,
      },
    }
  end,
}
