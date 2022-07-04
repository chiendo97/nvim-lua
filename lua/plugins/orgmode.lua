-- Load custom tree-sitter grammar for org filetype
require("orgmode").setup_ts_grammar()

require("orgmode").setup({
    org_agenda_files = "~/Dropbox/org/*",
    org_default_notes_file = "~/Dropbox/org/inbox.org",
    org_hide_leading_stars = true,
    org_ellipsis = "",
    org_blank_before_new_entry = {
        heading = false,
        plain_list_item = false,
    },
    mappings = {
        org = {
            -- org_toggle_checkbox = "<leader>x",
        },
    },
})
