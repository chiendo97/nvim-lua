local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- put this in your main init.lua file ( before lazy setup )
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "nvim-lua/plenary.nvim", lazy = true },
    { "tweekmonster/startuptime.vim", cmd = "StartupTime" },
    {
        "kyazdani42/nvim-tree.lua",
        cmd = "NvimTreeToggle",
        init = function()
            vim.keymap.set("n", "<leader>c", "<cmd>NvimTreeToggle<cr>", { noremap = true })
        end,
        config = function()
            require("plugins.nvim-tree")
        end,
    },
    { "nvim-tree/nvim-web-devicons", lazy = true },

    {
        "neovim/nvim-lspconfig",
        -- event = "VeryLazy",
        config = function()
            require("lsp")
        end,
    },

    {
        -- "hrsh7th/nvim-cmp",
        -- "yioneko/nvim-cmp",
        -- branch = "perf-up",
        "iguanacucumber/magazine.nvim",
        lazy = true,
        config = function()
            require("plugins.nvim-cmp")
        end,
    },
    { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
    { "hrsh7th/cmp-buffer", event = "InsertEnter" },
    -- { "hrsh7th/cmp-nvim-lsp-signature-help", event = "InsertEnter" },
    { "hrsh7th/cmp-path", event = "InsertEnter" },
    {
        "zbirenbaum/copilot-cmp",
        event = "InsertEnter",
        config = function()
            require("copilot_cmp").setup()
        end,
        dependencies = {
            "zbirenbaum/copilot.lua",
            cmd = "Copilot",
            build = ":Copilot auth",
            config = function()
                require("copilot").setup({
                    panel = {
                        enabled = false,
                        auto_refresh = true,
                    },
                    suggestion = {
                        enabled = false,
                        auto_trigger = true,
                        accept = false,
                    },
                    filetypes = {
                        yaml = true,
                        markdown = true,
                        help = true,
                        gitcommit = true,
                        svn = false,
                        cvs = false,
                        ["."] = false,
                    },
                })
            end,
        },
    },

    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },

    {
        "nvimtools/none-ls.nvim",
        event = "VeryLazy",
        enabled = false,
        config = function()
            require("lsp.null-ls")
        end,
    },
    { "nvimtools/none-ls-extras.nvim", lazy = true },

    {
        "nvim-orgmode/orgmode",
        event = "VeryLazy",
        ft = { "org" },
        config = function()
            require("plugins.orgmode")
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        config = function()
            require("plugins.treesitter")
        end,
    },

    {
        "junegunn/vim-easy-align",
        event = "VeryLazy",
        config = function()
            vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", {})
            vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {})
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require("plugins.gitsigns")
        end,
        cond = function()
            return vim.fn.isdirectory(".git") == 1
        end,
    },

    {
        "alexghergh/nvim-tmux-navigation",
        event = "VeryLazy",
        config = function()
            local nvim_tmux_nav = require("nvim-tmux-navigation")

            nvim_tmux_nav.setup({
                disable_when_zoomed = true,
            })

            vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
            vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
            vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
            vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
        end,
    },

    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        enabled = false,
        config = function()
            require("gruvbox").setup({
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = true,
                    comments = true,
                    operators = false,
                    folds = true,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true,
                contrast = "",
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = false,
            })
            vim.cmd("colorscheme gruvbox")
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        cmd = { "Telescope" },
        init = function()
            require("plugins.telescope_map")
        end,
        config = function()
            require("plugins.telescope")
        end,
    },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    { "nvim-telescope/telescope-ui-select.nvim", lazy = true },

    {
        "kevinhwang91/nvim-bqf",
        config = function()
            require("plugins.nvim-bqf")
        end,
        ft = "qf",
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        main = "ibl",
        config = function()
            require("plugins.indent-blankline")
        end,
    },

    { "chrisbra/csv.vim", ft = "csv" },

    {
        "stevearc/oil.nvim",
        cmd = "Oil",
        opts = {},
    },

    {
        "garymjr/nvim-snippets",
        event = "InsertEnter",
        opts = {
            create_cmp_source = false,
            friendly_snippets = true,
        },
    },
    { "rafamadriz/friendly-snippets", lazy = true },

    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        opts = {},
    },

    {
        "robitx/gp.nvim",
        cmd = {
            "GpChatNew",
            "GpChatToggle",
            "GpChatFinder",
            "GpChatPaste",
            "GpRewrite",
            "GpAppend",
            "GpPrepend",
            "GpImplement",
            "GpPopup",
            "GpEnew",
            "GpNew",
            "GpVnew",
            "GpTabnew",
            "GpContext",
            "GpStop",
            "GpNextAgent",
        },
        init = function()
            require("plugins.gp-keymap")
        end,
        config = function()
            require("plugins.gp-nvim")
        end,
    },

    {
        "nvchad/ui",
        config = function()
            require("nvchad")
        end,
    },

    {
        "nvchad/base46",
        lazy = true,
        build = function()
            require("base46").load_all_highlights()
        end,
    },
    {
        "stevearc/dressing.nvim",
        enabled = false,
        opts = {
            input = {

                -- Can be 'left', 'right', or 'center'
                title_pos = "center",

                -- Set to `false` to disable
                mappings = {
                    n = {
                        ["<Esc>"] = "Close",
                        ["<C-c>"] = "Close",
                        ["<CR>"] = "Confirm",
                    },
                    i = {
                        ["<C-c>"] = "Close",
                        ["<CR>"] = "Confirm",
                        ["<Up>"] = "HistoryPrev",
                        ["<Down>"] = "HistoryNext",
                    },
                },
            },
        },
    },
    -- lazy.nvim
    {
        "folke/noice.nvim",
        enabled = false,
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
    },

    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {},
        ft = { "markdown" },
    },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                -- Customize or remove this keymap to your liking
                "<leader>f",
                function()
                    require("conform").format({ async = true })
                end,
                mode = { "n", "v", "x" },
                desc = "Format buffer",
            },
        },
        config = function()
            require("plugins.conform-nvim")
        end,
        init = function()
            -- If you want the formatexpr, here is the place to set it
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        enabled = false,
        opts = {
            enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
            max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            line_numbers = true,
            multiline_threshold = 20, -- Maximum number of lines to show for a single context
            trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
            -- Separator between context and content. Should be a single character string, like '-'.
            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
            separator = nil,
            zindex = 20, -- The Z-index of the context window
            on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        },
    },
    -- {
    --     "saghen/blink.cmp",
    --     lazy = false, -- lazy loading handled internally
    --     -- optional: provides snippets for the snippet source
    --     dependencies = "rafamadriz/friendly-snippets",
    --
    --     -- use a release tag to download pre-built binaries
    --     version = "v0.*",
    --     -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    --     -- build = 'cargo build --release',
    --     -- On musl libc based systems you need to add this flag
    --     -- build = 'RUSTFLAGS="-C target-feature=-crt-static" cargo build --release',
    --     -- If you use nix, you can build from source using latest nightly rust with:
    --     -- build = 'nix run .#build-plugin',
    --
    --     ---@module 'blink.cmp'
    --     ---@type blink.cmp.Config
    --     opts = {
    --         -- for keymap, all values may be string | string[]
    --         -- use an empty table to disable a keymap
    --         keymap = {
    --             show = "<C-space>",
    --             hide = "<C-e>",
    --             accept = "<CR>",
    --
    --             -- select_and_accept = {},
    --             -- select_prev = { "<Up>", "<C-p>" },
    --             -- select_next = { "<Down>", "<C-n>" },
    --
    --             show_documentation = "<C-space>",
    --             hide_documentation = "<C-space>",
    --
    --             scroll_documentation_up = "<C-b>",
    --             scroll_documentation_down = "<C-f>",
    --
    --             snippet_forward = "<Tab>",
    --             snippet_backward = "<S-Tab>",
    --         },
    --
    --         trigger = {
    --             completion = {
    --                 -- 'prefix' will fuzzy match on the text before the cursor
    --                 -- 'full' will fuzzy match on the text before *and* after the cursor
    --                 -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
    --                 keyword_range = "prefix",
    --                 -- regex used to get the text when fuzzy matching
    --                 -- changing this may break some sources, so please report if you run into issues
    --                 -- todo: shouldnt this also affect the accept command? should this also be per language?
    --                 keyword_regex = "[%w_\\-]",
    --                 -- after matching with keyword_regex, any characters matching this regex at the prefix will be excluded
    --                 exclude_from_prefix_regex = "[\\-]",
    --                 -- LSPs can indicate when to show the completion window via trigger characters
    --                 -- however, some LSPs (*cough* tsserver *cough*) return characters that would essentially
    --                 -- always show the window. We block these by default
    --                 blocked_trigger_characters = { " ", "\n", "\t" },
    --                 -- when true, will show the completion window when the cursor comes after a trigger character when entering insert mode
    --                 show_on_insert_on_trigger_character = true,
    --                 -- list of additional trigger characters that won't trigger the completion window when the cursor comes after a trigger character when entering insert mode
    --                 show_on_insert_blocked_trigger_characters = { "'", '"' },
    --             },
    --
    --             signature_help = {
    --                 enabled = false,
    --                 blocked_trigger_characters = {},
    --                 blocked_retrigger_characters = {},
    --                 -- when true, will show the signature help window when the cursor comes after a trigger character when entering insert mode
    --                 show_on_insert_on_trigger_character = true,
    --             },
    --         },
    --         sources = {
    --             -- similar to nvim-cmp's sources, but we point directly to the source's lua module
    --             -- multiple groups can be provided, where it'll fallback to the next group if the previous
    --             -- returns no completion items
    --             -- WARN: This API will have breaking changes during the beta
    --             providers = {
    --                 { "blink.cmp.sources.lsp", name = "LSP" },
    --                 { "blink.cmp.sources.path", name = "Path", score_offset = 3 },
    --                 { "blink.cmp.sources.snippets", name = "Snippets", score_offset = -3 },
    --                 { "blink.cmp.sources.buffer", name = "Buffer" },
    --             },
    --         },
    --
    --         windows = {
    --             autocomplete = {
    --                 min_width = 15,
    --                 max_height = 10,
    --                 border = "single",
    --                 winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
    --                 -- keep the cursor X lines away from the top/bottom of the window
    --                 scrolloff = 2,
    --                 -- which directions to show the window,
    --                 -- falling back to the next direction when there's not enough space
    --                 direction_priority = { "s", "n" },
    --                 -- Controls whether the completion window will automatically show when typing
    --                 auto_show = true,
    --                 -- Controls how the completion items are selected
    --                 -- 'preselect' will automatically select the first item in the completion list
    --                 -- 'manual' will not select any item by default
    --                 -- 'auto_insert' will not select any item by default, and insert the completion items automatically when selecting them
    --                 selection = "preselect",
    --                 -- Controls how the completion items are rendered on the popup window
    --                 -- 'simple' will render the item's kind icon the left alongside the label
    --                 -- 'reversed' will render the label on the left and the kind icon + name on the right
    --                 -- 'minimal' will render the label on the left and the kind name on the right
    --                 -- 'function(blink.cmp.CompletionRenderContext): blink.cmp.Component[]' for custom rendering
    --                 draw = "reversed",
    --                 -- Controls the cycling behavior when reaching the beginning or end of the completion list.
    --                 cycle = {
    --                     -- When `true`, calling `select_next` at the *bottom* of the completion list will select the *first* completion item.
    --                     from_bottom = true,
    --                     -- When `true`, calling `select_prev` at the *top* of the completion list will select the *last* completion item.
    --                     from_top = true,
    --                 },
    --             },
    --             documentation = {
    --                 min_width = 10,
    --                 max_width = 60,
    --                 max_height = 20,
    --                 border = "single",
    --                 winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
    --                 -- which directions to show the documentation window,
    --                 -- for each of the possible autocomplete window directions,
    --                 -- falling back to the next direction when there's not enough space
    --                 direction_priority = {
    --                     autocomplete_north = { "e", "w", "n", "s" },
    --                     autocomplete_south = { "e", "w", "s", "n" },
    --                 },
    --                 -- Controls whether the documentation window will automatically show when selecting a completion item
    --                 auto_show = true,
    --                 auto_show_delay_ms = 0,
    --                 update_delay_ms = 50,
    --             },
    --             signature_help = {
    --                 min_width = 1,
    --                 max_width = 100,
    --                 max_height = 10,
    --                 border = "single",
    --                 winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
    --             },
    --         },
    --
    --         nerd_font_variant = "normal",
    --     },
    -- },
})

-- To load all integrations at once
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
    dofile(vim.g.base46_cache .. v)
end
