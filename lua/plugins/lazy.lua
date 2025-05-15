local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

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

local is_node_available = vim.fn.executable("node") == 1

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
        "nvim-orgmode/orgmode",
        ft = { "org" },
        config = function()
            require("plugins.orgmode")
        end,
    },

    {
        "akinsho/org-bullets.nvim",
        event = "VeryLazy",
        ft = { "org" },
        dependencies = { "nvim-orgmode/orgmode" },
        config = function()
            require("org-bullets").setup()
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
            return is_node_available
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

    {
        "hat0uma/csvview.nvim",
        ---@module "csvview"
        ---@type CsvView.Options
        opts = {
            parser = { comments = { "#", "//" } },
            keymaps = {
                -- Text objects for selecting fields
                textobject_field_inner = { "if", mode = { "o", "x" } },
                textobject_field_outer = { "af", mode = { "o", "x" } },
                -- Excel-like navigation:
                -- Use <Tab> and <S-Tab> to move horizontally between fields.
                -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
                -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
                jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
                jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
                jump_next_row = { "<Enter>", mode = { "n", "v" } },
                jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
            },
        },
        cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
        ft = "csv",
    },

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
            "GpAppend",
            "GpChatFinder",
            "GpChatNew",
            "GpChatPaste",
            "GpChatToggle",
            "GpContext",
            "GpEnew",
            "GpExplain",
            "GpImplement",
            "GpNew",
            "GpNextAgent",
            "GpPopup",
            "GpPrepend",
            "GpProofread",
            "GpRewrite",
            "GpStop",
            "GpTabnew",
            "GpVnew",
        },
        init = function()
            require("plugins.gp-keymap")
        end,
        config = function()
            require("plugins.gp-nvim")
        end,
    },
    {
        "comfysage/evergarden",
        enabled = false,
        priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
        config = function()
            require("evergarden").setup({
                -- transparent_background = true,
                transparent_background = false,
                -- variant = "medium", -- 'hard'|'medium'|'soft'
                variant = "hard", -- 'hard'|'medium'|'soft'
                -- variant = "soft", -- 'hard'|'medium'|'soft'
                overrides = {}, -- add custom overrides
            })
            vim.cmd.colorscheme("evergarden")
            local highlight_links = {
                ["@org.headline.level1.org"] = "@markup.heading.1",
                ["@org.headline.level2.org"] = "@markup.heading.2",
                ["@org.headline.level3.org"] = "@markup.heading.3",
                ["@org.headline.level4.org"] = "@markup.heading.4",
                ["@org.headline.level5.org"] = "@markup.heading.5",
                ["@org.headline.level6.org"] = "@markup.heading.6",
            }

            for from, to in pairs(highlight_links) do
                vim.api.nvim_set_hl(0, from, { link = to })
            end
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            -- Default options:
            require("gruvbox").setup({
                terminal_colors = true, -- add neovim terminal colors
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = true,
                    emphasis = true,
                    comments = true,
                    operators = false,
                    folds = true,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "hard", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = false,
            })
            vim.o.background = "dark" -- or "light" for light mode
            vim.cmd.colorscheme("gruvbox")
        end,
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { code = { border = "thick" } },
        ft = { "markdown" },
    },
    -- For `plugins.lua` users.
    {
        "OXY2DEV/markview.nvim",
        enabled = false,
        lazy = false,
        config = function()
            require("markview").setup({
                markdown = {
                    headings = require("markview.presets").headings.marker,
                    list_items = {},
                },
            })
        end,
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
        "mistweaverco/kulala.nvim",
        ft = "http",
        opts = {
            split_direction = "horizontal",
            default_view = "body",
        },
    },
    {
        "sphamba/smear-cursor.nvim",
        -- enabled = false,
        opts = {
            use_floating_windows = false,
        },
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        keys = {
            {
                "<leader>t",
                function()
                    require("snacks").notifier.show_history()
                end,
                mode = { "n" },
                desc = "Show notification history",
            },
        },
        config = function()
            require("snacks").setup({
                bigfile = { enabled = true },
                notifier = { enabled = true },
                quickfile = { enabled = true },
                styles = {
                    notification_history = {
                        wo = {
                            wrap = true,
                        },
                    },
                    notification = {
                        wo = {
                            wrap = true,
                        },
                    },
                },
            })

            _G.dd = function(...)
                require("snacks").debug.inspect(...)
            end

            _G.bt = function()
                require("snacks").debug.backtrace()
            end

            vim.print = _G.dd
        end,
    },
    {
        "folke/which-key.nvim",
        enabled = true,
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            preset = "helix",
            delay = 500,
            triggers = {
                { "<auto>", mode = "nixsotc" },
                -- { "<leader>", mode = { "n", "v" } },
            },
            defer = function(ctx)
                if vim.list_contains({ "d", "y" }, ctx.operator) then
                    return true
                end
                return vim.list_contains({ "<C-V>", "V" }, ctx.mode)
            end,
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        "echasnovski/mini.nvim",
        event = "VeryLazy",
        config = function()
            require("mini.bracketed").setup()
            require("mini.statusline").setup()
            require("mini.surround").setup()
            require("mini.operators").setup({ replace = { prefix = "" } })
            require("mini.ai").setup({
                custom_textobjects = {
                    -- Function definition (needs treesitter queries with these captures)
                    F = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
                },
                -- Number of lines within which textobject is searched
                n_lines = 200,

                -- How to search for object (first inside current line, then inside
                -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
                -- 'cover_or_nearest', 'next', 'prev', 'nearest'.
                search_method = "cover_or_next",

                -- Whether to disable showing non-error feedback
                -- This also affects (purely informational) helper messages shown after
                -- idle time if user input is required.
                silent = false,
            })
        end,
    },
    {
        "ibhagwan/fzf-lua",
        event = "VeryLazy",
        cmd = { "FzfLua" },
        keys = {
            {
                -- FzfLua Find Files
                "<leader>g",
                function()
                    require("fzf-lua").files()
                end,
                mode = { "n" },
                desc = "Find files",
            },
            {
                -- FzfLua Live Grep
                "<leader>r",
                function()
                    require("fzf-lua").live_grep()
                end,
                mode = { "n" },
                desc = "Live grep",
            },
            {
                -- FzfLua Grep String (from visual selection)
                "<leader>r",
                function()
                    require("fzf-lua").grep_visual()
                end,
                mode = { "x" },
                desc = "Grep string (visual)",
            },
            {
                -- FzfLua Grep Word Under Cursor
                "<leader>R",
                function()
                    require("fzf-lua").grep_cword()
                end,
                mode = { "n" },
                desc = "Grep word under cursor",
            },
            {
                -- FzfLua Help Tags
                "<leader>h",
                function()
                    require("fzf-lua").helptags()
                end,
                mode = { "n" },
                desc = "Show help tags",
            },
            {
                -- FzfLua Old Files
                "<leader>j",
                function()
                    require("fzf-lua").oldfiles({
                        cwd_only = true,
                        stat_file = true, -- verify files exist on disk
                        include_current_session = true, -- include bufs from current session
                    })
                end,
                mode = { "n" },
                desc = "Show old files",
            },
            {
                -- FzfLua Keymaps
                "<leader>m",
                function()
                    require("fzf-lua").keymaps()
                end,
                mode = { "n" },
                desc = "Show keymaps",
            },
            {
                -- FzfLua Resume Last Search
                "<leader>n",
                function()
                    require("fzf-lua").resume()
                end,
                mode = { "n" },
                desc = "Resume last FzfLua command",
            },
            {
                -- FzfLua Built-in Commands
                "<leader>b",
                function()
                    require("fzf-lua").builtin()
                end,
                mode = { "n" },
                desc = "Show built-in commands",
            },
            {
                -- FzfLua Spell Suggest
                "<leader>s",
                function()
                    require("fzf-lua").spell_suggest()
                end,
                mode = { "n" },
                desc = "Show spelling suggestions",
            },
        },
        config = function()
            require("fzf-lua").setup({
                keymap = {
                    fzf = {
                        ["ctrl-q"] = "select-all+accept",
                    },
                },
                files = {
                    git_icons = false,
                },
            })
            require("fzf-lua").register_ui_select()
        end,
    },
    {
        "saghen/blink.cmp",
        -- optional: provides snippets for the snippet source
        dependencies = {
            {
                "rafamadriz/friendly-snippets",
                {
                    "giuxtaposition/blink-cmp-copilot",
                    enabled = is_node_available,
                    lazy = true,
                    dependencies = {
                        "zbirenbaum/copilot.lua",
                        lazy = true,
                        cmd = "Copilot",
                        build = ":Copilot auth",
                        config = function()
                            require("copilot").setup({
                                panel = {
                                    enabled = false,
                                },
                                suggestion = {
                                    enabled = false,
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
            },
        },

        -- use a release tag to download pre-built binaries
        version = "*",
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                ["<CR>"] = { "select_and_accept", "fallback" },
                ["<C-n>"] = { "select_next", "fallback" },
                ["<C-p>"] = { "select_prev", "fallback" },
                ["<C-e>"] = { "hide", "fallback" },
                ["<C-_>"] = { "cancel", "fallback" },
                ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                ["<Tab>"] = { "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },
            },
            cmdline = {
                enabled = true,
                completion = {
                    menu = { auto_show = true },
                    ghost_text = { enabled = false },
                },
                keymap = {
                    ["<Tab>"] = { "show", "accept" },
                    ["<S-Tab>"] = { "show_and_insert", "select_prev" },

                    ["<C-n>"] = { "select_next", "fallback" },
                    ["<C-p>"] = { "select_prev", "fallback" },

                    ["<C-y>"] = { "select_and_accept" },
                    ["<C-e>"] = { "cancel" },
                },
            },
            completion = {
                list = {
                    selection = {
                        -- When `true`, will automatically select the first item in the completion list
                        preselect = false,
                        -- preselect = function(ctx) return ctx.mode ~= 'cmdline' end,

                        -- When `true`, inserts the completion item automatically when selecting it
                        -- You may want to bind a key to the `cancel` command (default <C-e>) when using this option,
                        -- which will both undo the selection and hide the completion menu
                        auto_insert = true,
                        -- auto_insert = function(ctx) return ctx.mode ~= 'cmdline' end
                    },
                },
                accept = {
                    auto_brackets = {
                        enabled = false,
                        semantic_token_resolution = { enabled = false },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 0,
                    treesitter_highlighting = true,
                },
                ghost_text = {
                    enabled = true,
                },
            },
            sources = {
                providers = {
                    copilot = is_node_available and {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        score_offset = 100,
                        async = true,
                    } or nil,
                },
                default = function(_)
                    local default = { "lsp", "path", "snippets", "buffer" }
                    if is_node_available then
                        table.insert(default, "copilot")
                    end

                    return default
                end,
            },
            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = "mono",
            },
            signature = {
                enabled = true,
            },
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    {
        "Kurren123/mssql.nvim",
        opts = {},
        -- optional. You also need to call set_keymaps (see below)
        dependencies = { "folke/which-key.nvim" },
    },
    {
        "b0o/schemastore.nvim",
    },
})
