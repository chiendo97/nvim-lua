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
