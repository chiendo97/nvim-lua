require("ibl").setup({
    indent = { char = "|" },
    exclude = {
        filetypes = {
            "org",
            "go",
            "help",
            "terminal",
            "dashboard",
            "packer",
            "lspinfo",
            "TelescopePrompt",
            "TelescopeResults",
            "NvimTree",
        },
        buftypes = {
            "terminal",
            "qf",
            "quickfix",
            "terminal",
            "packer",
        },
    },
    scope = {
        enabled = false,
    },
})

-- require("indent_blankline").setup({
--     char = "│",
--     filetype_exclude = {
--         "org",
--         "go",
--         "help",
--         "terminal",
--         "dashboard",
--         "packer",
--         "lspinfo",
--         "TelescopePrompt",
--         "TelescopeResults",
--         "NvimTree",
--     },
--     buftype_exclude = {
--         "terminal",
--         "qf",
--         "quickfix",
--         "terminal",
--         "packer",
--     },
--     show_trailing_blankline_indent = false,
--     show_first_indent_level = true,
--     strict_tabs = true,
-- })
