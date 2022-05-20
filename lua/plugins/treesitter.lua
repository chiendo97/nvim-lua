require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
        disable = { "org" }, -- Remove this to use TS highlighter for some of the highlights (Experimental)
        additional_vim_regex_highlighting = { "org" }, -- Required since TS highlighter doesn't support all syntax features (conceal)
    },
    incremental_selection = {
        enable = false,
    },
    indent = {
        enable = false,
    },
    textobjects = {
        select = {
            enable = false,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = false,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
    },
})
