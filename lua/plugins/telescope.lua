if not pcall(require, "telescope") then
    return
end

local actions = require("telescope.actions")
local sorters = require("telescope.sorters")

require("telescope").setup({
    preview = false,
    pickers = {
        live_grep = {
            only_sort_text = true,
        },
        grep_string = {
            only_sort_text = true,
        },
    },
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
    },
})

require("telescope").load_extension("fzy_native")
