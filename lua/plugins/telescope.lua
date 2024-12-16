local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        preview = true,

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
                ["<C-e>"] = actions.to_fuzzy_refine,
                ["<C-h>"] = actions.which_key,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-s>"] = actions.select_horizontal,
                ["<C-t>"] = actions.select_tab,
                ["<C-v>"] = actions.select_vertical,
            },
        },

        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

        file_ignore_patterns = { "node_modules", ".pyc" },
    },

    -- pickers = {
    --     find_files = {
    --         theme = "ivy",
    --     },
    -- },

    extensions = {
        ["fzf"] = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
    },
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")
