vim.cmd([[
command! -nargs=* -range GoAddTag call luaeval("require('go.tags').add(_A.line1, _A.line2, _A.count, _A.args)",{'line1':<line1>, 'line2':<line2>, 'count':<count>, 'args':[<f-args>]})
]])
vim.cmd([[
command! -nargs=* -range GoRmTag call luaeval("require('go.tags').rm(_A.line1, _A.line2, _A.count, _A.args)",{'line1':<line1>, 'line2':<line2>, 'count':<count>, 'args':[<f-args>]})
]])
vim.cmd([[command! GoClearTag lua require("go.tags").clear()]])
