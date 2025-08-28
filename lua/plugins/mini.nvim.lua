return {
    {
        "echasnovski/mini.nvim",
        config = function()
            -- Go forward/backward with square brackets
            require("mini.bracketed").setup()
            require("mini.statusline").setup({
                -- Content of statusline as functions which return statusline string. See
                -- `:h statusline` and code of default contents (used instead of `nil`).
                content = {
                    -- Content for active window
                    active = function()
                        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
                        local git = MiniStatusline.section_git({ trunc_width = 40 })
                        local diff = MiniStatusline.section_diff({ trunc_width = 75 })
                        local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
                        local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
                        local filename = "%{expand('%:~:.')!=#''?expand('%:~:.'):'[No Name]'}"
                        local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
                        local location = MiniStatusline.section_location({ trunc_width = 75 })
                        local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

                        -- Usage of `MiniStatusline.combine_groups()` ensures highlighting and
                        -- correct padding with spaces between groups (accounts for 'missing'
                        -- sections, etc.)
                        return MiniStatusline.combine_groups({
                            { hl = mode_hl, strings = { mode } },
                            { hl = "MiniStatuslineFilename", strings = { filename } },
                            "%<", -- Mark general truncate point
                            { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
                            "%=", -- End left alignment
                            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
                            { hl = mode_hl, strings = { search, location } },
                        })
                    end,
                    -- Content for inactive window(s)
                    inactive = nil,
                },

                -- Whether to use icons by default
                use_icons = true,
            })
            -- Surround actions
            require("mini.surround").setup()
            -- Text edit operators
            require("mini.operators").setup({ replace = { prefix = "" } })
            -- Extend and create a/i textobjects
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
