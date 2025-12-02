return {
    {
        "stevearc/oil.nvim",
        cmd = "Oil",
        opts = {},
    },
    {
        "A7Lavinraj/fyler.nvim",
        branch = "stable", -- Use stable branch for production
        lazy = false, -- Necessary for `default_explorer` to work properly
        opts = {},
        keys = {
            {
                "<leader>c",
                "<cmd>Fyler kind=split_left_most<cr>",
                desc = "Open Fyler",
                mode = { "n" },
            },
        },
    },
}
