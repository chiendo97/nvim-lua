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
            "hrsh7th/cmp-path", -- path source
            "hrsh7th/cmp-vsnip", -- vsnip source
            "hrsh7th/vim-vsnip", -- snippet engine
        },
        config = function()
            require("plugins.nvim-cmp")
        end,
    })

    -- go vscode snippet
    use({
        "rafamadriz/friendly-snippets",
        ft = "go",
    })

    -- add brackets
    use({ "machakann/vim-sandwich" })

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
        "nvim-orgmode/orgmode",
        config = function()
            require("plugins.orgmode")
        end,
        after = "nvim-treesitter",
    })

    -- treesitter syntax
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("plugins.treesitter")
        end,
    })

    use({
        "numToStr/Comment.nvim",
        config = function()
            require("plugins.Comment")
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
            require("plugins.gitsigns")
        end,
        cond = function()
            return vim.fn.isdirectory(".git") == 1
        end,
    })

    use({
        "tpope/vim-fugitive",
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
        "ellisonleao/gruvbox.nvim",
        requires = { "rktjmp/lush.nvim" },
        config = function()
            vim.g.gruvbox_bold = 1
            vim.g.gruvbox_italic = 1
            vim.g.gruvbox_italicize_comments = 1

            vim.o.background = "dark" -- or "light" for light mode
            vim.cmd([[colorscheme gruvbox]])
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
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        },
    })

    -- generate go test
    use({
        "buoto/gotests-vim",
        ft = "go",
        cmd = "GoTests",
    })

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

    use({
        "NTBBloodbath/rest.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        ft = "http",
        config = function()
            require("rest-nvim").setup({
                -- Open request results in a horizontal split
                result_split_horizontal = false,
                -- Skip SSL verification, useful for unknown certificates
                skip_ssl_verification = false,
                -- Highlight request on run
                highlight = {
                    enabled = true,
                    timeout = 150,
                },
                -- Jump to request line on run
                jump_to_request = false,
            })
            vim.api.nvim_set_keymap("n", "<C-g>", "<Plug>RestNvim", {})
        end,
    })
end)
