return {
    {
        "echaya/neowiki.nvim",
        opts = {
            wiki_dirs = {
                -- neowiki.nvim supports both absolute and relative paths
                { name = "Work", path = "~/neowiki/work" },
                { name = "Personal", path = "~/neowiki/personal" },
            },
            keymaps = {
                -- In Normal mode, follows the link under the cursor.
                -- In Visual mode, creates a link from the selection.
                action_link = "<CR>",
                action_link_vsplit = "<S-CR>",
                action_link_split = "<C-CR>",
                -- Toggles the status of a gtd item.
                -- Works on the current line in Normal mode and on the selection in Visual mode.
                toggle_task = "<leader>wt",
                -- Jumps to the next link in the buffer.
                next_link = "<Tab>",
                -- Jumps to the previous link in the buffer.
                prev_link = "<S-Tab>",
                -- Jumps to the index page of the current wiki.
                jump_to_index = "<Backspace>",
                -- Deletes the current wiki page.
                delete_page = "<leader>wd",
                -- Removes all links in the current file that point to non-existent pages.
                cleanup_links = "<leader>wc",
            },
        },
        keys = {
            {
                "<leader>ww",
                function()
                    require("neowiki").open_wiki()
                end,
                desc = "Open Wiki",
            },
            {
                "<leader>wT",
                function()
                    require("neowiki").open_wiki_in_new_tab()
                end,
                desc = "Open Wiki in Tab",
            },
        },
    },
}
