local map = vim.api.nvim_set_keymap

require('plugins/emmet')
require('plugins/fzf')
require('plugins/git_messenger')
require('plugins/gitgutter')
require('plugins/mkpreview')
require('plugins/nvim_compe')
require('plugins/tree')
require('plugins/treesitter')
require('plugins/vim-go')
require('plugins/vimwiki')
require('plugins/winresizer')
require('plugins/kommentary')

map('x', 'ga', '<Plug>(EasyAlign)', {})

require'colorizer'.setup()
require('bqf').setup({func_map = {openc = '<esc>'}})

-- Disable tmux navigator when zooming the Vim pane
vim.g.tmux_navigator_disable_when_zoomed = 1
