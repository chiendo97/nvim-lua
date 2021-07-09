-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim'}

    -- add packages

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'}
    }

    use 'neovim/nvim-lspconfig'

    use 'hrsh7th/nvim-compe'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    use 'golang/vscode-go'

    use 'machakann/vim-sandwich'

    -- 'treesitter syntax
    use 'nvim-treesitter/nvim-treesitter'

    -- 'show git commit
    use 'rhysd/git-messenger.vim'

    -- 'align text ga=
    use 'junegunn/vim-easy-align'

    -- 'Preview markdown live: :Mark
    use 'iamcco/markdown-preview.nvim'

    -- 'Vim plugin that provides additional text objects
    use 'wellle/targets.vim'

    -- 'Some Git stuff
    use 'airblade/vim-gitgutter'
    use 'tpope/vim-fugitive'

    -- 'vim-tmux-navigation
    use 'christoomey/vim-tmux-navigator'

    -- 'colorscheme
    use 'eddyekofo94/gruvbox-flat.nvim'

    -- 'resize vim windows with ctrl + T
    use 'simeji/winresizer'

    -- 'find file with name"
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'ojroques/nvim-lspfuzzy'

    -- 'Syntax and languages
    use 'mattn/emmet-vim'
    use 'norcalli/nvim-colorizer.lua'

    -- 'comment
    use 'b3nj5m1n/kommentary'

    use 'fatih/vim-go'

    use 'buoto/gotests-vim'

    use 'kevinhwang91/nvim-bqf'

    use 'ray-x/lsp_signature.nvim'

end)
