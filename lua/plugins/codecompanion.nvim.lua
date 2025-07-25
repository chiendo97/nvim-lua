return {
    {
        "olimorris/codecompanion.nvim",
        enabled = false,
        opts = {
            extensions = {
                mcphub = {
                    callback = "mcphub.extensions.codecompanion",
                    opts = {
                        make_vars = true,
                        make_slash_commands = true,
                        show_result_in_chat = true,
                    },
                },
            },
            strategies = {
                chat = {
                    adapter = "openai",
                    keymaps = {
                        close = {
                            modes = { n = "q", i = "<C-q>" },
                        },
                    },
                },
                inline = {
                    adapter = "openai",
                },
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "ravitemer/mcphub.nvim",
        },
    },
}
