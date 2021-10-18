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

        --file_sorter = sorters.get_fzy_sorter,
        --generic_sorter = sorters.get_fzy_sorter,

        file_ignore_patterns = { "node_modules", ".pyc" },

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
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
    },
})

--require("telescope").load_extension("fzy_native")
require('telescope').load_extension('fzf')
