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

require("lazy").setup({
    -- add packages
    {
        "tweekmonster/startuptime.vim",
        cmd = "StartupTime",
    },

    -- nvim-tree
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "NvimTreeToggle",
        init = function()
            vim.keymap.set("n", "<leader>c", "<cmd>NvimTreeToggle<cr>", { noremap = true })
        end,
        config = function()
            require("plugins.nvim-tree")
        end,
    },

    -- lspconfig
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lsp")
        end,
    },

    -- lsp autocomplete
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- lsp source
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-path",
            {
                "zbirenbaum/copilot-cmp",
                config = function()
                    require("copilot_cmp").setup()
                end,
                cond = function()
                    return os.getenv("OPENAI_API_KEY") ~= nil and vim.fn.executable("node") == 1
                end,
            },
        },
        config = function()
            require("plugins.nvim-cmp")
        end,
    },

    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },

    -- linter, formater
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvimtools/none-ls-extras.nvim",
        },
        config = function()
            require("lsp.null-ls")
        end,
    },

    -- note manager
    {
        "nvim-orgmode/orgmode",
        event = "VeryLazy",
        ft = { "org" },
        config = function()
            require("plugins.orgmode")
        end,
    },

    -- treesitter syntax
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        config = function()
            require("plugins.treesitter")
        end,
    },

    -- Comment code
    {
        "numToStr/Comment.nvim",
        config = function()
            require("plugins.Comment")
        end,
    },

    -- align text with ga=
    {
        "junegunn/vim-easy-align",
        config = function()
            -- Start interactive EasyAlign in visual mode (e.g. vipga)
            vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", {})
            -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
            vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {})
        end,
    },

    -- Add git related info in the signs columns and popups
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.gitsigns")
        end,
        cond = function()
            return vim.fn.isdirectory(".git") == 1
        end,
    },

    -- vim-tmux-navigation
    {
        "alexghergh/nvim-tmux-navigation",
        config = function()
            local nvim_tmux_nav = require("nvim-tmux-navigation")

            nvim_tmux_nav.setup({
                disable_when_zoomed = true, -- defaults to false
            })

            vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
            vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
            vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
            vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
        end,
    },

    {
        "ellisonleao/gruvbox.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- setup must be called before loading the colorscheme
            -- Default options:
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
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "", -- can be "hard", "soft" or empty string
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
        -- cmd = "Telescope",
        init = function()
            require("plugins.telescope_map")
        end,
        config = function()
            require("plugins.telescope")
        end,
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
    },

    -- better quickfix
    {
        "kevinhwang91/nvim-bqf",
        config = function()
            require("plugins.nvim-bqf")
        end,
        ft = "qf",
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("plugins.indent-blankline")
        end,
    },

    {
        "chrisbra/csv.vim",
        ft = "csv",
    },
    {
        "zbirenbaum/copilot.lua",
        cond = function()
            return os.getenv("OPENAI_API_KEY") ~= nil and vim.fn.executable("node") == 1
        end,
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = false,
                    auto_refresh = true,
                },
                suggestion = {
                    enabled = false,
                    -- use the built-in keymapping for "accept" (<M-l>)
                    auto_trigger = true,
                    accept = false, -- disable built-in keymapping
                },
            })

            -- hide copilot suggestions when cmp menu is open
            -- to prevent odd behavior/garbled up suggestions
            local cmp_status_ok, cmp = pcall(require, "cmp")
            if cmp_status_ok then
                cmp.event:on("menu_opened", function()
                    vim.b.copilot_suggestion_hidden = true
                end)

                cmp.event:on("menu_closed", function()
                    vim.b.copilot_suggestion_hidden = false
                end)
            end
        end,
    },
    {
        -- "David-Kunz/gen.nvim",
        dir = "/Users/chiendo97/Source/demo/gen.nvim",
        config = function()
            require("plugins.gen")
        end,
    },
    {
        "stevearc/oil.nvim",
        cmd = "Oil",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
        "garymjr/nvim-snippets",
        opts = {
            create_cmp_source = true,
            friendly_snippets = true,
        },
        dependencies = {
            "rafamadriz/friendly-snippets",
            "hrsh7th/nvim-cmp",
        },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
})
