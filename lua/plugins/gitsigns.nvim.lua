---@diagnostic disable: param-type-mismatch

return {
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gitsigns.nav_hunk("next")
                    end
                end, { desc = "Go to next Git hunk" })

                map("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gitsigns.nav_hunk("prev")
                    end
                end, { desc = "Go to previous Git hunk" })

                -- Actions
                map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage current hunk" })
                map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset current hunk" })

                map("v", "<leader>hs", function()
                    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "Stage selected hunks" })

                map("v", "<leader>hr", function()
                    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "Reset selected hunks" })

                map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage entire buffer" })
                map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset entire buffer" })
                map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
                map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })

                map("n", "<leader>hb", function()
                    gitsigns.blame_line({ full = true })
                end, { desc = "Show full git blame for current line" })

                map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this buffer against index" })

                map("n", "<leader>hD", function()
                    gitsigns.diffthis("~")
                end, { desc = "Diff this buffer against last commit" })

                map("n", "<leader>hQ", function()
                    gitsigns.setqflist("all")
                end, { desc = "Set quickfix list with all hunks" })
                map("n", "<leader>hq", gitsigns.setqflist, { desc = "Set quickfix list with hunks" })

                -- Toggles
                map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
                map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" })

                -- Text object
                map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select inner hunk" })
            end,
        },
    },
}
