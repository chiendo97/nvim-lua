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
        enabled = true,
        highlight = { "Function", "Label" },
        priority = 500,
        include = {
            node_type = {
                ["*"] = {
                    "if_statement",
                    "for_statement",
                    "while_statement",
                },
            },
        },
    },
})
