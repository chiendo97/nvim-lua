local nvim_lsp = require('lspconfig')
local util = require "lspconfig/util"

nvim_lsp.gopls.setup {
    root_dir = function(fname)
        return util.root_pattern('go.mod', '.git')(fname) or
                   util.path.dirname(fname)
    end,
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        require('lsp/attach').on_attach(client, bufnr)
    end,
    capabilities = require('lsp/attach').capabilities,
    init_options = {
        usePlaceholders = true,
        linksInHover = false,
        allowModfileModifications = true
    }
}
