require("indent_blankline").setup({
    char = "│",
    filetype_exclude = {
        "help",
        "terminal",
        "dashboard",
        "packer",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
    },
    buftype_exclude = {
        "terminal",
        "qf",
        "quickfix",
        "terminal",
        "packer",
    },
    show_trailing_blankline_indent = false,
    show_first_indent_level = true,
    strict_tabs = true,
})
