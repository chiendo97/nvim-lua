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
        "hrsh7th/nvim-cmp",
        -- "yioneko/nvim-cmp",
        -- branch = "perf-up",
        -- "iguanacucumber/magazine.nvim",
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
        -- disable if node is not executable
        enabled = vim.fn.executable("node") == 1,
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
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
                bigfile = { enabled = true },
                notifier = { enabled = true },
                quickfile = { enabled = true },
                -- statuscolumn = { enabled = true },
                -- words = { enabled = true },
                -- lazygit = { enabled = true },
                terminal = {
                    -- your terminal configuration comes here
                    -- or leave it empty to use the default settings
                    -- refer to the configuration section below
                    win = {
                        style = {
                            keys = {
                                term_normal = {
                                    "<esc>",
                                    "<C-\\><C-n>",
                                    mode = "t",
                                    noremap = true,
                                    expr = false,
                                    desc = "Escape to normal mode",
                                },
                            },
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
        keys = {
            {
                "<c-/>",
                function()
                    require("snacks").terminal()
                end,
                desc = "Toggle Terminal",
            },
            {
                "<c-_>",
                function()
                    require("snacks").terminal()
                end,
                desc = "which_key_ignore",
            },
        },
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
            local gen_spec = require("mini.ai").gen_spec
            require("mini.ai").setup({
                custom_textobjects = {
                    -- Function definition (needs treesitter queries with these captures)
                    F = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
                },
            })
        end,
    },
})

-- To load all integrations at once
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
    dofile(vim.g.base46_cache .. v)
end
