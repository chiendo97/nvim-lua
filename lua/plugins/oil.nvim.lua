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
        opts = {
            views = {
                finder = {
                    close_on_select = false,
                    confirm_simple = true,
                    git_status = { enabled = false },
                    mappings_opts = {
                        desc = "Fyler",
                    },
                    win = { win_opts = { cursorline = false } },
                },
            },
        },
        keys = {
            {
                "<leader>c",
                function()
                    require("fyler").toggle({
                        kind = "split_left_most",
                    })
                end,
                desc = "Open Fyler",
                mode = { "n" },
            },
        },
    },
}
