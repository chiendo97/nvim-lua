local cmd = vim.cmd -- execute Vim commands
local exec = vim.api.nvim_exec -- execute Vimscript
local g = vim.g -- global variables
local o = vim.o -- global options
local b = vim.bo -- buffer-scoped options
local w = vim.wo -- windows-scoped options
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
opt.formatoptions:remove {"r", "c", "o"}
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

local function Dirname()
  if vim.fn.getcwd() == '/' then
    return 'ROOT'
  elseif vim.fn.getcwd() == '$HOME' then
    return 'HOME'
  else
    return vim.fn.toupper(vim.fn.fnamemodify(vim.fn.getcwd(), ':t'))
  end
end

local stl = {
  Dirname(),
  ' ',
  '|',
  ' %<%f%m%r%h%w',
  '%=',
  ' %02v ',
  '|',
  ' %l:%c',
  ' %p%% ',
}
o.statusline = table.concat(stl)

function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end

function _G.Tabline()
  local s = ''
  for tab = 1, vim.fn.tabpagenr('$') do
    local winnr = vim.fn.tabpagewinnr(tab)
    local buflist = vim.fn.tabpagebuflist(tab)
    local bufnr = buflist[winnr]
    local bufname = vim.fn.bufname(bufnr)
    local bufmodified = vim.fn.getbufvar(bufnr, "&mod")

    s = s .. '%' .. tab .. 'T'
    s = s .. (tab == vim.fn.tabpagenr() and '%#TabLineSel#' or '%#TabLine#')
    s = s .. ' ' .. tab ..'.'
    s = s .. (bufname ~= '' and '['.. vim.fn.fnamemodify(bufname, ':t') .. ']' or '[No Name]')
    s = s .. (bufmodified ~= 0 and '[+]' or '')
    s = s .. ' %#TabLine#│'

  end

  s = s .. '%#TabLineFill#'
  return s
end

o.tabline = "%!v:lua.Tabline()"

exec([[
" === Autocmd === {{{
if has("autocmd")

  " Disable newline with comment
  augroup newline
    autocmd!
    autocmd BufEnter * set fo-=c fo-=r fo-=o
  augroup END

  " Auto disable syntax with large file
  augroup syntaxoff
    autocmd!
    autocmd Filetype * if getfsize(expand("%")) > 100000 | setlocal syntax=OFF | endif
  augroup END

  " Back to line
  augroup line
    autocmd!
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  augroup END

  " Auto disable folding with large file
  augroup fold
    autocmd!
    autocmd FileType * if getfsize(expand("%")) < 100000 | setlocal foldmethod=marker foldlevel=0 | endif 
    autocmd FileType go if getfsize(expand("%")) < 10000 | setlocal foldmethod=syntax foldlevel=20 | endif 
  augroup END

  " Syntax of these languages is fussy over tabs Vs spaces
  augroup filetype
    autocmd!
    autocmd FileType make       setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml       setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType html       setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css        setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType typescript setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType json       setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType cpp        setlocal ts=4 sts=4 sw=4 noexpandtab smarttab
    autocmd FileType go         setlocal ts=4 sts=4 sw=4 noexpandtab smarttab
    autocmd FileType php        setlocal ts=4 sts=4 sw=4 expandtab smarttab
    autocmd FileType vim        setlocal ts=2 sts=2 sw=2 expandtab smarttab
    autocmd FileType sh         setlocal ts=2 sts=2 sw=2 expandtab smarttab
    autocmd FileType zsh        setlocal ts=2 sts=2 sw=2 expandtab smarttab
    autocmd FileType lua        setlocal ts=2 sts=2 sw=2 expandtab smarttab
    autocmd FileType sql        setlocal ts=4 sts=4 sw=4 expandtab smarttab
    autocmd FileType xml        setlocal ts=2 sts=2 sw=2 expandtab smarttab
    autocmd FileType proto      setlocal ts=4 sts=4 sw=4 noexpandtab smarttab
    autocmd FileType typescriptreact setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType javascriptreact setlocal ts=2 sts=2 sw=2 expandtab
  augroup END

endif
" }}}
]], false)
