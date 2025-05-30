local util = require("lspconfig.util")

require("lspconfig").gopls.setup({
    root_dir = function(fname)
        return util.root_pattern("go.mod", ".git")(fname) or util.path.dirname(fname)
    end,
    on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = false
        client.server_capabilities.documentFormattingProvider = false
        require("lsp.attach").on_attach(client, bufnr)
    end,
    capabilities = require("lsp.attach").capabilities,
    init_options = {
        usePlaceholders = true,
        linksInHover = false,
        -- allowModfileModifications = true,
        staticcheck = true,
        hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
        },
    },
})
