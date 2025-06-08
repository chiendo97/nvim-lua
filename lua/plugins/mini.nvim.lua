return {
    {
        "echasnovski/mini.nvim",
        event = "VeryLazy",
        config = function()
            require("mini.bracketed").setup()
            require("mini.statusline").setup()
            require("mini.surround").setup()
            require("mini.operators").setup({ replace = { prefix = "" } })
            require("mini.ai").setup({
                custom_textobjects = {
                    -- Function definition (needs treesitter queries with these captures)
                    F = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
                },
                -- Number of lines within which textobject is searched
                n_lines = 200,

                -- How to search for object (first inside current line, then inside
                -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
                -- 'cover_or_nearest', 'next', 'prev', 'nearest'.
                search_method = "cover_or_next",

                -- Whether to disable showing non-error feedback
                -- This also affects (purely informational) helper messages shown after
                -- idle time if user input is required.
                silent = false,
            })
        end,
    },
}
