-- Load custom tree-sitter grammar for org filetype
require("orgmode").setup_ts_grammar()

require("orgmode").setup({
    org_agenda_files = { "~/Dropbox/org/*", "~/my-orgs/**/*" },
    org_default_notes_file = "~/Dropbox/org/refile.org",
    org_hide_leading_stars = true,
})
