return {
    {
        "ibhagwan/fzf-lua",
        event = "VeryLazy",
        cmd = { "FzfLua" },
        keys = {
            {
                -- FzfLua Find Files
                "<leader>g",
                function()
                    require("fzf-lua").files()
                end,
                mode = { "n" },
                desc = "Find files",
            },
            {
                -- FzfLua Live Grep
                "<leader>r",
                function()
                    require("fzf-lua").live_grep()
                end,
                mode = { "n" },
                desc = "Live grep",
            },
            {
                -- FzfLua Grep String (from visual selection)
                "<leader>r",
                function()
                    require("fzf-lua").grep_visual()
                end,
                mode = { "x" },
                desc = "Grep string (visual)",
            },
            {
                -- FzfLua Grep Word Under Cursor
                "<leader>R",
                function()
                    require("fzf-lua").grep_cword()
                end,
                mode = { "n" },
                desc = "Grep word under cursor",
            },
            {
                -- FzfLua Help Tags
                "<leader>h",
                function()
                    require("fzf-lua").helptags()
                end,
                mode = { "n" },
                desc = "Show help tags",
            },
            {
                -- FzfLua Old Files
                "<leader>j",
                function()
                    require("fzf-lua").oldfiles({
                        cwd_only = true,
                        stat_file = true, -- verify files exist on disk
                        include_current_session = true, -- include bufs from current session
                    })
                end,
                mode = { "n" },
                desc = "Show old files",
            },
            {
                -- FzfLua Keymaps
                "<leader>m",
                function()
                    require("fzf-lua").keymaps()
                end,
                mode = { "n" },
                desc = "Show keymaps",
            },
            {
                -- FzfLua Resume Last Search
                "<leader>n",
                function()
                    require("fzf-lua").resume()
                end,
                mode = { "n" },
                desc = "Resume last FzfLua command",
            },
            {
                -- FzfLua Built-in Commands
                "<leader>b",
                function()
                    require("fzf-lua").builtin()
                end,
                mode = { "n" },
                desc = "Show built-in commands",
            },
            {
                -- FzfLua Spell Suggest
                "<leader>s",
                function()
                    require("fzf-lua").spell_suggest()
                end,
                mode = { "n" },
                desc = "Show spelling suggestions",
            },
            {
                -- FzfLua Command History
                "<leader>i",
                function()
                    require("fzf-lua").command_history()
                end,
                mode = { "n" },
                desc = "Show command history",
            },
        },
        config = function()
            require("fzf-lua").setup({
                keymap = {
                    fzf = {
                        ["ctrl-q"] = "select-all+accept",
                    },
                },
                files = {
                    git_icons = false,
                },
            })
            require("fzf-lua").register_ui_select()
        end,
    },
}
