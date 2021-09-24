if not pcall(require, "telescope") then
    return
end

local actions = require("telescope.actions")
local sorters = require("telescope.sorters")

require("telescope").setup({
    defaults = {
        prompt_prefix = "❯ ",
        selection_caret = "❯ ",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        scroll_strategy = "cycle",
        color_devicons = true,
        winblend = 0,

        mappings = {
            i = {
                ["<C-s>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                ["<C-c>"] = actions.close,
                ["<esc>"] = actions.close,
            },
        },

        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

        file_sorter = sorters.get_fzy_sorter,
        generic_sorter = sorters.get_fzy_sorter,
        file_ignore_patterns = { "node_modules", ".pyc" },

        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        vimgrep_arguments = {
            "rg",
            "--hidden",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
    },

    extensions = {
        fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true,
        },

        fzf_writer = { use_highlighter = false, minimum_grep_characters = 6 },

        frecency = { workspaces = { ["conf"] = "~/.config/nvim/" } },
    },
})

require("telescope").load_extension("fzy_native")
