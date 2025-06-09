return {
    {
        "folke/which-key.nvim",
        enabled = true,
        event = "VeryLazy",
        opts = {
            preset = "helix",
            delay = 300, -- Reduced from 500 for better responsiveness
            triggers = {
                { "<auto>", mode = "nixsotc" },
            },
            defer = function(ctx)
                return vim.list_contains({ "d", "y" }, ctx.operator) or vim.list_contains({ "<C-V>", "V" }, ctx.mode)
            end,
            spec = {
                { "<leader>g", group = "FzfLua" },
                { "<leader>r", group = "Grep" },
                { "<leader>y", group = "Yank" },
                { "<C-g>", group = "GPT" },
                { "<C-g>g", group = "GPT Windows" },
                { "g", group = "Go to" },
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
}
