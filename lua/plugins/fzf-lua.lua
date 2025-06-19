return {
    {
        "ibhagwan/fzf-lua",
        event = "VeryLazy",
        enabled = false,
        cmd = { "FzfLua" },
        keys = {
            {
                "<leader>g",
                function()
                    require("fzf-lua").files()
                end,
                mode = { "n" },
                desc = "Find files",
            },
            {
                "<leader>r",
                function()
                    require("fzf-lua").live_grep()
                end,
                mode = { "n" },
                desc = "Live grep",
            },
            {
                "<leader>r",
                function()
                    require("fzf-lua").grep_visual()
                end,
                mode = { "x" },
                desc = "Grep selection",
            },
            {
                "<leader>R",
                function()
                    require("fzf-lua").grep_cword()
                end,
                mode = { "n" },
                desc = "Grep word under cursor",
            },
            {
                "<leader>h",
                function()
                    require("fzf-lua").helptags()
                end,
                mode = { "n" },
                desc = "Help tags",
            },
            {
                "<leader>j",
                function()
                    require("fzf-lua").oldfiles({
                        cwd_only = true,
                        stat_file = true, -- verify files exist on disk
                        include_current_session = true, -- include bufs from current session
                    })
                end,
                mode = { "n" },
                desc = "Recent files",
            },
            {
                "<leader>m",
                function()
                    require("fzf-lua").keymaps()
                end,
                mode = { "n" },
                desc = "Keymaps",
            },
            {
                "<leader>n",
                function()
                    require("fzf-lua").resume()
                end,
                mode = { "n" },
                desc = "Resume last search",
            },
            {
                "<leader>b",
                function()
                    require("fzf-lua").builtin()
                end,
                mode = { "n" },
                desc = "FzfLua commands",
            },
            {
                "<leader>s",
                function()
                    require("fzf-lua").spell_suggest()
                end,
                mode = { "n" },
                desc = "Spell suggest",
            },
            {
                "<leader>i",
                function()
                    require("fzf-lua").command_history()
                end,
                mode = { "n" },
                desc = "Command history",
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
