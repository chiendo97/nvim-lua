local cmd = vim.cmd -- execute Vim commands
local g = vim.g -- global variables
local o = vim.o -- global options
local b = vim.bo -- buffer-scoped options
local opt = vim.opt -- to set options

opt.syntax = 'on'
opt.hidden = true
opt.cmdheight = 2
opt.updatetime = 100
opt.shortmess = 'c'
opt.signcolumn = 'yes'
opt.autoread = true
opt.autowrite = true
o.autochdir = false
opt.ruler = true
opt.showmatch = true
opt.timeoutlen = 1000
opt.ttimeoutlen = 0
o.backup = false
o.wb = false
o.swapfile = false
b.expandtab = true
o.smarttab = true
b.autoindent = true
opt.cindent = true
opt.ts = 4
opt.sts = 4
opt.sw = 4
opt.number = true
opt.relativenumber = true
opt.showcmd = true
opt.showtabline = 2
opt.cursorline = true
opt.wildmenu = true
opt.wildmode = 'longest:full'
opt.lazyredraw = true
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.list = true
cmd [[
set listchars=tab:┆\ 
set listchars+=eol:¬
set listchars+=trail:·,extends:→
]]
opt.backspace = 'indent,eol,start'
opt.wrap = false
opt.formatoptions:remove{"r", "c", "o"}
opt.eb = false
opt.vb = true
opt.mouse = 'a'
opt.sidescrolloff = 30
opt.eol = false
opt.termguicolors = true
opt.background = 'dark'

o.completeopt = "menuone,noselect"

g.gruvbox_flat_style = "dark"
cmd 'colorscheme gruvbox-flat'

function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

require('statusline')
require('tabline')
require('lsp')
require('plugin')
require('plugins')
require('keymaps')
require('autocmd')
