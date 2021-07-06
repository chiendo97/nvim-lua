require('plugins/emmet')
require('plugins/fzf')
require('plugins/git_messenger')
require('plugins/gitgutter')
require('plugins/lspfzf')
require('plugins/mkpreview')
require('plugins/nerdcomment')
require('plugins/nvim_compe')
require('plugins/tree')
require('plugins/treesitter')
require('plugins/vim-go')
require('plugins/vimwiki')
require('plugins/winresizer')

vim.g.kommentary_create_default_mappings = false

vim.api.nvim_set_keymap("n", "<C-_>", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("v", "<C-_>", "<Plug>kommentary_visual_default", {})
