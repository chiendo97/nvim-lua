if not pcall(require, "telescope") then
    return
end

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
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({
                -- even more opts
            }),

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
            -- }
        },
    },
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")
