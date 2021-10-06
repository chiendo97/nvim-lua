if not pcall(require, "telescope") then
    return
end

local actions = require("telescope.actions")
local sorters = require("telescope.sorters")

require("telescope").setup({
    defaults = {
        preview = false,

        sorting_strategy = "ascending",

        prompt_prefix = "❯ ",
        selection_caret = "❯ ",
        entry_prefix = "○ ",

        color_devicons = true,

        layout_config = {
            prompt_position = "top",
        },

        mappings = {
            i = {
                ["<C-s>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                ["<C-c>"] = actions.close,
                ["<ESC>"] = actions.close,
            },
        },

        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

        file_sorter = sorters.get_fzy_sorter,
        generic_sorter = sorters.get_fzy_sorter,

        file_ignore_patterns = { "node_modules", ".pyc" },

        vimgrep_arguments = {
            "rg",
            "--hidden",
            "--color=never",
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
    },
})

require("telescope").load_extension("fzy_native")
