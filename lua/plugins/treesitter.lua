require("nvim-treesitter.configs").setup({
    -- A list of parser names, or "all"
    ensure_installed = {
        "bash",
        "c",
        "dart",
        "go",
        "http",
        "javascript",
        "json",
        "json5",
        "jsonc",
        "ledger",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "swift",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
    },
    ignore_install = { "org" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = false,

    highlight = {
        enable = true,
        disable = { "org" }, -- Remove this to use TS highlighter for some of the highlights (Experimental)
        -- Required since TS highlighter doesn't support all syntax features (conceal)
        additional_vim_regex_highlighting = {
            "org",
        },
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
    playground = {
        enable = false,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
        },
    },
})
