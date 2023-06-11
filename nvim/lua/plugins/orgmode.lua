return {
  "nvim-orgmode/orgmode",
  init = function()
    local org = require("orgmode")

    org.setup_ts_grammar()
    org.setup({
      org_agenda_files = { "~/dox/org/**/*" },
      org_default_notes_file = "~/dox/org/inbox.org",
      org_agenda_templates = {
        t = { description = "Todo", template = "* TODO %?" },
        n = { description = "Note", template = "* %?" },
      },
    })
  end,
}
