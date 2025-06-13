return {
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            local gs = require("gitsigns")

            gs.setup({
                signs = {
                    -- add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                    -- change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
                    -- delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                    -- topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                    -- changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
                },
                signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
                numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
                on_attach = function(bufnr)
                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]c", function()
                        if vim.wo.diff then
                            return "]c"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, {
                        expr = true,
                    })

                    map("n", "[c", function()
                        if vim.wo.diff then
                            return "[c"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, {
                        expr = true,
                    })

                    -- Actions
                    map({ "n", "v" }, "ghs", ":Gitsigns stage_hunk<CR>")
                    map("n", "ghS", gs.stage_buffer)

                    map({ "n", "v" }, "ghr", ":Gitsigns reset_hunk<CR>")
                    map("n", "ghR", gs.reset_buffer)
                    map("n", "ghu", gs.undo_stage_hunk)
                    map("n", "ghp", gs.preview_hunk)
                    map("n", "ghb", function()
                        gs.blame_line({ full = true })
                    end)
                    map("n", "ghd", gs.diffthis)
                    map("n", "ghD", function()
                        gs.diffthis("~")
                    end)

                    -- Text object
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
                end,
                watch_gitdir = {
                    interval = 1000,
                    follow_files = true,
                },
                attach_to_untracked = true,
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                -- current_line_blame_opts = {
                --     virt_text = true,
                --     virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                --     delay = 1000,
                --     ignore_whitespace = false,
                -- },
                -- current_line_blame_formatter_opts = {
                --     relative_time = false,
                -- },
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                max_file_length = 40000,
                preview_config = {
                    -- Options passed to nvim_open_win
                    style = "minimal",
                    relative = "cursor",
                    row = 0,
                    col = 1,
                },
                -- yadm = {
                --     enable = false,
                -- },
            })
        end,
    },
}
