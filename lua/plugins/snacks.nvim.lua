return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        keys = {
            {
                "<leader>t",
                function()
                    require("snacks.picker").notifications()
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
            {
                "<leader>g",
                function()
                    -- Open file finder, similar to fzf-lua files()
                    require("snacks.picker").files()
                end,
                mode = { "n" },
                desc = "Find files",
            },
            {
                "<leader>r",
                function()
                    -- Live grep like search in snacks
                    require("snacks.picker").grep()
                end,
                mode = { "n" },
                desc = "Live grep",
            },
            {
                "<leader>r",
                function()
                    -- Grep visual selection
                    require("snacks.picker").grep_word()
                end,
                mode = { "x" },
                desc = "Grep selection",
            },
            {
                "<leader>R",
                function()
                    -- Grep word under cursor
                    require("snacks.picker").grep_word()
                end,
                mode = { "n" },
                desc = "Grep word under cursor",
            },
            {
                "<leader>h",
                function()
                    -- Search help tags
                    require("snacks.picker").help()
                end,
                mode = { "n" },
                desc = "Help tags",
            },
            {
                "<leader>j",
                function()
                    -- Recent files with options
                    require("snacks.picker").recent({
                        filter = { cwd = true },
                    })
                end,
                mode = { "n" },
                desc = "Recent files",
            },
            {
                "<leader>m",
                function()
                    -- Show keymaps
                    require("snacks.picker").keymaps()
                end,
                mode = { "n" },
                desc = "Keymaps",
            },
            {
                "<leader>n",
                function()
                    -- Resume last search
                    require("snacks.picker").resume()
                end,
                mode = { "n" },
                desc = "Resume last search",
            },
            {
                "<leader>b",
                function()
                    -- Show builtin commands picker
                    require("snacks.picker").pickers()
                end,
                mode = { "n" },
                desc = "Snacks builtins",
            },
            {
                "<leader>s",
                function()
                    -- Spell suggestions
                    require("snacks.picker").spelling()
                end,
                mode = { "n" },
                desc = "Spell suggest",
            },
            {
                "<leader>i",
                function()
                    -- Command history picker
                    require("snacks.picker").command_history({
                        sort = function(a, b)
                            return a.idx < b.idx
                        end,
                    })
                end,
                mode = { "n" },
                desc = "Command history",
            },
        },
        config = function()
            require("snacks").setup({
                bigfile = { enabled = true },
                notifier = { enabled = true },
                scope = { enabled = true },
                quickfile = { enabled = true },
                picker = {
                    ui_select = true,
                    win = {
                        input = {
                            keys = {
                                ["C-c"] = { "cancel", mode = { "i", "n" } },
                                ["<Esc>"] = { "close", mode = { "n", "i" } },
                            },
                        },
                    },
                },
                styles = {
                    notification_history = {
                        relative = "editor",
                        wo = {
                            wrap = true,
                        },
                    },
                    notification = {
                        relative = "editor",
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
