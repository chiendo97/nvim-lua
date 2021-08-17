-- vim.lsp.set_log_level("debug")
require('lsp.gopls')
require('lsp.lua')
require('lsp.efm')
require('lsp.tsserver')
require('lsp.python')

require'lspconfig'.yamlls.setup {
    on_attach = require('lsp.attach').on_attach,
    capabilities = require('lsp.attach').capabilities
}

require'lspconfig'.clangd.setup {
    on_attach = require('lsp.attach').on_attach,
    capabilities = require('lsp.attach').capabilities
}

require'lspconfig'.rust_analyzer.setup {
    on_attach = require('lsp.attach').on_attach,
    capabilities = require('lsp.attach').capabilities
}
