local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
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
        dependencies = { "kyazdani42/nvim-web-devicons" },
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
            "L3MON4D3/LuaSnip",
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
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("lsp.null-ls")
        end,
    },

    -- note manager
    {
        "nvim-orgmode/orgmode",
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

    -- Preview markdown live: :MarkdownPreview
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        cmd = "MarkdownPreview",
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

    -- colorscheme https://www.reddit.com/r/neovim/comments/nkqkdy/gruvbox_flat_colorscheme_written_in_lua_with/
    {
        "eddyekofo94/gruvbox-flat.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        cond = false,
        config = function()
            -- Example config in Lua
            vim.g.gruvbox_italic_functions = true
            vim.g.gruvbox_sidebars = { "qf", "vista_kind", "terminal", "packer" }

            -- Change the "hint" color to the "orange" color, and make the "error" color bright red
            vim.g.gruvbox_colors = { hint = "orange", error = "#ff0000" }

            -- Change the TabLineSel highlight group (used by barbar.nvim) to the "orange" color
            vim.g.gruvbox_theme = { TabLineSel = { bg = "orange" } }
            vim.g.gruvbox_flat_style = "dark"

            -- Load the colorscheme
            vim.cmd([[colorscheme gruvbox-flat]])
        end,
    },
    -- "loctvl842/monokai-pro.nvim",
    {
        "loctvl842/monokai-pro.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("monokai-pro").setup({
                transparent_background = false,
                terminal_colors = true,
                devicons = true, -- highlight the icons of `nvim-web-devicons`
                styles = {
                    comment = { italic = true },
                    keyword = { italic = true }, -- any other keyword
                    type = { italic = true }, -- (preferred) int, long, char, etc
                    storageclass = { italic = true }, -- static, register, volatile, etc
                    structure = { italic = true }, -- struct, union, enum, etc
                    parameter = { italic = true }, -- parameter pass in function
                    annotation = { italic = true },
                    tag_attribute = { italic = true }, -- attribute of tag in reactjs
                },
                filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
                -- Enable this will disable filter option
                day_night = {
                    enable = false, -- turn off by default
                    day_filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
                    night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
                },
                inc_search = "background", -- underline | background
                background_clear = {
                    "float_win",
                    "toggleterm",
                    "telescope",
                    -- "which-key",
                    "renamer",
                    "notify",
                    -- "nvim-tree",
                    -- "neo-tree",
                    -- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
                }, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
                plugins = {
                    indent_blankline = {
                        context_highlight = "default", -- default | pro
                        context_start_underline = false,
                    },
                },
                ---@param c Colorscheme
                override = function(c) end,
            })

            vim.cmd([[colorscheme monokai-pro]])
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        init = function()
            require("plugins.telescope_map")
        end,
        config = function()
            require("plugins.telescope")
        end,
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
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
        config = function()
            require("plugins.indent-blankline")
        end,
    },

    {
        "NTBBloodbath/rest.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        ft = "http",
        config = function()
            require("plugins.rest")
        end,
    },

    {
        "chrisbra/csv.vim",
        ft = "csv",
    },
})
