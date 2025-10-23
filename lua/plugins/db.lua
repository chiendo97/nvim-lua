return {
    {
        "chiendo97/db-nbook.nvim",
        dependencies = {
            {
                "jrop/morph.nvim",
                dev = true,
            },
        },
        dev = true,
    },
    {
        "saxon1964/neovim-tips",
        version = "*", -- Only update on tagged releases
        dependencies = {
            "MunifTanjim/nui.nvim",
            "MeanderingProgrammer/render-markdown.nvim", -- Clean rendering
        },
        opts = {
            -- OPTIONAL: Location of user defined tips (default value shown below)
            user_file = vim.fn.stdpath("config") .. "/neovim_tips/user_tips.md",
            -- OPTIONAL: Prefix for user tips to avoid conflicts (default: "[User] ")
            user_tip_prefix = "[User] ",
            -- OPTIONAL: Show warnings when user tips conflict with builtin (default: true)
            warn_on_conflicts = true,
            -- OPTIONAL: Daily tip mode (default: 1)
            -- 0 = off, 1 = once per day, 2 = every startup
            daily_tip = 1,
            -- OPTIONAL: Bookmark symbol (default: "🌟 ")
            bookmark_symbol = "🌟 ",
        },
    },
}
