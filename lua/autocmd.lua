local exec = vim.api.nvim_exec -- execute Vimscript

exec(
    [[
if has("autocmd")
  " Back to line
  augroup line
    autocmd!
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  augroup END

augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END
endif
]],
    false
)
