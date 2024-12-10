local nvim_lsp = require("lspconfig")
local lsp_attach = require("lsp/attach")

nvim_lsp.ts_ls.setup({
    on_attach = lsp_attach.on_attach,
    capabilities = lsp_attach.capabilities,
})
