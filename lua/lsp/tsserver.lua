local nvim_lsp = require("lspconfig")
local lsp_attach = require("lsp/attach")

nvim_lsp.tsserver.setup({
    root_dir = nvim_lsp.util.root_pattern("tsconfig.json", "jsconfig.json", ".git"),
    on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = false
        client.server_capabilities.documentFormattingProvider = false
        lsp_attach.on_attach(client, bufnr)
    end,
    capabilities = lsp_attach.capabilities,
})
