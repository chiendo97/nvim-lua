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

    -- {
    --     "hrsh7th/nvim-cmp",
    --     -- "yioneko/nvim-cmp",
    --     -- branch = "perf-up",
    --     -- "iguanacucumber/magazine.nvim",
    --     lazy = true,
    --     config = function()
    --         require("plugins.nvim-cmp")
    --     end,
    -- },
    -- { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
    -- { "hrsh7th/cmp-buffer", event = "InsertEnter" },
    -- -- { "hrsh7th/cmp-nvim-lsp-signature-help", event = "InsertEnter" },
    -- { "hrsh7th/cmp-path", event = "InsertEnter" },
    -- {
    --     "zbirenbaum/copilot-cmp",
    --     -- disable if node is not executable
    --     enabled = vim.fn.executable("node") == 1,
    --     event = "InsertEnter",
    --     config = function()
    --         require("copilot_cmp").setup()
    --     end,
    --     dependencies = {
    --         "zbirenbaum/copilot.lua",
    --         cmd = "Copilot",
    --         build = ":Copilot auth",
    --         config = function()
    --             require("copilot").setup({
    --                 panel = {
    --                     enabled = false,
    --                 },
    --                 suggestion = {
    --                     enabled = false,
    --                 },
    --                 filetypes = {
    --                     yaml = true,
    --                     markdown = true,
    --                     help = true,
    --                     gitcommit = true,
    --                     svn = false,
    --                     cvs = false,
    --                     ["."] = false,
    --                 },
    --             })
    --         end,
    --     },
    -- },

    {
        "kylechui/nvim-surround",
        enabled = false,
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },

    {
        "nvim-orgmode/orgmode",
        event = "VeryLazy",
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

    -- {
    --     "nvim-telescope/telescope.nvim",
    --     enabled = false,
    --     cmd = { "Telescope" },
    --     init = function()
    --         require("plugins.telescope_map")
    --     end,
    --     config = function()
    --         require("plugins.telescope")
    --     end,
    -- },
    -- { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    -- { "nvim-telescope/telescope-ui-select.nvim", lazy = true },

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
            "GpAppend",
            "GpChatFinder",
            "GpChatNew",
            "GpChatPaste",
            "GpChatToggle",
            "GpContext",
            "GpEnew",
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
        "nvchad/ui",
        enabled = false,
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
        "mistweaverco/kulala.nvim",
        ft = "http",
        opts = {
            split_direction = "horizontal",
            default_view = "body",
        },
    },
    {
        "sphamba/smear-cursor.nvim",
        opts = {
            use_floating_windows = false,
        },
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            require("snacks").setup({
                bigfile = { enabled = true },
                notifier = { enabled = true },
                quickfile = { enabled = true },
                scope = {},

                styles = {
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
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            preset = "modern",
            delay = 1000,
            triggers = {
                { "<auto>", mode = "nxso" },
                { "<leader>", mode = { "n", "v" } },
            },
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
            require("mini.statusline").setup()
            require("mini.surround").setup()
            require("mini.operators").setup({ replace = { prefix = "cr" } })
            require("mini.ai").setup({
                custom_textobjects = {
                    -- Function definition (needs treesitter queries with these captures)
                    F = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
                },
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
                    enabled = vim.fn.executable("node") == 1,
                    dependencies = {
                        "zbirenbaum/copilot.lua",
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
        version = "v0.*",
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                ["<CR>"] = { "accept", "fallback" },
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
            completion = {
                list = {
                    selection = "preselect",
                },
                accept = {
                    auto_brackets = {
                        enabled = false,
                        semantic_token_resolution = {
                            enabled = false,
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 0,
                    treesitter_highlighting = true,
                    window = {
                        border = "rounded",
                    },
                },
                ghost_text = {
                    enabled = true,
                },
                menu = {
                    border = "rounded",
                    draw = {
                        columns = {
                            { "label", "label_description", gap = 1 },
                            { "kind" },
                        },
                    },
                },
            },
            sources = {
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        score_offset = 100,
                        async = true,
                        transform_items = function(_, items)
                            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                            local kind_idx = #CompletionItemKind + 1
                            CompletionItemKind[kind_idx] = "Copilot"
                            for _, item in ipairs(items) do
                                item.kind = kind_idx
                            end
                            return items
                        end,
                    },
                },
                completion = {
                    enabled_providers = { "lsp", "path", "snippets", "buffer", "copilot" },
                },
            },
            appearance = {
                use_nvim_cmp_as_default = false,
            },
        },
        -- allows extending the providers array elsewhere in your config
        -- without having to redefine it
        opts_extend = { "sources.default" },
    },
})

-- To load all integrations at once
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
    dofile(vim.g.base46_cache .. v)
end
