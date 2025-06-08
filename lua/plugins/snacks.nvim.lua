return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        keys = {
            {
                "<leader>t",
                function()
                    require("snacks").notifier.show_history()
                end,
                mode = { "n" },
                desc = "Show notification history",
            },
            {
                "<leader>c",
                function()
                    require("snacks").explorer()
                end,
                mode = { "n" },
                desc = "Open snacks explorer",
            },
        },
        config = function()
            require("snacks").setup({
                bigfile = { enabled = true },
                notifier = { enabled = true },
                quickfile = { enabled = true },
                styles = {
                    notification_history = {
                        wo = {
                            wrap = true,
                        },
                    },
                    notification = {
                        wo = {
                            wrap = true,
                        },
                    },
                },
                explorer = {
                    replace_netrw = true,
                },
            })

            _G.dd = function(...)
                require("snacks").debug.inspect(...)
            end

            _G.bt = function()
                require("snacks").debug.backtrace()
            end

            vim.print = _G.dd
        end,
    },
}
