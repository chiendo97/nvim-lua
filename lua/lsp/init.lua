-- vim.lsp.set_log_level("debug")
-- require("vim.lsp.log").set_format_func(vim.inspect)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

vim.diagnostic.config({
    float = {
        format = function(diagnostic)
            return string.format("%s (%s)", diagnostic.message, diagnostic.source)
        end,
        border = "single",
    },
})

require("lspconfig.ui.windows").default_options = { border = "single" }

require("lsp.gopls")
-- require("lsp.sumneko")
-- require("lsp.tsserver")
require("lsp.pyright")

-- require("lspconfig").yamlls.setup({
--     on_attach = require("lsp.attach").on_attach,
--     capabilities = require("lsp.attach").capabilities,
-- })

require("lspconfig").rust_analyzer.setup({
    on_attach = require("lsp.attach").on_attach,
    capabilities = require("lsp.attach").capabilities,
})

require("lspconfig").ruff_lsp.setup({
    init_options = {
        settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
            lint = {
                args = {
                    "--select",
                    "E",
                },
            },
        },
    },
    on_attach = require("lsp.attach").on_attach,
    capabilities = require("lsp.attach").capabilities,
})

require("lspconfig").bashls.setup({
    on_attach = require("lsp.attach").on_attach,
    capabilities = require("lsp.attach").capabilities,
})
