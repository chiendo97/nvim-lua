local null_ls = require('null-ls')

local sources = {
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.golines,
    null_ls.builtins.formatting.gofumpt
}

null_ls.config({sources = sources})

require('lspconfig')['null-ls'].setup({
    on_attach = require('lsp.attach').on_attach
})
