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
        "yioneko/nvim-cmp",
        branch = "perf-up",
        lazy = true,
        config = function()
            require("plugins.nvim-cmp")
        end,
    },
    { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
    { "hrsh7th/cmp-buffer", event = "InsertEnter" },
    { "hrsh7th/cmp-nvim-lsp-signature-help", event = "InsertEnter" },
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
            create_cmp_source = true,
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
        ft = { "md" },
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
                mode = "",
                desc = "Format buffer",
            },
        },
        -- This will provide type hinting with LuaLS
        ---@module "conform"
        ---@type conform.setupOpts
        opts = {
            -- Define your formatters
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                typst = { "typstfmt" },
                bash = { "shfmt" },
                go = { "gofumpt", "goimports", "golines" },
                yaml = { "yamlfmt" },
                ledger = { "hledger" },
            },
            -- Set default options
            default_format_opts = {
                lsp_format = "fallback",
            },
            -- Customize formatters
            formatters = {
                shfmt = {
                    prepend_args = { "-i", "2" },
                },
                hledger = {
                    -- This can be a string or a function that returns a string.
                    -- When defining a new formatter, this is the only field that is required
                    command = "hledger",
                    -- A list of strings, or a function that returns a list of strings
                    -- Return a single string instead of a list to run the command in a shell
                    args = {
                        "-c",
                        "1,000.0 vnd",
                        "-c",
                        "1,000.00 sgd",
                        "-f-",
                        "print",
                    },
                    -- Send file contents to stdin, read new contents from stdout (default true)
                    -- When false, will create a temp file (will appear in "$FILENAME" args). The temp
                    -- file is assumed to be modified in-place by the format command.
                    stdin = true,
                    -- When cwd is not found, don't run the formatter (default false)
                    require_cwd = false,
                },
            },
        },
        init = function()
            -- If you want the formatexpr, here is the place to set it
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
})

-- To load all integrations at once
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
    dofile(vim.g.base46_cache .. v)
end
