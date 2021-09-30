vim.cmd([[packadd packer.nvim]])

local map = vim.api.nvim_set_keymap
map("n", "<leader>pi", "<cmd>PackerInstall<cr>", {})
map("n", "<leader>ps", "<cmd>PackerSync<cr>", {})
map("n", "<leader>pc", "<cmd>PackerCompile<cr>", {})
map("n", "<leader>pt", "<cmd>PackerStatus<cr>", {})
map("n", "<leader>pd", "<cmd>PackerClean<cr>", {})

return require("packer").startup(function(use)
    -- Packer can manage itself as an optional plugin
    use({ "wbthomason/packer.nvim", opt = true })

    use({ "tweekmonster/startuptime.vim", cmd = "StartupTime" })

    -- add packages

    use({ "nvim-lua/plenary.nvim" })

    -- nvim-tree
    use({
        "kyazdani42/nvim-tree.lua",
        requires = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("plugins.nvim-tree")
        end,
    })

    -- lspconfig
    use({
        "neovim/nvim-lspconfig",
        config = function()
            require("lsp")
        end,
    })

    -- lsp autocomplete
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp", -- lsp source
            "hrsh7th/cmp-nvim-lua", -- neovim's Lua runtime API such vim.lsp.* source
            "hrsh7th/cmp-path", -- path source
            "hrsh7th/cmp-vsnip", -- vsnip source
            "hrsh7th/vim-vsnip", -- snippet
        },
        config = function()
            require("plugins.nvim-cmp")
        end,
    })

    -- go vscode snippet
    use("rafamadriz/friendly-snippets")

    -- add brackets
    use("machakann/vim-sandwich")

    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("lsp.null-ls")
        end,
        requires = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
        },
    })

    use({
        "kristijanhusak/orgmode.nvim",
        branch = "tree-sitter",
        config = function()
            require("plugins.orgmode")
        end,
        after = "nvim-treesitter",
    })

    -- treesitter syntax
    use({
        "nvim-treesitter/nvim-treesitter",
        branch = "0.5-compat",
        event = "BufRead",
        run = ":TSUpdate",
        config = function()
            require("plugins.treesitter")
        end,
    })

    -- align text with ga=
    use({
        "junegunn/vim-easy-align",
        config = function()
            -- Start interactive EasyAlign in visual mode (e.g. vipga)
            vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", {})
            -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
            vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {})
        end,
    })

    -- Preview markdown live: :MarkdownPreview
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        ft = "markdown",
        cmd = "MarkdownPreview",
    })

    -- Add git related info in the signs columns and popups
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.gitgutter")
        end,
        cond = function()
            return vim.fn.isdirectory(".git") == 1
        end,
    })

    use({
        "tpope/vim-fugitive",
        cond = function()
            return vim.fn.isdirectory(".git") == 1
        end,
    })

    -- vim-tmux-navigation
    use({
        "christoomey/vim-tmux-navigator",
        config = function()
            vim.g.tmux_navigator_disable_when_zoomed = 1
        end,
    })

    -- colorscheme
    use({
        "eddyekofo94/gruvbox-flat.nvim",
        config = function()
            vim.opt.termguicolors = true
            vim.opt.background = "dark"

            vim.g.gruvbox_flat_style = "hard"
            vim.g.gruvbox_sidebars = { "qf", "vista_kind", "terminal", "packer" }
            vim.g.gruvbox_hide_inactive_statusline = true
            vim.cmd("colorscheme gruvbox-flat")
        end,
    })

    use({
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        setup = function()
            require("plugins.telescope_map")
        end,
        config = function()
            require("plugins.telescope")
        end,
        requires = {
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-fzy-native.nvim" },
        },
    })

    -- comment
    use({
        "b3nj5m1n/kommentary",
        event = "BufRead",
        config = function()
            vim.g.kommentary_create_default_mappings = false
            vim.api.nvim_set_keymap("n", "<C-_>", "<Plug>kommentary_line_default", {})
            vim.api.nvim_set_keymap("v", "<C-_>", "<Plug>kommentary_visual_default", {})
        end,
    })

    -- generate go test
    use({ "buoto/gotests-vim", ft = "go" })

    -- better quickfix
    use({
        "kevinhwang91/nvim-bqf",
        config = function()
            require("plugins.nvim-bqf")
        end,
        ft = "qf",
    })

    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("plugins.indent-blankline")
        end,
    })

    use({
        vim.fn.stdpath("config") .. "/lua/go-tag",
        config = function()
            require("go-tag")
        end,
        ft = "go",
    })
end)
